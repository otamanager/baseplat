<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>Bug管理</title>
<jsp:include page="../common/inc.jsp"></jsp:include>

<!-- 引入kindEditor插件 -->
<link rel="stylesheet" href="${CONTEXT_PATH}/js/kindeditor-4.1.10/themes/simple/simple.css">
<script type="text/javascript" src="${CONTEXT_PATH}/js/kindeditor-4.1.10/kindeditor-all-min.js" charset="utf-8"></script>

<script type="text/javascript">
	var dataGrid;
	$(function() {
		
		createNote();
		createReadOnlyNote();
		
		dataGrid = $('#dataGrid').datagrid({
			url : '${CONTEXT_PATH}/system/bug/list',
			fit : true,
			fitColumns : true,
			border : false,
			pagination : true,
			idField : 'id',
			pageSize : 10,
			pageList : [ 10, 20, 30, 40, 50 ],
			sortName : 'createdate',
			sortOrder : 'desc',
			checkOnSelect : false,
			selectOnCheck : false,
			nowrap : false,
			striped : true,
			rownumbers : true,
			singleSelect : true,
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : 150,
				hidden : true
			}, {
				field : 'name',
				title : 'BUG名称',
				width : 80,
				sortable : true
			} ] ],
			columns : [ [ {
				field : 'createdate',
				title : '创建时间',
				width : 150,
				sortable : true
			}, {
				field : 'modifydate',
				title : '最后修改时间',
				width : 150,
				sortable : true
			},{
				field : 'type',
				title : 'BUG类型',
				width : 150,
				sortable : true,
				formatter:function(value){
					if(value=='1')return '错误';
					if(value=='2')return '功能';
				}
			},{
				field : 'status',
				title : '状态',
				width : 150,
				sortable : true,
				formatter:function(value){
					if(value=='1')return '待处理';
					if(value=='2')return '已处理';
					if(value=='3')return '忽略';
				}
			},{
				field : 'action',
				title : '操作',
				width : 100,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('   <shiro:hasPermission name="/system/bug/view"><img onclick="viewFun(\'{0}\');" src="{1}" title="查看"/>  </shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/bug/bug_link.png');
					str += '&nbsp;';
						str += $.formatString('   <shiro:hasPermission name="/system/bug/edit"><img onclick="editFun(\'{0}\');" src="{1}" title="编辑"/> </shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/bug/bug_edit.png');
					str += '&nbsp;';
						str += $.formatString('   <shiro:hasPermission name="/system/bug/delete"><img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/> </shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/bug/bug_delete.png');
					return str;
				}
			} ] ],
			toolbar : '#toolbar',
			onLoadSuccess : function() {
				$('#searchForm table').show();
				parent.$.messager.progress('close');

				$(this).datagrid('tooltip');
			},
			onRowContextMenu : function(e, rowIndex, rowData) {
				e.preventDefault();
				$(this).datagrid('unselectAll');
				$(this).datagrid('selectRow', rowIndex);
				$('#menu').menu('show', {
					left : e.pageX,
					top : e.pageY
				});
			}
		});
	});
	
	
	function createNote(){
			editor = KindEditor.create('#note', {
				width : '750px',
				height : '360px',
				items : [ 'source', '|', 'undo', 'redo', '|', 'preview', 'print', 'template', 'code', 'cut', 'copy', 'paste', 'plainpaste', 'wordpaste', '|', 'justifyleft', 'justifycenter', 'justifyright', 'justifyfull', 'insertorderedlist', 'insertunorderedlist', 'indent', 'outdent', 'subscript', 'superscript', 'clearhtml', 'quickformat', 'selectall', '|', 'fullscreen', '/', 'formatblock', 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline', 'strikethrough', 'lineheight', 'removeformat', '|', 'image','multiimage', 'flash', 'media', 'insertfile', 'table', 'hr', 'emoticons', 'baidumap', 'pagebreak', 'anchor', 'link', 'unlink' ],
				uploadJson : '${CONTEXT_PATH}/common/file/upload',
				fileManagerJson : '${CONTEXT_PATH}/common/file/fileManage',
				allowFileManager : true
			});
	}
	
	function createReadOnlyNote(){
		  KindEditor.create('#note2', {
			width : '800px',
			height : '500px',
			items : [ 'print','fullscreen']
		});
		
		KindEditor.instances[1].readonly(true);
	}
	

	function deleteFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		}
		parent.$.messager.confirm('询问', '您是否要删除当前BUG？', function(b) {
			if (b) {
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				$.post('${CONTEXT_PATH}/system/bug/delete', {
					id : id
				}, function(result) {
					if (result.code==200) {
						dataGrid.datagrid('reload');
					}
					parent.$.messager.progress('close');
				}, 'JSON');
			}
		});
	}
 

	function viewFun(id) {
 
    if (id != undefined)dataGrid.datagrid('selectRecord', id);
		var node = dataGrid.datagrid('getSelected');
		if (node) {
			createReadOnlyNote();
			if(node.des)KindEditor.html('#note2',node.des);
			showDialog('#dlg2','查看bug');
			
		}
		
	}
	
	
	function editFun(id) {
		
		if (id != undefined)dataGrid.datagrid('selectRecord', id);
		
		var node = dataGrid.datagrid('getSelected');
		if (node) {
			loadFrom('#fm',node);
			 if(node.des) KindEditor.html('#note',node.des);
			showDialog('#dlg','编辑bug');
			url='${CONTEXT_PATH}/system/bug/edit';
		}
	}

	function addFun() {
		  $('#fm').form('clear');
		  editor.html('');
		  showDialog('#dlg','添加bug');
		  url='${CONTEXT_PATH}/system/bug/add';
		  
	}
	
	
	function submit(){
		
		editor.sync();
		
	      $('#fm').form('submit',{
	                url: url,
	                success: function(result){
	                 result= $.parseJSON(result);
	                 if(result.code==200){
	                  $('#dlg').dialog('close'); 
	                  dataGrid.datagrid('reload');
   	              	  parent.layout_west_tree.tree('reload');
   	              	   $('#pid').combotree('reload');
	                  }
	                else {
	                  $.messager.alert('提示',result.msg);
	                }
	             }
	       });		
	}
	
	function searchFun() {
		dataGrid.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dataGrid.datagrid('load', {});
	}

	
	
	function fileManage() {
		editor.loadPlugin('filemanager', function() {
			editor.plugin.filemanagerDialog({
				viewType : 'VIEW',
				dirName : 'root',
				clickFn : function(url, title) {
					//KindEditor('#url').val(url);
					editor.insertHtml($.formatString('<img src="{0}" alt="" />', url));
					editor.hideDialog();
				}
			});
		});
	}
	
	
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 160px; overflow: hidden;">
			<form id="searchForm">
				<table class="table table-hover table-condensed" style="display: none;">
					<tr>
						<th>BUG名称</th>
						<td><input name="name" placeholder="可以模糊查询" class="span2" /></td>
						<th>BUG类型</th>
						<td>
						<select name="type" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'"> 
						<option value="1">错误
						<option value="2">功能
						</select></td>
					</tr>
					<tr>
						<th>创建时间</th>
						<td ><input class="span2" name="createdateStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />至<input class="span2" name="createdateEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
					   
					   	 
				 <th>BUG状态</th>
					<td>
					<select name="status" class="easyui-combobox" data-options="required:true,width:140,height:29,editable:false,panelHeight:'auto'">
					<option value="1">待处理
					<option value="2">已处理
					<option value="3">忽略
					</select>
					</td>
					
					</tr>
					<tr>
						<th>最后修改时间</th>
						<td colspan="3"><input class="span2" name="modifydateStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />至<input class="span2" name="modifydateEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
	 <shiro:hasPermission name="/system/bug/add">
		 <a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'bug_add'">添加</a>
		</shiro:hasPermission>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">过滤条件</a><a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();">清空条件</a>
	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
	
	         <shiro:hasPermission name="/system/bug/add">
			<div onclick="addFun();" data-options="iconCls:'pencil_add'">增加</div>
			</shiro:hasPermission>
			   <shiro:hasPermission name="/system/bug/delete">
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
			</shiro:hasPermission>
			  <shiro:hasPermission name="/system/bug/edit">
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
			</shiro:hasPermission>
	</div>
	
	
	<!--  dialog -->
  <div id="dlg"   class="easyui-dialog" style=" width:800px;height:550px;padding:5px 10px" closed="true" buttons="#dlg-buttons"  data-options="resizable:true,modal:true">
	
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="fm" method="post">
		<input name="bug.id" type="hidden"  >
			<table class="table table-hover table-condensed">
				<tr>
					<th>BUG名称</th>
					<td><input name="bug.name" type="text" placeholder="请输入BUG名称" class="easyui-validatebox span2" data-options="required:true"  ></td>
					<th> </th>
					<td></td>
				</tr>
				<tr>
				 <shiro:hasPermission name="/common/file/fileManage">
				 	<th>浏览服务器附件</th>
					 	<td>
					 	<button type="button" class="btn" onclick="fileManage();">浏览服务器</button>
					 </td>
					 </shiro:hasPermission>
					 
				 <th>BUG类型</th>
					<td>
					<select name="bug.type" class="easyui-combobox" data-options="required:true,width:140,height:29,editable:false,panelHeight:'auto'">
					<option value="1">错误
					<option value="2">功能
					
					</select>
					</td>
				</tr>
				<tr>
					<td colspan="4"><textarea name="bug.des" id="note" cols="50" rows="5" style="visibility: hidden;"> </textarea></td>
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

	<!--  dialog  view  -->
  <div id="dlg2"   class="easyui-dialog" style=" width:850px;height:580px;padding:5px 10px" closed="true" buttons="#dlg-buttons2"  data-options="resizable:true,modal:true">
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="fm" method="post">
		<input name="bug.id" type="hidden"  >
			<table class="table table-hover table-condensed">
				<tr>
					<td colspan="4"><textarea   id="note2" cols="50" rows="5" style="visibility: hidden;"> </textarea></td>
				</tr>
			</table>
		</form>
	</div>
</div>
  </div>
    <div id="dlg-buttons2">
        <a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dlg2').dialog('close')">取消</a>
    </div> 	   	
</body>

</html>