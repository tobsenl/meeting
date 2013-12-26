﻿<%@page pageEncoding="utf-8" language="java" contentType="text/html; charset=utf-8"%>
<%@include file="../include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<script src="<%=basePath%>script/jquery-1.9.1.min.js"></script>
<link Href="<%=basePath%>style/new.css" Rel="stylesheet" Type="text/css">
<script type="text/javascript" src="<%=basePath %>script/common.js"></script>
</head>
<body>

	<div class="container">
		<jsp:include page="/index/top.jsp" />
		<div>
			<form id="form1" action="MeetingRoomServlet" method="post">
				<label for="building">${value }:</label> <input id="building" name="_building" type="text"
					value="${building }" size="35"> &nbsp;&nbsp; <label for="room">房间号:</label> <input
					id="room" name="_room" type="text" value="${room }" size="35"> &nbsp;&nbsp; <input
					style="COLOR: #44606B; background-color: #FFFFFF" type="submit" value="搜索">
				&nbsp;&nbsp; <input style="COLOR: #44606B; background-color: #FFFFFF" type="button" value="清空"
					onclick="clearForm(this.form)"> <input type="hidden" name="ctrl" value="list" /><input type="hidden" name="from" value="${from }" />
			</form>
		</div>
		<div>

			<table class="dtable" align="center" cellpadding="1" cellspacing="1">
				<tr>
					<th width="5%" align="center">序号</th>
					<th width="25%" align="center">${value }</th>
					<th width="20%" align="center">房间号</th>
					<th width="10%" align="center">容纳人数</th>
					<th width="25%" align="center">说明</th>
					<th width="15%" align="center">操作</th>
				</tr>
				<c:forEach items="${mrs }" var="mr" varStatus="i">
					<tr>
						<td width="5%" align="center">${i.count }</td>
						<td width="25%" align="center">${mr.building }</td>
						<td width="20%" align="center">${mr.room }</td>
						<td width="10%" align="center">${mr.capacity }</td>
						<td width="25%" align="center">${mr.remark }</td>
						<td width="15%" align="center"><a href="MeetingRoomServlet?ctrl=toUpdate&from=${from }&id=${mr.id }">修改</a>
							<a href="javascript:confirmDelete('<%=basePath%>MeetingRoomServlet?ctrl=del&id=${mr.id }')">删除</a></td>
					</tr>
				</c:forEach>
				<tr>
					<td align="right" colspan="6">${tag }</td>
				</tr>
			</table>
			<br>
			<br>
		</div>
	</div>
	<jsp:include page="/index/bottom.jsp" />

</body>
</html>
