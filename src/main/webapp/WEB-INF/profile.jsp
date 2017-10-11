<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
        <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Profile</title>
</head>
<body>
	<form id="logoutForm" method="POST" action="/logout">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	    <button class="w3-btn w3-white w3-border w3-round-large" type="submit">Logout</button>
	</form>
	<h1>Welcome, ${currentUser.firstName}</h1>
	<p> <strong>Current package:</strong> ${currentUser.p.name}</p>
	<p> <strong>Next due date:</strong> ${currentUser.subscription.due}</p>
	<p> <strong>Ammount:</strong> ${currentUser.p.cost}</p>
	<p> <strong>user since: </strong> ${currentUser.createdAt}</p>
</body>
</html>