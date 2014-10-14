<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 引入my97日期时间控件 
-->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/My97DatePicker4.8b3/My97DatePicker/WdatePicker.js" charset="utf-8"></script>

<!-- 引入kindEditor插件 
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/kindeditor-4.1.7/themes/default/default.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/kindeditor-4.1.7/kindeditor-all-min.js" charset="utf-8"></script>
-->

<!-- 引入jQuery 
-->
<script src="${pageContext.request.contextPath}/js/jquery-1.8.3.js" type="text/javascript" charset="utf-8"></script>


<!-- 引入bootstrap样式  3 
<link href="${pageContext.request.contextPath}/js/bootstarp-3.0.3/css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="${pageContext.request.contextPath}/js/bootstarp-3.0.3/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>
-->

<!-- 引入bootstrap样式   2.3 
-->
<link href="${pageContext.request.contextPath}/js/bootstrap-2.3.1/css/bootstrap.min.css" rel="stylesheet" media="screen">
<script src="${pageContext.request.contextPath}/js/bootstrap-2.3.1/js/bootstrap.min.js" type="text/javascript" charset="utf-8"></script>


<!-- 引入EasyUI 
-->
<link id="easyuiTheme" rel="stylesheet"
	href="${pageContext.request.contextPath}/js/jquery-easyui-1.3.5/themes/<c:out value="${cookie.easyuiThemeName.value}" default="metro"/>/easyui.css"
	type="text/css">
	
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.3.5/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.3.5/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-1.3.5/plugins/jquery.layout.js" charset="utf-8"></script>

<!-- 扩展EasyUI -->
<!-- 扩展EasyUI Icon -->
<!-- 扩展jQuery -->
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ext/extEasyUI.js?v=201305241044" charset="utf-8"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/ext/style/extEasyUIIcon.css?v=201305301906" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/ext/extJquery.js?v=201305301341" charset="utf-8"></script>


<!--  jsbase -->
<script  src="${pageContext.request.contextPath}/js/jsbase.js" type="text/javascript" ></script>
<script  src="${pageContext.request.contextPath}/js/jsbase-easyui.js" type="text/javascript" ></script>

<script type="text/javascript" src="${CONTEXT_PATH}/js/Jquery-json.js"></script>


