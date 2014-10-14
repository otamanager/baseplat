<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/pages/commons/taglibs.jsp"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>

<script type="text/javascript">
	$(function() {
		doSearch();
	});
	
	function doSearch() {
		comUtil.showMask();//显示蒙版
		
		//进入ajax
		$.ajax({
			url : '${ctx }/test/listData.htm',
			type : 'post',
			data : $('#testForm').serialize(),
			dataType : 'html',
			success : function(rsData) {
				comUtil.hideMask();//关闭蒙版
				$('#dataDiv').html(rsData);//展示数据
			}
		});
	}
	
	//删除
	function del() {
		var ids = comUtil.getCheckedBoxsValByName('testCheckboxId', ',');
		if (!comUtil.isEmpty(ids)) {
			var $boxLength = comUtil.getCheckedBoxsLengthByName('testCheckboxId');
			comUtil.confirm("确定要删除选中的" + $boxLength + "条数据吗？",
							function() {
								comUtil.showMask();
								//检测表单是否所有字段都验证通过
								$.ajax({
									url : '${ctx }/test/del.htm',
									type : 'post',
									data : {
										'testIds' : ids
									},
									dataType : 'json',
									success : function(rsData) {
										comUtil.hideMask();
										comUtil.alert(rsData.msg,function() {
											if (rsData.success) {
												comUtil.goUrl('${ctx }/test/listInit.htm');
											}
										});
									}
								});
							}, null);
		} else {
			comUtil.alert("请选择要删除的数据！", function() {
			});
		}
	}

	//打开添加dialog
	function addDialog() {
		var _url = "${ctx }/test/inputInit.htm";
		comUtil.openByUrl("测试添加", "add_dialog", 800, 300, _url);
	}
	
	//打开修改密码框
	function updateDialog(id) {
		var _url = "${ctx }/test/toUpdate.htm";
		comUtil.openByUrl("测试修改", "update_dialog", 800, 300, _url);
	}

	//关闭dialog
	function closeDialog(id) {
		comUtil.closeDialogById(id);
		comUtil.goUrl('${ctx }/test/listInit.htm');
	}
	
	//修改
	function to_update(id){
		var _url = "${ctx }/test/inputInit.htm?id="+id;
		comUtil.openByUrl("测试添加", "add_dialog", 800, 300, _url);
	}
	
	//查看
	function to_view (id){
		var _url = "${ctx }/test/view.htm?id="+id;
		comUtil.openByUrl("测试添加", "toView_dialog", 800, 300, _url);
	}
	
</script>
</head>
<body>
	<form name='testForm' method='post' id="testForm">
		<div class="user-box">
			<!-- 查询条件 -->
			<div class=" main-title">
				<b>测试管理</b>
			</div>
			<div class="search-list-box" >
				<table border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td width='70'><strong>姓名：</strong></td>
						<td width='160'>
						<input type='text' name='name' value='' style='width: 150px;height:20px ;' maxlength="20" /></td>
						<td width="80"><input id="btn_chaxun" type="button"
							value="查询" class="btn_nosel" onclick="doSearch();" /></td>
						<td width="80"><input id="btn_reset" type="reset" value="重置"
							class="btn_nosel" /></td>
							<td width="80"><input id="btn_chaxun" type="button"
							value="添 加" class="btn_nosel" onclick="addDialog();" /></td>
							</td>
							<td width="80"><input id="btn_chaxun" type="button"
							value="删 除" class="btn_nosel" onclick="del();" /></td>
					</tr>
					
				</table>
			</div>
			<div class="search-list-content"  id="dataDiv">
			</div>
		</div>
	</form>
</body>
</html>