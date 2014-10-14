<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>

<!DOCTYPE html>
<html>
<head>
<title>Log管理</title>
<jsp:include page="../common/inc.jsp"></jsp:include>
   
<script src="${pageContext.request.contextPath}/js/Highcharts-3.0.1/js/highcharts.js"></script>
<script src="${pageContext.request.contextPath}/js/Highcharts-3.0.1/js/modules/exporting.js"></script>

  

<script type="text/javascript">
	var dataGrid;
	$(function() {
		
		
		$('#operation').combobox({
		    valueField:'operation',
		    textField:'value',
		    data:[ {
		    	operation: '1',
		    	value:'访问'
		    },{
		    	operation:'2' ,
		    	value:'登录'
		    },{
		    	operation:'3' ,
		    	value:'添加事件'
		    },{
		    	operation:'4' ,
		    	value:'编辑事件'
		    },{
		    	operation:'5' ,
		    	value:'删除事件'
		    },{
		    	operation:'6' ,
		    	value:'授权事件'
		    }]
   		  });		
		
		
		
		
		dataGrid = $('#dataGrid').datagrid({
			url : '${CONTEXT_PATH}/system/log/list',
			fit : true,
			fitColumns : true,
			border : false,
			pagination : true,
			idField : 'id',
			pageSize : 15,
			pageList : [ 15, 30, 45, 60, 75 ],
			sortName : 'date',
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
				field : 'operation',
				title : '事件名称',
				width : 80,
				sortable : true,
				formatter:function(value){
					if(value=='1') return '访问';
					if(value=='2') return '登录';
					if(value=='3') return '添加';
					if(value=='4') return '编辑';
					if(value=='5') return '删除';
					if(value=='6') return '授权';
				}
			} ] ],
			columns : [[ {
				field:'user_name',
				title:'操作用户',
				width:50,
			},
			{
				field : 'ip',
				title : 'ip',
				width : 50,
				sortable : true
			},
			{
				field : 'from',
				title : '来源',
				width : 220,
				formatter:function(value,row){
					
					if(value&&value.indexOf('loginView')!=-1) return'';
					else if(value&&row.operation=='访问') return value;
					else return '';
				}
			}
			,
			{
				field : 'date',
				title : '日期',
				width : 100,
				sortable : true
			},{
				field : 'action',
				title : '操作',
				width : 40,
				formatter : function(value, row, index) {
					var str = '';
						str += $.formatString('<shiro:hasPermission name="/system/log/delete"> <img onclick="deleteFun(\'{0}\');" src="{1}" title="删除"/> </shiro:hasPermission>', row.id, '${CONTEXT_PATH}/js/ext/style/images/extjs_icons/delete.png');
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
		
		$('.datagrid-wrap').append("<div id='main'   ></div>");
		  
	});

	function deleteFun(id) {
		if (id == undefined) {
			var rows = dataGrid.datagrid('getSelections');
			id = rows[0].id;
		}
		parent.$.messager.confirm('询问', '您是否要删除当前log？', function(b) {
			if (b) {
				parent.$.messager.progress({
					title : '提示',
					text : '数据处理中，请稍后....'
				});
				$.post('${CONTEXT_PATH}/system/log/delete', {
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


	function searchFun() {
		
		if($('.datagrid-view').is(':hidden')) initChart();
		else dataGrid.datagrid('load', $.serializeObject($('#searchForm')) );
		
	}
	function cleanFun() {
		
		  $('#searchForm input').val('');

		 if($('.datagrid-view').is(':hidden')) initChart();
		else dataGrid.datagrid('load', {});
	}
	
	
	function chart(){
		$('.datagrid-view').toggle();
		
		$('.datagrid-pager').toggle();
		
		if($('.datagrid-view').is(':hidden')){
		
 	    	$('#operation').combobox({
		    valueField:'operation',
		    textField:'value',
		    data:[ {
		    	operation: '1',
		    	value:'访问'
		    },{
		    	operation:'2' ,
		    	value:'登录'
		    }]
   		  });		
		  initChart();
	    }
		else{
			$('#operation').combobox({
			    valueField:'operation',
			    textField:'value',
			    data:[ {
			    	operation: '1',
			    	value:'访问'
			    },{
			    	operation:'2' ,
			    	value:'登录'
			    },{
			    	operation:'3' ,
			    	value:'添加事件'
			    },{
			    	operation:'4' ,
			    	value:'编辑事件'
			    },{
			    	operation:'5' ,
			    	value:'删除事件'
			    },{
			    	operation:'6' ,
			    	value:'授权事件'
			    }]
	   		  });		
			
		}
	}
	
	
	
	function excel(){
		
		url='${CONTEXT_PATH}/system/log/excel';
		
		$('#searchForm').form('submit',{url:url});
		
	}
	
	
 function initChart(url){
	 

	 $.post('${CONTEXT_PATH}/system/log/chart',$.serializeObject($('#searchForm')),function(data){
			
		    $('#main').highcharts({
		        title: {
		            text: 'User line chart',
		            x: -20 //center
		        },
		        credits : {
					enabled : false
				},
		        xAxis: {
		            categories: data.categories
		        },
		        yAxis: {
		            plotLines: [{
		                value: 0,
		                width: 1,
		                color: '#808080'
		            }]
		        },
		        legend: {
		            layout: 'vertical',
		            align: 'right',
		            verticalAlign: 'middle',
		            borderWidth: 0
		        },
		        series: data.series
		    });
			
			} ,'json');
 }
	
	
</script>
</head>
<body>
	<div class="easyui-layout" data-options="fit : true,border : false">
		<div data-options="region:'north',title:'查询条件',border:false" style="height: 120px; overflow: hidden;">
			<form id="searchForm" method="post">
				<table class="table table-hover table-condensed" style="display: none;">
					<tr>
						<th>事件类型</th>
						<td>
						<select name="operation" id="operation" class="easyui-combobox" data-options="width:140,height:29,editable:false,panelHeight:'auto'"> 
						</select></td>
					</tr>
					<tr>
						<th>日期</th>
						<td colspan="3"><input class="span2" name="dateStart" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
						至<input class="span2" name="dateEnd" placeholder="点击选择时间" onclick="WdatePicker({readOnly:true,dateFmt:'yyyy-MM-dd HH:mm:ss'})" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div data-options="region:'center',border:false">
			<table id="dataGrid"></table>
		</div>
	</div>
	
	<div id="toolbar" style="display: none;">
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_add',plain:true" onclick="searchFun();">过滤条件</a>
		<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'brick_delete',plain:true" onclick="cleanFun();">清空条件</a>
		<shiro:hasPermission name="/system/log/chart">
	  <a href="javascript:void(0);" id="chart"  class="easyui-linkbutton" data-options="iconCls:'chart_bar',plain:true" onclick="chart();">查看统计图</a>
	</shiro:hasPermission>
	
	<shiro:hasPermission name="/system/log/excel">
	  <a href="javascript:void(0);"    class="easyui-linkbutton" data-options="iconCls:'excel',plain:true" onclick="excel();">导出Excel</a>
	</shiro:hasPermission>
	
	</div>
	<div id="menu" class="easyui-menu" style="width: 120px; display: none;">
			<div onclick="deleteFun();" data-options="iconCls:'pencil_delete'">删除</div>
	</div>
</body>

</html>