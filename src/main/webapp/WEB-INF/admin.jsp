<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Page</title>
<link rel="stylesheet" type="text/css" href="css/admin.css"/>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>
<style>
	table {
		border-collapse: collapse;
		width: 100%;
	}

	th, td {
		text-align: left;
		padding: 8px;
	}

	tr:nth-child(even){background-color: #f2f2f2}

	th {
		background-color: #4CAF50;
		color: white;
	}

	.error{
		color:red;
	}
	.formBox{
		margin:0% 40% 0% 40%;
	}
	input[type=text], select {
		width: 100%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		border-radius: 4px;
		box-sizing: border-box;
	}
	input[type=number], select {
		width: 100%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		border-radius: 4px;
		box-sizing: border-box;
	}
	input[type=email], select {
		width: 100%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		border-radius: 4px;
		box-sizing: border-box;
	}
	input[type=password] select {
		width: 100%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		border-radius: 4px;
		box-sizing: border-box;
	}

	input[type=submit] {
		width: 100%;
		background-color: #4CAF50;
		color: white;
		padding: 14px 20px;
		margin: 8px 0;
		border: none;
		border-radius: 4px;
		cursor: pointer;
	}
	.password{
		width: 100%;
		padding: 12px 20px;
		margin: 8px 0;
		display: inline-block;
		border: 1px solid #ccc;
		border-radius: 4px;
		box-sizing: border-box;

	}
	.submitBtn{
		width: 100%;
		background-color: #4CAF50;
		color: white;
		padding: 14px 20px;
		margin: 8px 0;
		border: none;
		border-radius: 4px;
		cursor: pointer;
	}

	input[type=submit]:hover {
		background-color: #45a049;
	}

	div {
		border-radius: 5px;
		background-color: #f2f2f2;
		padding: 20px;
	}
	.success{
		color:green;
	}
</style>
<body>
	<form id="logoutForm" method="POST" action="/logout">
	    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	    <button class="w3-btn w3-white w3-border w3-round-large" type="submit">Logout</button>
	</form>
	<h1> Admin dashboard !</h1>	
	<h2>Customers</h2>
	<table>
	  <tr>
	    <th>Name</th>
	    <th>Next Due Date</th>
	    <th>Amount Due</th>
	    <th>Package Type</th>
	  </tr>
	  <c:forEach items="${allUsers}"  var="user">
		  <tr>
		    <td>${user.firstName} ${user.lastName}</td>
		    <td>Griffin</td>
		    <td>$100</td>
		    <td>Type</td>
		  </tr>
	  </c:forEach>
	</table>
	<hr>
	<h2>Packages</h2>
	<table>
	  <tr>
	    <th>Package Name</th>
	    <th>Package Cost</th>
	    <th>Available</th>
	    <th>Users</th>
	    <th>Actions</th>
	  </tr>
	  <c:forEach items="${allPackages}" var="pack">
		  <tr>
		    <td>${pack.name}</td>
		    <td>${pack.cost} $</td>
		    <td>${pack.available}</td>
		    <td>Type</td>
		    <td>
		    	<c:choose>
					<c:when test="${pack.available==true}">
				    	<form action="/admin/createPackage" method="POST">
				    		<input type="hidden" name="available" value="true">
				    		<button class="w3-btn w3-white w3-border w3-round-large" type="submit">Deactivate</button>
				    	</form>
					</c:when>
					<c:otherwise>
				    	<form action="/admin/createPackage" method="POST">
				    		<input type="hidden" name="available" value="false">
				    		<button class="w3-btn w3-white w3-border w3-round-large" type="submit">Activate</button>
				    	</form>
					</c:otherwise>
				</c:choose>
		    </td>
		  </tr> 
	  </c:forEach>
	</table>	
	<hr>	
	<div class="formBox">
	<p class="success"> <c:out value="${success}"/></p>
		<form:form action="/admin/newPackage" method="POST" modelAttribute="package">
		    <p>
		        Package Name:
		        <strong class="error"><form:errors path="name"/></strong>   
		        <form:input path="name"/>
		    </p>
   		    <p>
		        Package Cost:
		        <strong class="error"><form:errors path="cost"/></strong>   
		        <form:input type="number" path="cost"/>
		    </p>
	   	    <p>  
		        <form:input path="available" type="hidden" value="true"/>
		    </p>
		    <button class="submitBtn" type="submit">Create Package</button>
		</form:form>
	</div>	
</body>
</html>