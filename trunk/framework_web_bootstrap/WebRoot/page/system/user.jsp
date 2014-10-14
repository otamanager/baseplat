<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
<jsp:include page="../common/inc.jsp"></jsp:include>

<script type="text/javascript">
 
 var dg;
 $(function (){
	 
		$('#role_ids').combotree({
			url : '${pageContext.request.contextPath}/system/role/tree',
			parentField : 'pid',
			lines : true,
			panelHeight : 'auto',
			multiple : true,
			onLoadSuccess : function() {
				parent.$.messager.progress('close');
			},
			cascadeCheck : false,
		});

	 
	  dg = $('#dg').datagrid({
	    url:'${CONTEXT_PATH}/system/user/list',
	    fit:true,
	    fitColumns : true,
		idField : 'id',
		striped: true, 
		border : false,
		nowrap:false,
		rownumbers:true,
		singleSelect:true,
	    pagination : true,
	    checkOnSelect : false,
		selectOnCheck : false,
		pageSize : 15,
	    pageList : [15, 20, 30, 40, 50],
	    frozenColumns : [ [ {
			field : 'id',
			title : '编号',
			width : 150,
			checkbox : true
		}, {
			field : 'name',
			title : '登录名称',
			width : 80,
			sortable : true
		} ] ],
	     columns:[[
            {
	           field : 'pwd',
	           title : '密码',
               width : 60,
         	   formatter : function(value, row, index) {
		       return '******';
	       }
           },
	        {field:'des',title:'描述',width:200,formatter:function(value,row){
	          if(value) return ' <div class="easyui-tooltip" title="'+value+'" style="padding:5px">'+value+'</div>';
	        }},
	        {field:'role_names',title:'所属角色',width:150},
	        {field:'role_ids',title:'所属角色',width:50,hidden:true},
	        {field:'status',title:'状态',width:50,formatter:function(value,row){
	        	if(value=='1') return '正常';
	        	if(value=='2')return '在线';
	        	if(value=='3') return '冻结';
	        }},
	        {field:'date',title:'创建日期',width:100},
	        {field:'action',title:'操作',width:100,
	         formatter:function(value, row, index){
	         	var str = '';
		    	str += $.formatString('<shiro:hasPermission name="/system/user/edit"><img style="float:left;" onclick="editFun(\'{0}\');" src="{1}" title="编辑"/></shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/pencil.png');
				str += $.formatString('<shiro:hasPermission name="/system/user/grant"><img style="float:left;" onclick="grant(\'{0}\');" src="{1}" title="授权"/></shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/key.png');
				str += $.formatString('<shiro:hasPermission name="/system/user/delete"><img style="float:left;" onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/></shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/cancel.png');
				
				return str+'';			
	      }}
	      ]],
	    toolbar : '#toolbar',
	    onLoadSuccess : function() {
			$('#searchForm table').show();
			parent.$.messager.progress('close');
			$(this).datagrid('tooltip');
		},
		onRowContextMenu : function(e, rowIndex, rowData) {
			e.preventDefault();
			$(this).datagrid('unselectAll').datagrid('uncheckAll');
			$(this).datagrid('selectRow', rowIndex);
			$('#menu').menu('show', {
				left : e.pageX,
				top : e.pageY
			});
		}
	});
	   });
 
 
 function searchFun() {
		dg.datagrid('load', $.serializeObject($('#searchForm')));
	}
	function cleanFun() {
		$('#searchForm input').val('');
		dg.datagrid('load', {});
	}
	
	
	function deleteFun(id) {
		if (id == undefined) {//点击右键菜单才会触发这个
			var rows = dg.datagrid('getSelections');
			id = rows[0].id;
		} else {//点击操作里面的删除图标会触发这个
			dg.datagrid('unselectAll').datagrid('uncheckAll');
		}
		parent.$.messager.confirm('询问', '您是否要删除当前用户？', function(b) {
			if (b) {
				var currentUserId = '${user.id}';/*当前登录用户的ID*/
				if (currentUserId != id) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					$.post('${pageContext.request.contextPath}/system/user/delete', {
						id : id
					}, function(result) {
						if (result.code==200) {
							dg.datagrid('reload');
						}
						parent.$.messager.progress('close');
					}, 'JSON');
				} else {
					parent.$.messager.show({
						title : '提示',
						msg : '不可以删除自己！'
					});
				}
			}
		});
	}



	function grant(id) {
		if (id != undefined)dg.datagrid('selectRecord', id);
		
		var node = dg.datagrid('getSelected');
		if (node) {
			$('#fm2').form('clear');
			loadFrom('#fm2',node);
			showDialog('#dlg-grant','授权');
			url='${CONTEXT_PATH}/system/user/grant';
			
		}
	}
	
	
	function editFun(id) {
		
		if (id != undefined)dg.datagrid('selectRecord', id);
		var node = dg.datagrid('getSelected');
		if (node) {
			loadFrom('#fm',node);
			
			$('#username').attr('readonly','readonly');
			
			if(node.des)$('#des').text(node.des);
			$('#pwd').val('');
			showDialog('#dlg','编辑用户');
			url='${CONTEXT_PATH}/system/user/edit';
		}
	}

	function addFun() {
		  $('#username').attr('readonly',false);
		  $('#fm').form('clear');
		  showDialog('#dlg','添加用户');
		  url='${CONTEXT_PATH}/system/user/add';
	}
	
	
 
	
	function submit(fm,dlg){
		
		
	      $(fm).form('submit',{
	                url: url,
	                success: function(result){
	                 result= $.parseJSON(result);
	                 if(result.code==200){
	                  $(dlg).dialog('close'); 
	                  dg.datagrid('reload');
	                  parent.layout_west_tree.tree('reload');
	                  }
	                else {
	                  $.messager.alert('提示',result.msg);
	                }
	             }
	       });		
	}
	
	
	function batchGrantFun() {
		var rows = dg.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			for ( var i = 0; i < rows.length; i++) {
				ids.push(rows[i].id);
			}
			$('#fm2').form('clear');
			$('#ids').val(ids);
			showDialog('#dlg-grant','批量授权');
			url='${CONTEXT_PATH}/system/user/batchGrant';
 
		} else {
			parent.$.messager.show({
				title : '提示',
				msg : '请勾选要授权的记录！'
			});
		}
	}
	
	
	
	function batchDeleteFun() {
		var rows = dg.datagrid('getChecked');
		var ids = [];
		if (rows.length > 0) {
			parent.$.messager.confirm('确认', '您是否要删除当前选中的项目？', function(r) {
				if (r) {
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
					var currentUserId = '${user.id}';/*当前登录用户的ID*/
					var flag = false;
					for ( var i = 0; i < rows.length; i++) {
						if (currentUserId != rows[i].id) {
							ids.push(rows[i].id);
						} else {
							flag = true;
						}
					}
					$.getJSON('${pageContext.request.contextPath}/system/user/batchDelete', {
						ids : ids.join(',')
					}, function(result) {
						if (result.code==200) {
							dg.datagrid('load');
							dg.datagrid('uncheckAll').dataGrid('unselectAll').datagrid('clearSelections');
						}
						if (flag) {
							parent.$.messager.show({
								title : '提示',
								msg : '不可以删除自己！'
							});
						} else {
							parent.$.messager.alert('提示', result.msg, 'info');
						}
						parent.$.messager.progress('close');
					});
				}
			});
		} else {
			parent.$.messager.show({
				title : '提示',
				msg : '请勾选要删除的记录！'
			});
		}
	}
	
 

