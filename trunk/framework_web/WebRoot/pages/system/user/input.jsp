<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/common/_taglibs.jsp"%>
<%@ include file="/pages/common/_global.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>添加</title> 
<script type="text/javascript">
		function doAdd(){
			comUtil.confirm("确定要保存吗？",function(){
				comUtil.showMask();
				//检测表单是否所有字段都验证通过
				$.ajax({
					url:'/user/add',
					type: 'post',
					data:$('#addForm').serialize(),
					dataType:'json',
					success:function (rsData){
						comUtil.hideMask();
						comUtil.alert(rsData.msg,function(){
							if('success' == rsData.msg){
								comUtil.closeDialog('add_dialog');
							}
						}); 
					}
				});
			},null);
		}
		
		$(function(){
			$('#addForm').validator({
				stopOnError: false,
				timely:1,
			
			    fields: {
			        'name': 'required;length[1~50];',
			        'age' : 'required;length[1~3];integer[+]'
			    },
			    messages: {
			        required: "不能为空！"
			    },
			    valid: function(form){
			    	doAdd();
		    	}
			});
		});
	</script>
</head>
<body >
	
	<form name="addForm" method="post" id="addForm" autocomplete="off" data-validator-option="{theme:'yellow_right_effect',stopOnError:true}">
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
			<c:choose>
				<c:when test="${empty entity.id }">
					<input type="submit" value="保存" id="saveUser" class="btn_nosel"/>
				</c:when>
				<c:otherwise>
				    <input type="submit" value="修改" id="saveUser" class="btn_nosel"/>
				</c:otherwise>
			</c:choose>
		    <input type="button" value="返回" onclick="javascript:parent.closeDialog('add_dialog');" class="btn_nosel"/>
		</div>	
	</form>

</body>
</html>