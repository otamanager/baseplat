<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/pages/commons/taglibs.jsp"%>
<!DOCTYPE html >
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><sitemesh:write property="title" /></title>
<%@ include file="/pages/commons/global.jsp"%>
<sitemesh:write property="head" />
</head>
<body>
	<%@ include file="/pages/commons/header.jsp"%>
	<sitemesh:write property="body" />
</body>
</html>