<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>login_reg</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>


    <!--  Stylesheet -->
    <link href="css/LoginPage.css" rel="stylesheet">
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
	

</head>

<body>

<%
	if (session.getAttribute("Username") != null) {
		response.sendRedirect("index.jsp");
	}
	%>

    <!-- signup from -->
    <div class="container" id="container">
        <div class="form-container sign-up-container">
            <form action="loginCustomer" method="post">
                <h2>Create Account</h2>
                <span>or use your account</span>

           
               <input placeholder="Username" type="text" class="form-control"
						id="exampleInputName" aria-describedby="emailHelp" name="user">
				<input placeholder="Password" type="password" class="form-control"
						id="exampleInputPassword1" name="pass">		              
                <input type="text" class="form-control" name="name"
						placeholder="First and Last name">
       
				<input type="tel" id="phone" name="phone" placeholder="Phone"
						pattern="[0]{1}[0-9]{9}" required class="form-control">
				<input type="email" class="form-control"
						id="exampleFormControlInput1"
						placeholder="E-mail name@example.com" name="email">


                <button type="submit" name="signup">Sign Up</button>
            </form>
        </div>
        <!-- end signup-->

        <!-- loginfrom -->
        <div class="form-container sign-in-container">
            <form action="loginCustomer" method="post">
                <h1>Sign in</h1>
                <div class="social-container">
                    <a href="#" class="social"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="social"><i class="fab fa-google-plus-g"></i></a>
                    <a href="#" class="social"><i class="fab fa-linkedin-in"></i></a>
                </div>
                <span>or use your account</span>

              <input placeholder="Username" type="text" class="form-control"
						id="exampleInputName" aria-describedby="emailHelp" name="user">
                <input placeholder="Password" type="password" class="form-control"
						id="exampleInputPassword1" name="pass">
                <a href="#">Forgot your password?</a>

                <button type="submit" name="signin" class="btn btn-primary">Sign In</button>
            </form>
        </div>
        <div class="overlay-container">
            <div class="overlay">
                <div class="overlay-panel overlay-left">
                    <h1>Welcome Back!</h1>
                    <p>To keep connected with us please login with your personal info</p>
                    <button class="ghost" id="signIn">Sign In</button>
                </div>
                <div class="overlay-panel overlay-right">
                    <h1>Hello, Friend!</h1>
                    <p>New members are welcome, if you are not yet a member, press the button below to apply.</p>
                    <button class="ghost" id="signUp">Sign Up</button>
                </div>
            </div>
        </div>
    </div>

    
    <!-- JavaScript Libraries -->
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
    <script src="lib/easing/easing.min.js"></script>

    <script src="lib/owlcarousel/owl.carousel.min.js"></script>
    <script src="lib/tempusdominus/js/moment.min.js"></script>
    <script src="lib/tempusdominus/js/moment-timezone.min.js"></script>
    <script src="lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

    <!-- Template Javascript -->
    <script src="js/LoginPage.js"></script>


</body>

</html>

