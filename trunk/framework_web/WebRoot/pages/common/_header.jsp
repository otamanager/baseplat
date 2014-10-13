<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/pages/common/_taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<link rel="stylesheet" type="text/css" href="/css/global.css"  />
<link rel="stylesheet" type="text/css" href="/css/css.css"  />
<link rel="stylesheet" type="text/css" href="/css/toolbar.css" />
<link rel="stylesheet" type="text/css" href="/js/artDialog4.1.7/skins/blue.css"  />
<link rel="stylesheet" type="text/css" href="/js/validator-0.7.0/jquery.validator.css">
<script type="text/javascript" charset="utf-8" src="/js/jquery-1.8.3.min.js" ></script>
<script type="text/javascript" charset="utf-8" src="/js/jquery.form.min.js" ></script>
 <script language="javascript" type="text/javascript" src="/js/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/artDialog4.1.7/jquery.artDialog.js" ></script>
<script type="text/javascript" charset="utf-8" src="/js/artDialog4.1.7/plugins/iframeTools.js" ></script>
<script type="text/javascript" charset="utf-8" src="/js/validator-0.7.0/jquery.validator.js" ></script>
<script type="text/javascript" charset="utf-8" src="/js/validator-0.7.0/local/zh_CN.js"></script>
<script type="text/javascript" charset="utf-8" src="/js/common.js" ></script>
</head>
<body>
	<div class="head-box">
		<div class="logo">
			<a href="#"><img src="/images/logo.png"
				width="229" height="57" /></a>
		</div>
		<div class="subnav">
			<div class="c_subNav">
				<ul>
					<li id="systemManageMainLi" class="li charges">
						<!--[if IE 6]><a class="li" href="#nogo"><table><tr><td><![endif]-->
						<a href="javascript:void(0);" class="option"><span>系统管理</span></a>
						<ul>
							<li class="li"><a href="/user"
								class="option"><span>用户管理</span></a></li>
							<li class="li"><a href="/role/search.htm"
								class="option"><span>角色管理</span></a></li>
							<li class="li"><a href="/org/showOrgTree.htm"
								class="option"><span>机构管理</span></a></li>
							<li class="li"><a href="/domain/showDomain.htm"
								class="option"><span>值域管理</span></a></li>
							<li class="li"><a href="/param/showParam.htm"
								class="option"><span>参数管理</span></a></li>
						</ul>
					</li>
				</ul>
			</div>
		</div>
		<div style="text-align: center;" class="right-iconnav">
			<a class="link-home" href="/workspace.htm"><img width="26"
				height="26" src="/images/subnav-topbg.png" title="首页"></a>
			<a class="link-user" href="/user/updateUser.htm"><img
				width="26" height="26" src="/images/subnav-topbg.png"
				title="修改密码"></a> <a
				href="javascript:window.parent.location.href='/j_spring_security_logout'"
				class="link-out"><img
				src="/images/subnav-topbg.png" width="26" height="26"
				title="退出" /></a>
		</div>
	</div>
</body>
</html>