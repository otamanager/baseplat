<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<title>资源管理</title>
<jsp:include page="../common/inc.jsp"></jsp:include>

<script type="text/javascript">
	var treeGrid;
	$(function() {

		//init
		$('#iconCls').combobox({
			data : $.iconData,
			formatter : function(v) {
				return $.formatString('<span class="{0}" style="display:inline-block;vertical-align:middle;width:16px;height:16px;"></span>{1}', v.value, v.value);
			}
		});

		$('#pid').combotree({
			url : '${CONTEXT_PATH}/system/res/tree',
			parentField : 'pid',
			lines : true,
			panelHeight : 'auto'
		});
		
		
		treeGrid = $('#treeGrid').treegrid({
			url : '${CONTEXT_PATH}/system/res/list',
			idField : 'id',
			treeField : 'name',
			parentField : 'pid',
			fit : true,
			fitColumns : false,
			border : false,
			frozenColumns : [ [ {
				title : '编号',
				field : 'id',
				width : 150, 
				hidden : true
			} ] ],
			columns : [ [ {
				field : 'name',
				title : '资源名称',
				width : 200
			}, {
				field : 'url',
				title : '资源路径',
				width : 330
			}, {
				field : 'type',
				title : '资源类型ID',
				width : 150,
				hidden : true
			},
			 {
				field : 'typeName',
				title : '资源类型',
				width : 80,
				formatter:function(value,row){
					if(row.type=='1')return '菜单';
					if(row.type=='2')return'功能';
					
				}
			},
			{
				field : 'seq',
				title : '排序',
				width : 40
			}, {
				field : 'pid',
				title : '上级资源ID',
				width : 150,
				hidden : true
			} ,{
				field : 'action',
				title : '操作',
				width : 50,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('  <shiro:hasPermission name="/system/res/edit"><img onclick="editFun(\'{0}\');" src="{1}" title="编辑"/> </shiro:hasPermission>', row.id, '${pageContext.request.contextPath}/js/ext/style/images/extjs_icons/pencil.png');
					str += '&nbsp;';
						str += $.formatString('   <shiro:hasPermission name="/system/res/delete"><img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/> </shiro:hasPermission>', row.id, '${pageContext.request.contextPath}/js/ext/style/images/extjs_icons/cancel.png');
					return str;
				}
			}, {
				field : 'des',
				title : '备注',
				width : 250
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
		if (id != undefined)treeGrid.treegrid('select', id);
		
		var node = treeGrid.treegrid('getSelected');
		if (node) {
			parent.$.messager.confirm('询问', '您是否要删除当前资源？', function(b) {
				if (b) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${CONTEX_PATH}/system/res/delete', {
						id : node.id
					}, function(result) {
						if (result.code==200) {
							treeGrid.treegrid('reload');
							parent.layout_west_tree.tree('reload');
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
			 if(node.des)$('#des').text(node.des);
			showDialog('#dlg','编辑资源');
			url='${CONTEXT_PATH}/system/res/edit';
		}
	}

	function addFun() {
		  $('#fm').form('clear');
		  showDialog('#dlg','添加资源');
		  url='${CONTEXT_PATH}/system/res/add';
		  
	}
	
	
	function submit(){
		
	      $('#fm').form('submit',{
	                url: url,
	                success: function(result){
	                 result= $.parseJSON(result);
	                 if(result.code==200){
	                  $('#dlg').dialog('close'); 
	                  treeGrid.treegrid('reload');
   	              	  parent.layout_west_tree.tree('reload');
   	              	   $('#pid').combotree('reload');
	                  }
	                else {
	                  $.messager.alert('提示',result.msg);
	                }
	             }
	       });		
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
     <shiro:hasPermission name="/system/res/add"> 
	   <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a> </shiro:hasPermission>
		<a onclick="tgredo(treeGrid);" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_next'">展开</a> <a onclick="tgundo(treeGrid);" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'resultset_previous'">折叠</a> <a onclick="treeGrid.treegrid('reload');" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'transmit'">刷新</a>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">、
	      <shiro:hasPermission name="/system/res/add">
	        <div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div></shiro:hasPermission>
			    <shiro:hasPermission name="/system/res/delete">
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div></shiro:hasPermission>
			    <shiro:hasPermission name="/system/res/edit">
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div></shiro:hasPermission>
	</div>
	
	
	
	
	<!--  dialog -->
	 <div id="dlg"   class="easyui-dialog" style=" width:540px;height:350px;padding:5px 10px" closed="true" buttons="#dlg-buttons"  data-options="resizable:true,modal:true">
	
	<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="fm" method="post">
			<input name="res.id" type="hidden"   class="span2" value="" > 
			<table class="table table-hover table-condensed">
				<tr>
				<th>资源名称</th>
				<td colspan="4"><input name="res.name" type="text" placeholder="请输入资源名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<th>资源路径</th>
					<td><input name="res.url" type="text" placeholder="请输入资源路径" class="easyui-validatebox span2" value=""></td>
					<th>资源类型</th>
					<td><select name="res.type" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'" required="required">
					  <option value="1" >菜单
					  <option value="2">功能
					</select></td>
				</tr>
				<tr>
					<th>排序</th>
					<td><input name="res.seq" value="10" class="easyui-numberspinner" style="width: 140px; height: 29px;" required="required" data-options="editable:false,min:10"></td>
					<th>上级资源</th>
					<td><select id="pid" name="res.pid" style="width: 140px; height: 29px;"></select><img src="${CONTEXT_PATH}/js/ext/style/images/extjs_icons/cut_red.png" onclick="$('#pid').combotree('clear');" /></td>
				</tr>
				<tr>
					<th>菜单图标</th>
					<td colspan="3"><input id="iconCls" name="res.iconCls" style="width: 375px; height: 29px;"   /></td>
				</tr>
				<tr>
					<th>备注</th>
					<td colspan="3"><textarea id="des" name="res.des" rows="" cols="" class="span5"></textarea></td>
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