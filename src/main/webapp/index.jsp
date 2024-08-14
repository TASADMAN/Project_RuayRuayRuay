<%@page import="database.connectDatabase"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


<title>STORE SADMAN </title>
<%
connectDatabase connectDB = new connectDatabase();
java.sql.Connection connect = connectDB.connect();

ResultSet rec = null;
if (connect != null) {
	Statement s = connect.createStatement();
	String sql = "SELECT * FROM goods ORDER BY goods.id";
	rec = s.executeQuery(sql);

}
%>

<link rel="stylesheet" href="bs/css/bootstrap.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-eOJMYsd53ii+scO/bJGFsiCZc+5NDVN2yr8+0RDqr0Ql0h+rP48ckxlpbzKgwra6" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.bundle.min.js" integrity="sha384-JEW9xMcG8R+pH31jmWH6WWP0WintQrMb4s7ZOdauHnUtxwoG2vI5DkLtS3qm9Ekf" crossorigin="anonymous"></script>
<link rel="stylesheet" href="bs/bootstrap.min.css">
</head>
<body style="background-color:#151816;">
	<!-- Latest compiled and minified CSS -->
	<script type="text/javascript" src="bs/js/bootstrap.min.js"></script>

	
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top"
		style="height: 70px; width: 100%">
		<!-- Content -->
		<div class="container-fluid bg-dark" >
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
						href="Log.jsp" style="margin-top: 6px;">Login</a></li>
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
									type="submit" value="Logout">
							</form>
						</div></li>
					<%
					}
					%>
				</ul>
			</div>
		</div>
	</nav>
	
	<div align="center" style="margin-top: 5rem;">
		<div id="carouselExampleControls" class="carousel slide" data-bs-ride="carousel" style=" height: 40rem; width: 80%; margin: 0;'">
		  <div class="carousel-inner">
		    <div class="carousel-item active">
		      <img src="image/T1.jpg" class="d-block" style="height: 40rem; width: 80%" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="image/T2.jpg" class="d-block" style="height: 40rem; width: 80%" alt="...">
		    </div>
		     <div class="carousel-item">
		      <img src="image/T3.jpg" class="d-block" style="height: 40rem; width: 80%" alt="...">
		    </div>
		    <div class="carousel-item">
		      <img src="image/T4.jpg" class="d-block" style="height: 40rem; width: 80%" alt="...">
		    </div>
		  </div>
		  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
		    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Previous</span>
		  </button>
		  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
		    <span class="carousel-control-next-icon" aria-hidden="true"></span>
		    <span class="visually-hidden">Next</span>
		  </button>
		</div>
	</div>

	<div class="container-sm" style="margin-top: 3rem">
		<h3 class="text-muted fw-bold">Products</h3>
		<hr class="mt-1">
	</div>
	<div align="center">
		<div class="container-sm row row-cols-1 row-cols-md-3 g-4 mt-4"
			style="margin: 0;">
			<%
			while ((rec != null) && (rec.next())) {
			%>
			<div class="col text-left mt-3">
				<div class="card">
					<div class="card-body" style="height: 16rem;">
						<h4 class="card-title text-center"><%=rec.getString("name")%></h5>
							<h6 class="card-subtitle mb-2 text-muted text-center">
								price 
								$<%=rec.getString("price")%>
								
							</h6>
							<p class="card-text"><%=rec.getString("description")%></p>
							<%
							if (session.getAttribute("Username") == null) {
							%>

							<div>
								<form action="login.jsp"">
									<hr class="">
									<label><strong>Choose Quantity</strong></label> <input type="number"
										style="width: 5rem" name="addNumber" id="addnumber"><input
										type="hidden" id="idStudent" name="idGoods"
										value="<%=rec.getLong("id")%>" />
									<button type="submit" class="btn btn-warning "
										style="margin-bottom: 4px;"><h6>Buy</h6></button>
								</form>
							</div>
							<%
							} else {
							%>
							<form action="addGoods" method="post">
								<hr class="">
								<label><strong> Choose Quantity </strong></label> <input type="number"
									style="width: 5rem" name="addNumber"><input
									type="hidden" id="idStudent" name="idGoods"
									value="<%=rec.getLong("id")%>" />
								<button type="submit" class="btn btn-warning"
									style="margin-bottom: 4px;" id="BtnaddGoods"><h6>Buy</h6></button>
							</form>
							<%
							}
							%>
						
					</div>
				</div>
			</div>
			<%
			}
			%>
		</div>
	</div>
	<div  class="form-text mt-2">
 	  create by Thaksin Noibbuddee @2023| SADMAN
	</div>
</body>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js" integrity="sha384-SR1sx49pcuLnqZUnnPwx6FCym0wLsk5JZuNx2bPPENzswTNFaQU1RDvt3wT4gWFG" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js" integrity="sha384-j0CNLUeiqtyaRmlzUHCPZ+Gy5fQu0dQ6eZ/xAww941Ai1SxSY+0EQqNXNE6DZiVc" crossorigin="anonymous"></script>
</html>