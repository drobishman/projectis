<?xml version="1.0" encoding="ISO-8859-1" ?>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<meta name="theme-color" content="#00796B">
<meta name="viewport" content="width=device-width, height=device-height, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
<title>TimeToGo Login</title>
<link href='https://fonts.googleapis.com/css?family=Muli' rel='stylesheet'>


<style>
<jsp:directive.include file="../../css/login-style.css"/>
</style>
</head>

<body>
<div id="header">
<h1>TimeToGo</h1>
<h3>Web Site to add your POIs</h3>
<c:if test="${error == true}">
	<b class="error">Invalid login or password.</b>
</c:if>
</div>

<form method="post" action="<c:url value='j_spring_security_check'/>">
	<table id="login-form">
		<tbody>
			<tr>
				<td>Login:</td>
				<td>
				<div class="group">
					<input type="text" name="j_username" id="j_username"size="30" maxlength="40" value='' id='uname'>
					<span class="highlight"></span><span class="bar"></span><label>Username</label>
					</input>
				</div>
				</td>
			</tr>
			<tr>
				<td>Password:</td>
				<td>
				<div class="group">
					<input type="password" name="j_password" id="j_password"size="30" maxlength="32"id='pswd'>
					<span class="highlight"></span><span class="bar"></span><label>Password</label>
					</input>
				</div>
				</td>
			</tr>
			<tr>
				<td></td>
				<td><button class="btn" type="submit"><span>Login</span>
						<div class="ripples"><span class="ripplesCircle"></span></div>
					</button></td>
			</tr>
		</tbody>
	</table>
</form>	



<script src="//production-assets.codepen.io/assets/common/stopExecutionOnTimeout-b2a7b3fe212eaa732349046d8416e00a9dec26eb7fd347590fbced3ab38af52e.js"></script>
<script src='//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>

<script>
$(window, document, undefined).ready(function() {
	var filled = false;
	
	if ($('input').val())
		filled=true;
	
	if (filled)
		 $('input').addClass('used');
	 
	  $('input').blur(function() {		  
	    var $this = $(this);
	    if ($this.val()){
	      $this.addClass('used');
	      filled = true;
	    }
	    else{
	      $this.removeClass('used');
	      filled = false;
	    }
	  });

	  var $ripples = $('.ripples');

	  $ripples.on('click.Ripples', function(e) {

	    var $this = $(this);
	    var $offset = $this.parent().offset();
	    var $circle = $this.find('.ripplesCircle');

	    var x = e.pageX - $offset.left;
	    var y = e.pageY - $offset.top;

	    $circle.css({
	      top: y + 'px',
	      left: x + 'px'
	    });

	    $this.addClass('is-active');

	  });

	  $ripples.on('animationend webkitAnimationEnd mozAnimationEnd oanimationend MSAnimationEnd', function(e) {
	  	$(this).removeClass('is-active');
	  });
	});
</script>

</body>
</html>