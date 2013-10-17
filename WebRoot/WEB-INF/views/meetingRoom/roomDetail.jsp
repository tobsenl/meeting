<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<table>
<tr  class="dtable" >
	<th width="25%" align="center">培训所在楼</th>
	<th width="20%" align="center">房间号</th>
	<th width="10%" align="center">容纳人数</th>
	<th width="25%" align="center">说明</th>
</tr>
<tr>
<th width="25%" align="center">${mr.building }</th>
	<th width="20%" align="center">${mr.room }</th>
	<th width="10%" align="center">${mr.capacity }</th>
	<th width="25%" align="center">${mr.remark }</th>
</tr>
</table>
<br/>
<c:if test="${fn:length(meetings)<= 0 }">
	<font color="green"> 该教室没有安排会议和培训</font>
</c:if>
<c:if test="${fn:length(meetings)> 0 }">
<table class="dtable" >
	<tr>
		<th>时间</th>
		<th>会议</th>
		<th>状态</th>
	</tr>
	<c:forEach items="${meetings }" var="m">
	<tr>
		<td><fmt:formatDate value="${m.starttime }" pattern="yyyy-MM-dd HH:mm" />-<fmt:formatDate value="${m.endtime }" pattern="yyyy-MM-dd HH:mm"/></td>
		<td>${m.content }</td>
		<td> <font color="red"> 已预订或正在使用</font> </td>
	</tr>
	</c:forEach>
</table>
</c:if>
	
</body>
</html>