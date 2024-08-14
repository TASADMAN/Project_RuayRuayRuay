<%@page import="database.connectDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="bs/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<link rel="stylesheet" href="bs/bootstrap.min.css">

  <link rel="shortcut icon" href="imge/T5.jpg">
<meta charset="UTF-8">
<title>STORE SADMAN</title>
</head>
<body>
<script type="text/javascript"
		src="https://www.gstatic.com/charts/loader.js"></script>
	<script src="bs/js/bootstrap.min.js"></script>
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


		

	<%
	connectDatabase connectDB = new connectDatabase();
	java.sql.Connection connect = connectDB.connect();

	ResultSet rec = null;
	if (connect != null) {
		Statement s = connect.createStatement();
		String sql = "SELECT * FROM goods ORDER BY goods.id";
		rec = s.executeQuery(sql);

	}

	int num = 1;
	%>

	<script type="text/javascript">
		google.charts.load('current', {
			packages : [ 'corechart', 'bar' ]
		});
		google.charts.setOnLoadCallback(drawBasic);

		function drawBasic() {

			var data = google.visualization.arrayToDataTable([
					[ 'Element', 'จำนวนชิ้น', {
						role : 'style'
					} ], 
					<%
					while ((rec != null) && (rec.next())) {
					%>
					[ '<%=rec.getString("name")%>', <%=rec.getInt("stock")%>, '#B86E47' ], 
					<%
					num = num + 1;
					}
					%>
			]);
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
			var options = {
				title : 'รายงานรายการสินค้าคงเหลือ',
				hAxis : {
					title : 'Sadman product',
					format : 'h:mm a',
					viewWindow : {
						min : [ 7, 30, 0 ],
						max : [ 17, 30, 0 ]
					}
				},

			};

			var chart = new google.visualization.ColumnChart(document
					.getElementById('chart_div'));

			chart.draw(data, options);
		}
	</script>

	<div class="container-sm" style="width: 80%; margin-top: 5rem">
		<div id="chart_div"></div>
	</div>

	<%
	connectDatabase ConnectDB = new connectDatabase();
	java.sql.Connection Connect = ConnectDB.connect();

	ResultSet re = null;

	if (Connect != null) {
		Statement ss = Connect.createStatement();
		String sql = "SELECT * FROM goods";
		re = ss.executeQuery(sql);

	}

	int nums = 1;
	%>
	<div class="container-sm " align="center" style="margin-top: 5rem" style="background-color: #151816;">
		<div align="center">
			<h2 style="margin-left: 5rem">Table Product Balance</h2>
		</div>
		<div align="center">
			<table class="table text-center" style="width: 70%">
				<thead>
					<tr>
						<th scope="col">#</th>
						<th scope="col">Product</th>
						<th scope="col">price[$]</th>
						<th scope="col">stock</th>
					</tr>
				</thead>
				<tbody>
					<%
					while ((re != null) && (re.next())) {
					%>
					<tr>
						<th scope="row"><%=nums%></th>
						<td><%=re.getString("name")%></td>
						<td><%=re.getDouble("price")%></td>
						<td><%=re.getInt("stock")%></td>
					</tr>
					<%
					nums = nums + 1;
					}
					%>
				</tbody>
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

</html>