</script>

</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 100px; overflow: hidden;">
			<form id="searchForm"  >
				<table    class="table table-hover table-condensed" style="display: none;"  >
				    <tr>
				    <th> 登录名</th>
				    <td><input name="name" placeholder="可以模糊查询登录名"  /></td>
				    <th>状态</th>
					    <td><select class="easyui-combobox" name="status" editable="false" >
					       <option value="1">正常	
					       <option value="2">在线 
					       <option value="3">冻结
					      </select></td>
					  </tr>
					<tr>
						<th>创建时间</th>
						<td  ><input  name="dateStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" />至<input  name="dateEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly="readonly" /></td>
					  
					  <th>角色</th>
					    <td><select class="easyui-combotree" name="role.id-i" editable="false"
					     data-options="url :'${pageContext.request.contextPath}/system/role/tree',
			              parentField : 'pid',
			              lines : true">
					      </select>
					      </td>
					
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table  id="dg"></table>
		</div>
	</div>
	<div id="toolbar" style="display: none;">
			<shiro:hasPermission name="/system/user/add"><a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a></shiro:hasPermission>
		    <shiro:hasPermission name="/system/user/batchGrant">
			<a onclick="batchGrantFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'tux'">批量授权</a>
			</shiro:hasPermission>
			 <shiro:hasPermission name="/system/user/batchDelete">
			<a onclick="batchDeleteFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'delete'">批量删除</a>
		   </shiro:hasPermission>
		    <shiro:hasPermission name="/system/user/serach">
		    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">过滤条件</a>
		    <a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();">清空条件</a>
         </shiro:hasPermission>

	</div>

	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
	<shiro:hasPermission name="/system/user/add"><a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'pencil_add'">添加</a></shiro:hasPermission>
			
			<shiro:hasPermission name="/system/user/delete">
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
			</shiro:hasPermission>
		    
		    <shiro:hasPermission name="/system/user/edit">
			<div onclick="editFun();" data-options="iconCls:'pencil'">编辑</div>
			</shiro:hasPermission>
	</div>

	<!--  dialog -->

	
 <div id="dlg"   class="easyui-dialog" style=" width:350px;height:320px;padding:5px 10px" closed="true" buttons="#dlg-buttons"  data-options="resizable:true,modal:true">
	
