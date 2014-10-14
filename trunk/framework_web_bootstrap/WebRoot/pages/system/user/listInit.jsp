<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/common/_header.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script type="text/javascript">
	$(function() {
		doSearch();
	});

	function doSearch() {
		comUtil.showMask();//显示蒙版 (login)
		//进入ajax
		$.ajax({
			url : '/user/query',
			type : 'post',
			data : $('#taskLogForm').serialize(),
			success : function(rsData) {
				comUtil.hideMask();//关闭蒙版
				$('#dataDiv').html(rsData);//展示数据
			}
		});
	}
	//打开添加dialog
	function addDialog() {
		var _url = "/user/showAdd";
		comUtil.openByUrl("添加用户", "add_dialog", 1000, 320, _url);
	}
	//删除
	// 			function del() {
	// 				var ids = comUtil.getCheckedBoxsValByName('taskCheckboxId', ',');
	// 				if (!comUtil.isEmpty(ids)) {
	// 					var $boxLength = comUtil.getCheckedBoxsLengthByName('taskCheckboxId');
	// 					comUtil.confirm("确定要删除选中的" + $boxLength + "条数据吗？",
	// 					function() {
	// 						comUtil.showMask();
	// 						//检测表单是否所有字段都验证通过
	// 						$.ajax({
	// 							url : '${ctx }/task/del.htm',
	// 							type : 'post',
	// 							data : {
	// 								'taskIds' : ids
	// 							},
	// 							dataType : 'json',
	// 							success : function(rsData) {
	// 								comUtil.hideMask();
	// 								comUtil.alert(rsData.msg,function() {
	// 									if (rsData.success) {
	// 										comUtil.goUrl('${ctx }/task/listInit.htm');
	// 									}
	// 								});
	// 							}
	// 						});
	// 					}, null);
	// 				} else {
	// 					comUtil.alert("请选择要删除的数据！", function() {});
	// 				}
	// 			}



	//关闭dialog
	// 			function closeDialog(id) {
	// 				comUtil.closeDialogById(id);
	// 				comUtil.goUrl('${ctx }/taskLog/listInit.htm');
	// 			}

	//修改
	// 			function to_update(id){
	// 				var _url = "${ctx }/task/inputInit.htm?id="+id;
	// 				comUtil.openByUrl("修改任务", "add_dialog", 1000, 320, _url);
	// 			}

	//查看
	function to_view(tips) {
		comUtil.showMask();//显示蒙版 (login)
		comUtil.alert(tips, function() {
			comUtil.hideMask();
			var _url = "/user/showView/id="+tips;
			comUtil.openByUrl("添加用户", "view_dialog", 1000, 320, _url);
		});
	}
</script>
</head>
<body>
	<form name='taskLogForm' method='post' id="taskLogForm">
		<div class="user-box">
			<!-- 查询条件 -->
			<div class=" main-title">
				<b>用户管理</b>
			</div>
			<div class="search-list-box">
				<table>
					<tr>
						<td><strong>名称：</strong></td>
						<td><input name="user.name"></td>
						<td><strong>登录名：</strong></td>
						<td><input name="user.login_name"></td>
						<td><strong>手机号：</strong></td>
						<td><input name="user.mobile"></td>

						<td><input id="btn_chaxun" type="button" value="查询"
							class="btn_nosel" onclick="doSearch();" /></td>
						<td><input id="btn_reset" type="reset" value="重置"
							class="btn_nosel" /></td>
						<td width="80"><input id="btn_chaxun" type="button"
							value="添 加" class="btn_nosel" onclick="addDialog();" /></td>
					</tr>
				</table>
			</div>
			<div class="search-list-content" id="dataDiv">
				<!-- 列表内容 -->
			</div>
		</div>
	</form>
</body>
</html>