<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="bs/css/bootstrap.min.css">
<link rel="stylesheet" href="bs/bootstrap.min.css">
  <link rel="shortcut icon" href="imge/T5.jpg">

<title>STORE SADMAN</title>
</head>
<body style="background-color:#151816;">
	<script src="bs/js/bootstrap.min.js"></script>
	<%
	if (session.getAttribute("Username") != null) {
		response.sendRedirect("index.jsp");
	}
	%>


	<div class="container-sm"
		style="margin-top: 13rem; width: 600px; height: 80%; background-color: white; border-style: outset;">
		<div class="row">
			<div class="col"></div>
			<form class="col-5 form-signin" action="loginCustomer" method="post">
				<div class="mb-1">
					<p class="fs-4 fw-bold">
						<img src="image/T5.jpg" width="50" height="50" style="border-radius: 25px">
						<strong>Login</strong>
					</p>
				</div>
				<div class="mb-3">
					<input placeholder="Username" type="text" class="form-control"
						id="exampleInputName" aria-describedby="emailHelp" name="user">
				</div>
				<div class="mb-3">
					<input placeholder="Password" type="password" class="form-control"
						id="exampleInputPassword1" name="pass">
				</div>
				<div class="text-center mb-3">
					<button type="submit"
						class="btn btn-outline-primary ms-6 fw-bold text-center"
						style="width: 70%">
						<svg xmlns="http://www.w3.org/2000/svg" width="25" height="30"
							fill="currentColor" class="bi bi-box-arrow-in-right"
							viewBox="0 0 16 16">
 							 <path fill-rule="evenodd"
								d="M6 3.5a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v9a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-2a.5.5 0 0 0-1 0v2A1.5 1.5 0 0 0 6.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-8A1.5 1.5 0 0 0 5 3.5v2a.5.5 0 0 0 1 0v-2z" />
  							 <path fill-rule="evenodd"
								d="M11.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 1 0-.708.708L10.293 7.5H1.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708l3-3z" />
						</svg>
						<strong>Login</strong>
					</button>
				</div>
				<div class="" align="right">
					<label class="text-muted text-bold">|</label> <label
						class="text-muted " style="font-size: 14px"><strong>SignUp</strong></label>
					<a href="register.jsp" class="card-link " style="color: orange">สมัครสมาชิก</a>
				</div>
			</form>
			<div class="col"></div>
		</div>
	</div>
</body>
</html>