<div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="fm" method="post">
		<input name="user.id" type="hidden" >
			<table class="table table-hover table-condensed">
				<tr>
					<th>登录名称</th>
					<td><input name="user.name" id="username" type="text" placeholder="请输入登录名称" class="easyui-validatebox span2" data-options="required:true" value=""></td>
				</tr>
				<tr>
					<th>密码</th>
					<td><input name="user.pwd" id="pwd" type="password" placeholder="请输入密码" class="easyui-validatebox span2" data-options="required:true"></td>
				</tr>
				<tr>
					<th>描述</th>
					<td>
					<textarea rows="4" cols="5" name="user.des" id="des"></textarea>
					 </td>
				</tr>
			</table>
		</form>
	</div>
</div>
     </div>
 <div id="dlg-buttons">
        <a href="javascript:void(0)" class="easyui-linkbutton"   onclick="submit('#fm','#dlg')">确定</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dlg').dialog('close')">取消</a>
 </div> 
	
	
	
 <div id="dlg-grant"   class="easyui-dialog" style=" width:340px;height:150px;padding:5px 10px" closed="true" buttons="#dlg-buttons-grant"  data-options="resizable:true,modal:true">
	
  <div class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;">
		<form id="fm2" method="post">
		    <input id="ids" name="ids" type="hidden" class="span2"  >
			<input name="user.id" type="hidden" class="span2"  >
			<table class="table table-hover table-condensed">
				<tr>
					<th>所属角色</th>
					<td><select id="role_ids" name="role_ids" style="width: 140px; height: 29px;"></select><img src="${pageContext.request.contextPath}/js/ext/style/images/extjs_icons/cut_red.png" onclick="$('#role_ids').combotree('clear');" /></td>
				</tr>
			</table>
		</form>
	 </div>
    </div>
     </div>
    <div id="dlg-buttons-grant">
        <a href="javascript:void(0)" class="easyui-linkbutton"   onclick="submit('#fm2','#dlg-grant')">确定</a>
        <a href="javascript:void(0)" class="easyui-linkbutton"  onclick="javascript:$('#dlg-grant').dialog('close')">取消</a>
    </div> 

</body>
</html>
