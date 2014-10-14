<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	pageContext.setAttribute("ctx", request.getContextPath());
%>
<%@ include file="/pages/commons/taglibs.jsp"%>
<script type="text/javascript" src="${ctx}/js/common.js" charset="utf-8"></script>
	<div class="search-list-title">
		<h1>查询结果</h1>
	</div>
	<table width="100%" border="0" cellspacing="1" cellpadding="1">
		<tr>
			<td class="sub-title"><input type="checkbox" name="checkbox" id="checkbox" onclick="comUtil.checkBoxSelect(this,'testCheckboxId');"/> 
			<td class="sub-title">姓名</td>
			<td class="sub-title">年龄</td>
			<td class="sub-title">操作</td>
		</tr>
		<c:if test="${empty pageResult.resultList}">
			<tr>
				<td align="center" colspan="4"
					style="border-left: none; font-size: 14px;"><b>当前无记录</b></td>
			</tr>
		</c:if>
		<c:if test="${not empty pageResult.resultList}">
			<c:forEach items="${pageResult.resultList}" var="test"
				varStatus="index">
				<tr>
					<td><span class="sub-title"> <input type="checkbox" name="testCheckboxId" id="checkbox2" value="<c:out value="${test.id}"></c:out>"/> 
					<td><c:out value="${test.name }"></c:out></td>
					<td><c:out value="${test.age }"></c:out></td>
					<td>
						<input type="button" value="查看" class="btn_nosel_small" onclick="to_view(${test.id});" />
						<input type="button" value="修 改" class="btn_nosel_small" onclick="to_update(${test.id});" />
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</table>
	<div style="text-align: right;">
		<my:pageTag searchFunctionName="doSearch" pageResult="pageResult"
			id="pageBar" />
	</div>

