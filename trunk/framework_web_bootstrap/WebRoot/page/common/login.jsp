<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/login.css">
<script src="${pageContext.request.contextPath}/js/security.js" type="text/javascript"></script>
<script  src="${pageContext.request.contextPath}/js/jquery-1.8.3.js" type="text/javascript" ></script>
<script  src="${pageContext.request.contextPath}/js/jsbase.js" type="text/javascript" ></script>
</head>
<script type="text/javascript">


 function go(){
	
	 if(isEmpty(['name','pwd'])){
	   
		 $('#msg').text('用户名或密码不能为空');
	 	 return;
	  }
	 
	   var key = RSAUtils.getKeyPair('${exponent}', '','${modulus}');
	   var key2="name="+$('#name').val()+"&pwd="+$('#pwd').val();
			 
			
	     $('#key').val(RSAUtils.encryptedString(key, key2));
     	 $('#login').submit();
	
}


</script>
<body>
	<form action="${pageContext.request.contextPath}/login" id="login" name="form" method="post">
		<h1>Log In</h1>
		<fieldset id="inputs">
		<input  id="name" type="text" placeholder="Username" value="${name}" autofocus required>
		 <input id="pwd"  type="password" placeholder="Password" value=""  required>
		</fieldset>
		<fieldset id="actions">
			<input type="button" id="button" onclick="go()"  value="Log in">
			   <a href="#" id="msg">${msg}</a> 
		</fieldset>
	    <input type="hidden" name="key" id="key">
	</form>


</body>
</html>
