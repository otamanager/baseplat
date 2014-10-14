<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8">
<!-- Title and other stuffs -->

<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Stylesheets -->
<link href="${CONTEXT_PATH}/css/msg-style/bootstrap.css" rel="stylesheet">

<!-- Main stylesheet -->
<link href="${CONTEXT_PATH}/css/msg-style/style.css" rel="stylesheet">
<!-- Widgets stylesheet -->
<link href="${CONTEXT_PATH}/css/msg-style/widgets.css" rel="stylesheet">

<script type="text/javascript" src="${CONTEXT_PATH}/js/jquery-1.8.3.js"></script>

<script type="text/javascript">
	
function sendMsg(){
		
	  var msg =$('#msg').val();
	  
	  $.post('${CONTEXT_PATH}/index/msg/add',{'msg.msg':msg},function(result){
		  
		  if(result.code==200){
		   $('.chats').append("<li class='by-me'><div class='avatar pull-left'><img src='${CONTEXT_PATH}${user.attrs['icon']}'  /></div><div class='chat-content'><div class='chat-meta'>${user.name} <span class='pull-right'>1分钟前</span></div>"+msg+"<div class='clearfix'></div></div>");
		  }
		  else {
			  $.messager.show({
	                title:'error',
	                msg:result.msg,
	                showType:'show'
	            });
		  }
		  
	  },'json');
		
		
	}
	
	
</script>

</head>

<body>

	<!-- Widget -->
	<div class="widget">
		<!-- Widget title -->
		<div class="widget-content">
			<!-- Widget content -->
			<div class="padd">
				<ul class="chats">

					<c:forEach var="m" items="${list}">
						<c:choose>
							<c:when test="${m.uid== user.id}">
									<li class="by-me">
									<div class="avatar pull-left">
							</c:when>
							<c:otherwise>
								<li class="by-other">
									<div class="avatar pull-right">
							</c:otherwise>
						</c:choose>
						<img src="${CONTEXT_PATH}${m.icon}" alt="" />
              			</div>
		                 <div class="chat-content">
			              <div class="chat-meta">
		     			     ${m.name} <span class="pull-right">${m.date}</span>
		            		</div>
		      	            	${m.msg}
		                	<div class="clearfix"></div>
		                	</div>
		                	
		                 </c:forEach>
		                </ul>

		</div>
		<!-- Widget footer -->
		<div class="widget-foot">
			<form class="form-inline">
				<div class="form-group">
					<input type="text"  id="msg" class="form-control" placeholder="Send your message here...">
					<button type="button" class="btn btn-default" onclick="sendMsg()">Send</button>
				</div>
			</form>

		</div>
	</div>
</body>
</html>
