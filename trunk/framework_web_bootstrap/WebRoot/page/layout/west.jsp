<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">


    var layout_west_tree;
	// 加入 url tree 
    var layout_west_tree_url = '${CONTEXT_PATH}/system/res/tree';
	
	
	$(function() {
		layout_west_tree = $('#layout_west_tree').tree({
			url : layout_west_tree_url,
			parentField : 'pid',
			lines : true,
			onClick : function(node) {
				if (node.attributes && node.attributes.url) {
					var url;
					if (node.attributes.url.indexOf('/') == 0) {/*如果url第一位字符是"/"，那么代表打开的是本地的资源*/
						url = '${CONTEXT_PATH}' + node.attributes.url;
						if (url.indexOf('/druid') == -1 &&url.indexOf('/monitoring') == -1&&url.indexOf('/error') == -1) {/*如果不是druid相关的控制器连接，那么进行遮罩层屏蔽*/
							parent.$.messager.progress({
								title : '提示',
								text : '数据处理中，请稍后....'
					 		});
						}
						
					} else {/*打开跨域资源*/	
						url = node.attributes.url;
						}
					addTab({
						url : url,
						title : node.text,
						iconCls : node.iconCls
					});
				}
			},
			onBeforeLoad : function(node, param) {
			 
				if (layout_west_tree_url) {//只有刷新页面才会执行这个方法
					parent.$.messager.progress({
						title : '提示',
						text : '数据处理中，请稍后....'
					});
				}
			},
		 	onLoadSuccess : function(node, data) {
		 	
				parent.$.messager.progress('close');
			}
		});
	});

	function addTab(params) {
	
		var iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:98%;" ></iframe>';

		// if http url  jia js close
	    if(params.url&&params.url.indexOf('http') == 0){
	    iframe = '<iframe src="' + params.url + '" frameborder="0" style="border:0;width:100%;height:98%;" security="restricted" sandbox="" ></iframe>';
		}
	    
		var t = $('#index_tabs');
		var opts = {
			title : params.title,
			closable : true,
			iconCls : params.iconCls,
			content : iframe,
			border : false,
			fit : true
		};
		if (t.tabs('exists', opts.title)) {
			t.tabs('close', opts.title);
			t.tabs('add', opts);
		} else {
			t.tabs('add', opts);
		}
		
		//parent.$.messager.progress('close');
	}
</script>
<div class="easyui-accordion" data-options="fit:true,border:false">
	<div title="功能菜单" style="padding: 5px;" data-options="border:false,isonCls:'anchor',tools : [ {
				iconCls : 'database_refresh',
				handler : function() {
					$('#layout_west_tree').tree('reload');
				}
			}, {
				iconCls : 'resultset_next',
				handler : function() {
					var node = $('#layout_west_tree').tree('getSelected');
					if (node) {
						$('#layout_west_tree').tree('expandAll', node.target);
					} else {
						$('#layout_west_tree').tree('expandAll');
					}
				}
			}, {
				iconCls : 'resultset_previous',
				handler : function() {
					var node = $('#layout_west_tree').tree('getSelected');
					if (node) {
						$('#layout_west_tree').tree('collapseAll', node.target);
					} else {
						$('#layout_west_tree').tree('collapseAll');
					}
				}
			} ]">
		<div class="well well-small">
			<ul id="layout_west_tree"></ul>
		</div>
	</div>

	
	
	
</div>