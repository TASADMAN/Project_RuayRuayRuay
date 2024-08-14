
<%@page import="database.connectDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="bs/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<link rel="stylesheet" href="bs/bootstrap.min.css">
  <link rel="shortcut icon" href="imge/T5.jpg">
<title>STORE SADMAN</title>

</head>
<body>
	<!-- test -->
	<%
	connectDatabase connectDB = new connectDatabase();
	java.sql.Connection connect = connectDB.connect();
	Statement s = null;
	ResultSet rec = null;
	if (connect != null) {
		s = connect.createStatement();
		String sql = "SELECT * FROM receipt_detalis INNER JOIN goods ON receipt_detalis.good_id = goods.id WHERE receipt_detalis.rec_id="
		+ request.getSession().getAttribute("idRec");
		rec = s.executeQuery(sql);

	}
	%>
	<%
	if (session.getAttribute("Username") == null) {
		response.sendRedirect("index.jsp");
	}
	%>

	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"
		style="height: 70px; width: 100%">
		<!-- Content -->
		<div class="container-fluid bg-dark" style="width: 100%">
			<!-- Brand -->
			<a href="index.jsp" class="navbar-brand fs-3 fw-bold">STORE SADMAN</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
				aria-controls="navbarSupportedContent" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarSupportedContent">

				<ul class="navbar-nav bg-dark ml-auto">

					<%
					if (session.getAttribute("Username") == null) {
					%>
					<li class="nav-item container-sm"><a
						class="btn btn-outline-success me-2" aria-current="page"
						href="login.jsp" style="margin-top: 6px;">Login</a></li>
					<%
					} else {
					%>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="basket.jsp">Shopping cart</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="ReportSotock.jsp">Product balance</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="ReportRecDeta.jsp">Product sales</a></li>
					<li class="nav-item"><a class="nav-link" aria-current="page"
						href="ReportRec.jsp">Purchase order</a></li>


					<li class="nav-item"><a class="nav-link disabled me-2"
						href="#" tabindex="-1" aria-disabled="true">Member:
							${Username}</a></li>
					<li class="nav-item"><div>

							<form action="logoutCustomer">
								<input
									class="btn btn-outline-danger me-2 d-grid gap-2 d-md-flex justify-content-md-end"
									type="submit"  value="Logout">
							</form>
						</div></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>


	<div class="container-sm " align="center" style="margin-top: 5rem;">
		<div align="center">
			<h2 style="">Cart</h2>
		</div>
		<div align="center">
			<table
				class="table table-dark table-borderless table-hover table-striped text-center"
				style="width: 70%">
				<thead>
					<tr>
						<th scope="col">Name Product</th>
						<th scope="col">Price[$]</th>
						<th scope="col">Count</th>
						<th scope="col">Amount[$]</th>
						<th scope="col" id="buttonTh"></th>
					</tr>
				</thead>
				<tbody>
					<%
					if (request.getSession().getAttribute("checkBuy").equals("2")) {
						while ((rec != null) && (rec.next())) {
					%>
					<tr class="table-active">
						<th scope="row"><%=rec.getString("name")%></th>
						<td class=""><%=rec.getString("price")%></td>
						<td><%=rec.getString("qua")%></td>
						<td><%=rec.getString("amount")%></td>
						<td>
							<form action="deleteGoods" method="post">
								<input type="hidden" value="<%=rec.getString("qua")%>"
									name="numberGoods"> <input type="hidden"
									value="<%=rec.getString("good_id")%>" name="Goods_id">
								<input type="hidden" value="<%=rec.getString("amount")%>"
									name="amountGoods"> <input type="hidden"
									value="<%=rec.getString("id")%>" name="deleteIdGoods">
								<input type="submit" class="btn btn-outline-danger"
									value="CANCEL	">
							</form>
						</td>
					</tr>
					<%
					}
					String sql = "SELECT SUM(receipt_detalis.amount) amount FROM receipt_detalis WHERE receipt_detalis.rec_id = "
							+ request.getSession().getAttribute("idRec");
					rec = s.executeQuery(sql);
					rec.next();
					%>
				</tbody>
				<%
				if (rec.getString("amount") != null) {
				%>
				<tbody>
					<tr>
						<td colspan="5"
							class="table-active table-secondary text-right fw-bold"
							style="height: 3.5rem;">TOTAL <%=rec.getString("amount")%>$
							
						</td>
					</tr>
				</tbody>
				<tbody>
					<tr>
						<td colspan="5"
							class="table-active table-light text-right fw-bold"
							style="height: 3.5rem;">
							<form action="updateStock" method="post">
								<a href="index.jsp" class="btn btn-dark"><strong>Back</strong></a> <input
									type="submit" class="btn btn-success"
									value="ORDER">
							</form>
						</td>
					</tr>
				</tbody>
				<%
				} else {
				%>
				<tbody>
					<tr>
						<td colspan="5"
							class="table-active table-secondary text-center fw-bold"
							style="height: 3.5rem;">You haven't selected
							 any products yet.
							<p class="mt-1 d-grid gap-2">
								<a href="index.jsp" class="btn btn-dark "><h1>Back</h1></a>
							</p>
						</td>

					</tr>
					<tr>
				</tbody>
				<%
				}
				} else {
				%>
				<tbody>
					<tr>
						<td colspan="5"
							class="table-active table-secondary text-center fw-bold"
							style="height: 3.5rem;">You haven't selected
							 any products yet.
							<p class="mt-1 d-grid gap-2">
								<a href="index.jsp" class="btn btn-dark "><h1>Back</h1></a>
							</p>
						</td>

					</tr>
					<tr>
				</tbody>
				<%
				}
				%>
			</table>
		</div>
	</div>
	<%
	try {
		if (connect != null) {
			if (!connect.isClosed()) {
		connect.close();
			}
		}

	} catch (SQLException ex) {
		ex.printStackTrace();
	}
	%>


</body>
<script src="bs/js/bootstrap.min.js"></script>
</html>