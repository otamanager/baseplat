<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/common/_taglibs.jsp"%>
<%@ include file="/pages/common/_global.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>查看</title> 
</head>
<body >
	<input type="hidden" id="id" name="id" value="${entity.id }"/>
		<table class="table_8ec0e9_xux">
			<tr align="center"  >
				<td width="15%"  class="font12_000_b_right">姓名：</td>
				<td width="35%" style="text-align:left;">
					<input type="text" name="user.name"  maxlength="20" value="${entity.name }"/>
				</td>
				<td width="15%"  class="font12_000_b_right">登录名：</td>
				<td width="35%" style="text-align:left;">
					<input type="text" name="user.login_name" maxlength="3" value="${entity.login_name }"/>
				</td>
			</tr>
			<tr align="center"  >
				<td width="15%"  class="font12_000_b_right">密码：</td>
				<td width="35%" style="text-align:left;">
					<input type="text" name="user.password"  maxlength="20" value="${entity.password }"/>
				</td>
				<td width="15%"  class="font12_000_b_right">手机号：</td>
				<td width="35%" style="text-align:left;">
					<input type="text" name="user.mobile" maxlength="3" value="${entity.mobile }"/>
				</td>
			</tr>
			<tr align="center"  >
				<td width="15%"  class="font12_000_b_right">邮箱：</td>
				<td width="35%" style="text-align:left;">
					<input type="text" name="user.email"  maxlength="20" value="${user.email }"/>
				</td>
			</tr>
		</table>
		<div style="text-align: center;margin-top: 10px;">
		    <input type="button" value="返回" onclick="javascript:comUtil.closeDialog('view_dialog');" class="btn_nosel"/>
		</div>	
</body>
</html>