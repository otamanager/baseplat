<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/pages/common/_taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>后台管理系统</title>
<link rel="stylesheet" type="text/css" href="/css/global.css" />
<link rel="stylesheet" type="text/css" href="/css/css.css" />
<script type="text/javascript" charset="UTF-8" src="/js/common/jquery-1.8.3.min.js"></script>
</head>
<body style=" overflow:hidden;">
<div class="login-bg">
<div class="login-logo"><img src="/images/logo.png" width="229" height="57" /></div>
<div class="login-box">
	<div class="login-box-border">
        <div class="login-left-img"><img src="/images/logo-img.png" width="527" height="374" /></div>
        <div class="login-text">
            <h1>用户登录</h1>
            <form action="/main" method='post'>
	            <div class="login-input-border"><input name="user.login_name" id="username" value="" type="text" class="login-green-input" /></div>
	            <div class="login-input-border1"><input name="user.password" id="password" value="" type="password" class="login-green-input1" /></div>
	            <div class="login-green-box"><button type="submit"  class="login-green-btn" id="submit"></button> </div>
            </form>
        </div>
    </div>
</div>
</div>
</body>
</html>
