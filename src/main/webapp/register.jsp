<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>STORE SADMAN</title>
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="bs/css/bootstrap.min.css">
<link rel="stylesheet" href="bs/bootstrap.min.css">
  <link rel="shortcut icon" href="favicon.png">
</head>
<body style="background-color:#151816;">
	<div class="container-sm" style="margin-top: 5rem">
		<div class="row">
			<div class="col"></div>
			<form class="col-5" action="addCustomer" method="post">
				<div class="mb-3">
					<p class="fs-4 fw-bold text-center">SignUp</p>
				</div>
				<div class="mb-3">
					<input placeholder="Username" type="text" class="form-control"
						id="exampleInputName" aria-describedby="emailHelp" name="user">
				</div>
				<div class="mb-3">
					<input placeholder="Password" type="password" class="form-control"
						id="exampleInputPassword1" name="pass">
				</div>
				<div class="mb-3">
					<input type="text" class="form-control" name="name"
						placeholder="First and Last name">
				</div>
				<div class="mb-3">
					<textarea class="form-control" id="exampleFormControlTextarea1"
						rows="3" name="address" placeholder="Address"></textarea>
				</div>
				<div class="mb-3">
					<input type="tel" id="phone" name="phone" placeholder="Phone"
						pattern="[0]{1}[0-9]{9}" required class="form-control">
				</div>
				<div class="form-group mb-3">
					<input type="email" class="form-control"
						id="exampleFormControlInput1"
						placeholder="E-mail name@example.com" name="email">
				</div>
				<div class="mb-3">
					<a class="btn btn-outline-danger ms-6  text-center"
						href="login.jsp"><h6>back</h6></a>z

					<button type="submit"
						class="btn btn-success btn-lg ms-6 fw-bold text-center"
						style="width: 150px; margin-left: 1rem;">SignUp</button>

				</div>

			</form>
			<div class="col"></div>
		</div>
	</div>

</body>
<script src="bs/js/bootstrap.min.js"></script>
</html>