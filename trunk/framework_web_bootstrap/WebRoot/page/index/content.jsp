<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<jsp:include page="../common/inc.jsp"></jsp:include>


<!-- Main stylesheet -->
<link href="${CONTEXT_PATH}/css/msg-style/style.css" rel="stylesheet">
<!-- Widgets stylesheet -->
<link href="${CONTEXT_PATH}/css/msg-style/widgets.css" rel="stylesheet">

<!-- 引入EasyUI Portal插件 
-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/js/jquery-easyui-portal/portal.css" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-easyui-portal/jquery.portal.js" charset="utf-8"></script>


<script type="text/javascript">

	
function sendMsg(){
		
	  var msg =$('#msg').val();
	  
	  $.post('${CONTEXT_PATH}/index/msg/add',{'msg.msg':msg},function(result){
		  
		  if(result.code==200){
			 
			  $(".chats li").first().remove();
			   $('.chats').append("<li class='by-me'><div class='avatar pull-left'><img src='${CONTEXT_PATH}${user.attrs['icon']}'  /></div><div class='chat-content'><div class='chat-meta'>${user.name} <span class='pull-right'>1分钟前</span></div>"+msg+"<div class='clearfix'></div></div>");
		  }
		  else{
			  $.messager.show({
	                title:'error',
	                msg:result,
	                showType:'show'
	            });
		  }
		  
	  },'json');
		
	}
	
	
</script>

</head>
<body>
	<div id="portalLayout" >
		<div data-options="region:'center',border:false">
			<div id="portal" style="position: relative">
				<div></div>
				<div></div>
			</div>
		</div>
	</div>
</body>

<script type="text/javascript" charset="utf-8">

	var portalLayout;
	var portal;
	
	$(function() {
		
		portalLayout = $('#portalLayout').layout({
			fit : true
		});
		$(window).resize(function() {
			portalLayout.layout('panel', 'center').panel('resize', {
				width : 1,
				height : 1
			});
		});
	  panels = [
            {
          	id : 'p1',
	        title : 'log',
	        collapsible : true,
	        height : 250,
	        closable: true,
	        href : 'log.jsp'
            },
		      {
			id : 'p2',
			title : 'bug',
			collapsible : true,
			closable: true,
			href : 'bug.jsp'
	     	}
		, {
			id : 'p3',
			title : 'msg',
			closable: true,
			 height : 320,
			collapsible : true,
			href : '${CONTEXT_PATH}/index/msg/list'
		}, {
			id : 'p4',
			title : 'about',
			collapsible : true,
			closable: true,
			href : 'about.jsp'
		},
		{
		id : 'p5',
		title : 'chart',
		collapsible : true,
		closable: true,
		href : 'chart.jsp'
	     }
		
		];

		portal = $('#portal').portal({
			border : false,
			fit:true,
			onStateChange : function() {
				$.cookie('portal-state', getPortalState(), {
					expires : 7
				});
			}
		});
		
		var state = $.cookie('portal-state');
		
		if (!state) {
			state = 'p4,p2,p5:p1,p3';/*冒号代表列，逗号代表行*/
		}
	
		addPortalPanels(state);
		portal.portal('resize');

	});
	
	

	function getPanelOptions(id) {
		for ( var i = 0; i < panels.length; i++) {
			if (panels[i].id == id) {
				return panels[i];
			}
		}
		return undefined;
	}
	function getPortalState() {
		var aa = [];
		for ( var columnIndex = 0; columnIndex < 2; columnIndex++) {
			var cc = [];
			var panels = portal.portal('getPanels', columnIndex);
			for ( var i = 0; i < panels.length; i++) {
				cc.push(panels[i].attr('id'));
			}
			aa.push(cc.join(','));
		}
		return aa.join(':');
	}
	function addPortalPanels(portalState) {
		var columns = portalState.split(':');
		for ( var columnIndex = 0; columnIndex < columns.length; columnIndex++) {
			var cc = columns[columnIndex].split(',');
			for ( var j = 0; j < cc.length; j++) {
				var options = getPanelOptions(cc[j]);
				if (options) {
					var p = $('<div/>').attr('id', options.id).appendTo('body');
					p.panel(options);
					portal.portal('add', {
						panel : p,
						columnIndex : columnIndex
					});
				}
			}
		}
	}
</script>
</html>