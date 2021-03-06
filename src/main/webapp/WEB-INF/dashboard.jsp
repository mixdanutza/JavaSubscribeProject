<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Dashboard</title>
<link rel="stylesheet" type="text/css" href="css/dashboard.css"/>
</head>
<body>
	<form id="logoutForm" method="POST" action="/logout">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	    <input type="submit" value="Logout!" />
	</form>
	<h1>Welcome to Dojoscriptions, ${currentUser.firstName} !</h1>
	<h3>Please choose a subscription and due date!</h3>
	<p>
		<strong>Roles:</strong>
		<c:forEach items="${currentUser.roles}" var="role"> ${role.name}</c:forEach>
	</p>	
	<div class="formBox">
		<p class="success"> <c:out value="${success}"/></p>
		<form:form action="/newSubscription" method="POST" modelAttribute="subscription">
		    <p>
		        Due date:
		        <strong class="error"><form:errors path="due"/></strong>   
		        <form:input path="due" type="number" min="1" max="31"/>
		    </p>
   		    <p>
		        Package:
		        <strong class="error"><form:errors path="pack"/></strong>   
                <form:select path="pack">
		            <c:forEach items="${packages}" var="p">
		                <form:option value="${p.id}">${p.name} ($ ${p.cost})</form:option>
		            </c:forEach>
		        </form:select>
		    </p>
		    <button class="submitBtn" type="submit">Sign Up!</button>
		</form:form>
	</div>	
</body>
</html>