<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="refresh" content="2; url=${pageContext.request.contextPath}/index.html">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="theme-color" content="#00796B">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>Welcome page</title>
<link href='https://fonts.googleapis.com/css?family=Muli' rel='stylesheet'>

<style>
<jsp:directive.include file="../../css/login-style.css"/>
</style>
</head>
<body>
<div id="header">
	<h1>Welcome in TimeToGo!</h1>
	<h3>You have successfully logged in!</h3><br/>
	<h3 style="color: #000000;">You will be redirect to the Home Page in a few seconds...</h3>
</div>


</body>
</html>