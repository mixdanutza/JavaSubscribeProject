<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Login Registration</title>
	<link rel="stylesheet" type="text/css" href="css/registration.css">
</head>
<body>
	<div id="wrapper">	
		<div class="formBox" id="loginForm">
		<p><form:errors path="user.*"/></p>
			<p class="success"><c:out value="${success}"/></p>
			<p class="success">
				<c:if test="${logoutMessage != null}">
			    	<c:out value="${logoutMessage}"/>
				</c:if>
			</p>
			<p class="error">
				<c:out value="${error}"/>
			</p>
			
			<h1 class="logintitle">Login to your account</h1>
		    <form method="POST" action="/login">
		        <p>
		            <input id="forminput" class="box" type="email" id="username" name="username" placeholder="Email"/>
		        </p>        					        
		        <p>
		            <input id="forminput" class="box" type="password" id="password" class="password" name="password" placeholder="Password"/>
		        </p>
		        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
		        <input  class="submitButton" type="submit" value="Login!"/>		        
		        <p class="psignup">Don't have an account? &nbsp;<a class="asignup" onClick="showRegisterForm()">Sign up</a></p>		        
		    </form>
		 </div>
		
		<br>

		<div class="formBox" id="registrationForm">
			<h1 class="logintitle">Register</h1>
			<form:form action="/registration" method="POST" modelAttribute="user">
			    <p>
			       	<strong class="error"><form:errors path="firstName"/></strong>  
			        <form:input path="firstName" placeholder="First name"/>	
			    </p>
			    <p>
			        <strong class="error"><form:errors path="lastName"/></strong>  
			        <form:input path="lastName" placeholder="Last name"/>
			    </p>
			    <p>
			        <strong class="error"><form:errors path="username"/></strong>   
			        <form:input path="username" placeholder="Email"/>
			    </p>
			    <p>
			        <strong class="error"><form:errors path="password"/></strong>  
			        <form:input type="password" path="password" class="password" placeholder="Password"/>
			    </p>
			    <p>
			        <strong class="error"><form:errors path="passwordConfirm"/></strong> 
			        <form:input type="password" path="passwordConfirm" class="password"  placeholder="Confirm password"/>
			    </p>
			    <button class="submitButton" type="submit">Register</button>			    
			    <p class="psignup">Already have an account? &nbsp;<a class="asignup" onClick="showLoginForm()">Login</a></p>
			</form:form>
		</div>
	</div>
	
	<!--Scripts-->
	<script type="text/javascript" >
		function showRegisterForm(){
			var log = document.getElementById("loginForm");
			var reg = document.getElementById("registrationForm");			
			log.style.display="none";
			reg.style.display="block";		
		}

		function showLoginForm(){
			var log = document.getElementById("loginForm");
			var reg = document.getElementById("registrationForm");			
			log.style.display="block";
			reg.style.display="none";		
		}
	</script>
</body>
</html>