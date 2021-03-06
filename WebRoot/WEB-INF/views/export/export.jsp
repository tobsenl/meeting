<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link Href="<%=path%>/style/new.css" Rel="stylesheet" Type="text/css">
<script src="<%=path%>/script/jquery-1.9.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		var date = new Date();
		var year = date.getFullYear();
		for ( var i = year - 4; i < year + 4; i++) {
			if (i == year) {
				$("#year").append('<option value="'+i+'" selected="selected">' + i+ '</option>');
			} else {
				$("#year").append('<option value="'+i+'">' + i+ '</option>');
			}
		}
		var month = date.getMonth() + 1;
		for ( var i = 1; i <= 12; i++) {
			if (i == month) {
				$("#month").append(
						'<option value="'+i+'" selected="selected">' + i
								+ '</option>');
			} else {
				$("#month").append('<option value="'+i+'">' + i + '</option>');
			}
		}

		
	});
</script>
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<jsp:include page="/index/top.jsp" />
		<div style="width: 500px;margin: 0 auto;">
			<form method="post" action="<%=path %>/export">
				<fieldset style="text-align: left;width: 500px;">
					<legend>Excel数据导出</legend>
					<br/>
					<div style="float: left;margin-left: 20px;width: 300px；">
						<div style="float: left;margin-left: 20px;height: 45px;">
							日期：<select id="year" name="year"></select> 年
							<select id="month" name="month"></select>月 
						</div><br/>
						<div style="float: left;margin-left: 20px;height: 45px;">
							部门：<select id="org" name="org">
								<option value="">全部</option>
								<c:forEach var="org" items="${orgs }">
									<option value="${org[0] }">${org[1] }</option>
								</c:forEach>
							</select>
						</div><br/>
						<div style="float: left;margin-left: 20px;height: 35px;">
							数据类型：<input name="ctrl" value="exportMeeting" type="radio" checked="checked"/> 实际会议
							<input name="ctrl" value="exportPlan" type="radio"/> 计划会议
						</div><br/>
						<div style="float: left;height: 35px;margin-left: 20px;width: 300px;text-align: center;">
							<input type="submit" value="导出" style="text-align: center;"/>
						</div>
					</div>
				</fieldset>
			</form>

		</div>
	</div>
	<jsp:include page="/index/bottom.jsp" />
</body>
</html>