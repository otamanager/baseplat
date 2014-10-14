<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>角色管理</title>
<jsp:include page="../common/inc.jsp"></jsp:include>

<script type="text/javascript">
	var treeGrid;
	$(function() {
		
		$('#pid').combotree({
			url : '${CONTEXT_PATH}/system/role/tree',
			parentField : 'pid',
			lines : true,
			panelHeight : 'auto'
		});
		
		
		treeGrid = $('#treeGrid').treegrid({
			url : '${CONTEXT_PATH}/system/role/list',
			idField : 'id',
			treeField : 'name',
			parentField : 'pid',
			fit : true,
			fitColumns : false,
			border : false,
			nowrap : true,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 150,
				hidden : true
			}, {
				field : 'name',
				title : '角色名称',
				width : 150
			} ] ],
			columns : [ [ {
				field : 'seq',
				title : '排序',
				width : 40
			}, {
				field : 'pid',
				title : '上级角色ID',
				width : 150,
				hidden : true
			}, {
				field : 'pname',
				title : '上级角色',
				width : 80
			}, {
				field : 'res_names',
				title : '拥有资源',
				width : 380
			}, {
				field : 'res_ids',
				title : '拥有资源ids',
				width : 80,
				hidden : true
			}, {
				field : 'des',
				title : '备注',
				width : 150
			}, {
				field : 'action',
				title : '操作',
				width : 70,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('<shiro:hasPermission name="/system/role/edit"><img onclick="editFun(\'{0}\');" src="{1}" title="编辑"/></shiro:hasPermission> ', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/pencil.png');
					str += '&nbsp;';
						str += $.formatString('<shiro:hasPermission name="/system/role/grant"><img onclick="grantFun(\'{0}\');" src="{1}" title="授权"/></shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/key.png');
					str += '&nbsp;';
						str += $.formatString('<shiro:hasPermission name="/system/role/delete"><img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/></shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/cancel.png');
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			onContextMenu : function(e, row) {
				e.preventDefault();
				$(this).treegrid('unselectAll');
				$(this).treegrid('select', row.id);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			},
			onLoadSuccess : function() {
				parent.$.messager.progress('close');

				$(this).treegrid('tooltip');
			}
		});
	});

	function deleteFun(id) {
		if (id != undefined)  treeGrid.treegrid('select', id);
		
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${CONTEXT_PATH}/system/role/delete', {
						id : node.id
					}, function(result) {
						if (result.code==200) {
						    	treeGrid.treegrid('reload');
							   $('#pid').combotree('reload');
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				}
			});
		}
	}

	function editFun(id) {
		if (id != undefined)treeGrid.treegrid('select', id);
		
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			loadFrom('#fm',node);
			showDialog('#dlg','编辑角色');
			url='${CONTEXT_PATH}/system/role/edit';
		}
	}

	function addFun() {
		  $('#fm').form('clear');
		  showDialog('#dlg','添加角色');
		  url='${CONTEXT_PATH}/system/role/add';
	}
	
	function submit(){
		
	      $('#fm').form('submit',{
	                url: url,
	                success: function(result){
	                 result= $.parseJSON(result);
	                 if(result.code==200){
	                  $('#dlg').dialog('close'); 
	                  treeGrid.treegrid('reload');
	                  $('#pid').combotree('reload');
	                  }
	                else {
	                  $.messager.alert('提示',result.msg);
	                }
	             }
	       });		
	}


	function grantFun(id) {
		if (id != undefined) {
			treeGrid.treegrid('select', id);
		}
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			parent.$.modalDialog({
				title : '角色授权',
				width : 500,
				height : 500,
				href : '${CONTEXT_PATH}/page/system/roleGrant.jsp?id=' + node.id+'&name='+node.name+'&resIds='+node.res_ids+'&des='+node.des,
				buttons : [ {
					text : '授权',
					handler : function() {
						parent.$.modalDialog.openner_treeGrid = treeGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
						var f = parent.$.modalDialog.handler.find('#fm');
						f.submit();
					}
				} ]
			});
		}
	}
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit:true,border:false">
		<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
			<table id="treeGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
	  <shiro:hasPermission name="/system/role/add">	
	 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a></shiro:hasPermission>
		<a onclick="tgredo(treeGrid);" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_next'">展开</a>
		 <a onclick="tgundo(treeGrid);" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_previous'">折叠</a> <a onclick="treeGrid.treegrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">

            <shiro:hasPermission name="/system/role/add">	
			<div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div></shiro:hasPermission>
			<shiro:hasPermission name="/system/role/delete">	
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div></shiro:hasPermission>
			<shiro:hasPermission name="/system/role/edit">	
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div></shiro:hasPermission>
	</div>
	
	
	
		
	<!--  dialog -->
	 <div id="dlg"   class="easyui-dialog" style=" width:540px;height:300px;padding:5px 10px" closed="true" buttons="#dlg-buttons"  data-options= "resizable:true,modal:true">
	<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="fm" method="post">
			<input name="role.id" type="hidden"   class="span2" value="" > 
			<table class="table table-hover table-condensed">
				<tr>
					<th>角色名称</th>
					<td colspan="3"><input name="role.name" type="text" placeholder="请输入角色名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<th>排序</th>
					<td><input name="role.seq" value="100" class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false"></td>
					<th>上级角色</th>
					<td><select id="pid" name="role.pid" style="width: 140px; height: 29px;"></select><img src="${CONTEXT_PATH}/js/ext/style/images/extjs_icons/cut_red.png" onclick="$('#pid').combotree('clear');" /></td>
				</tr>
				<tr>
					<th>备注</th>
					<td colspan="3"><textarea name="role.des" rows="" cols="" class="span5"></textarea></td>
				</tr>
			</table>
	 	 </form>
	    </div>
        </div>
	</div>
	    <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton"   onclick="submit()">确定</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dlg').dialog('close')">取消</a>
    </div> 
	
	
	
	
	
	
	
	
	
	
</body>
</html>