<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<%@ include file="/pages/common/_taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/common.js" charset="utf-8"></script>
<div class="search-list-title">
	<h1>查询结果</h1>
</div>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr align="center">
		<td class="sub-title">序号</td>
		<td class="sub-title">名称</td>
		<td class="sub-title">登录名</td>
		<td class="sub-title">手机号</td>
		<td class="sub-title">邮箱</td>
		<td class="sub-title">创建时间</td>
		<td class="sub-title">操作</td>
	</tr>
	<c:if test="${empty page.list}">
		<tr>
			<td align="center" colspan="11" style="border-left: none; font-size: 14px;"><b>当前无记录</b></td>
		</tr>
	</c:if>
	<c:if test="${not empty page.list}">
		<c:forEach items="${page.list}" var="entity"
			varStatus="index">
			<tr align="center">
				<td><c:out value="${entity.id}"></c:out></td> 
				<td><a onclick="to_view(${entity.id})"><c:out value="${entity.name}"></c:out></a></td> 
				<td><c:out value="${entity.login_name }"></c:out></td>
				<td><c:out value="${entity.mobile }"></c:out></td><!--sysStartTime  -->
				<td><c:out value="${entity.email}"></c:out></td><!-- sysnEndTime -->
				<td><c:out value="${entity.create_time }"></c:out></td>
				<td>
					<input type="button" value="修改" class="btn_nosel_small" onclick="to_update(${entity.id});" />
					<input type="button" value="删除" class="btn_nosel_small" onclick="to_view(${entity.id});" />
				</td>
			</tr>
		</c:forEach>
	</c:if>
</table>
<div style="text-align: right;">
	<%-- <my:pageTag searchFunctionName="doSearch" pageResult="pageResult" id="pageBar" /> --%>
</div>

