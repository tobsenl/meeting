﻿<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>会议通知管理系统</title>
<meta Name="generator" Content="Microsoft FrontPage 4.0">
<meta Name="author" Content="">
<meta Name="keywords" Content="">
<meta Name="description" Content="">
<link Href="<%=basePath %>style/new.css" Rel="stylesheet" Type="text/css">
<meta Http-equiv="content-type" Content="text/html; Charset=UTF-8">
<script>
	function check() {
		var i = 0;
		var k = 0;
		var x = 1;
		var y = 1;
		for ( var j = 0; j < form1.elements.length; j++) {
			if (form1.elements[j].name == "approve") {
				if (form1.elements[j].checked) {
					if (form1.elements[j + 1].checked) {
						alert("不能对同一条记录同时选择批准和拒批！");
						return false;
					}
					i++;
				}
			} else if (form1.elements[j].name == "disapprove") {
				if (form1.elements[j].checked) {
					k++;
				}
			}
		}

		if (i == 0 && k == 0) {
			alert("提示：请选择审核项或者拒批项！");
			return false;
		} else {
			//如果审核没有被选中的项
			if (i == 0) {
				x = 0;
			}
			//如果拒批没有被选中的项
			if (k == 0) {
				y = 0;
			}
			form1.agree.value = x;
			form1.disagree.value = y;
			form1.ctrl.value = "approved";
			form1.action = "MeetingTrainingServlet";
			form1.submit();
		}
	}
</script>
</head>
<body>
<div class="container">
		<jsp:include page="/index/top.jsp"></jsp:include>
		<div>
			<form name="form1" method=post  action="">
				<table class="dtable" align="center" cellpadding="1" cellspacing="1">
					<tr>
						<th width="13%" align="center">日期</th>
						<th width="15%" align="center">课程名称</th>
						<th width="7%" align="center">教员名称</th>
						<th width="16%" align="center">参加单位/人员</th>
						<th width="15%" align="center">有关说明</th>
						<th width="7%" align="center">申请教室</th>						
						<th width="7%" align="center">申请人</th>
						<th width="10%" align="center">申请部门<br/>日期</th>
						<th width="5%" align="center">批准</th>
						<th width="5%" align="center">拒批</th>
					</tr>
					<c:forEach items="${meetings }" var="m">
						<tr>
						<td width="13%" align="center"><fmt:formatDate
								value="${m.starttime }" pattern="E" /><br /> <fmt:formatDate
								value="${m.starttime }" pattern="yyyy-MM-dd HH:mm" /><br />
							<fmt:formatDate value="${m.endtime }"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<TD width="15%" align="center">${m.content }</TD>
						<TD width="7%" align="center">${m.presider }</TD>
						<TD width="16%" align="center">${m.depart }<br />${m.fdepart }</TD>
						<TD width="15%" align="center">${m.remark }</TD>
						<td width="7%" align="center">${m.reserve_address }</td>
						<TD width="7%" align="center">${m.commiterid }</TD>
						<TD width="10%" align="center">${m.commitdepart }<br />
								<fmt:formatDate value="${m.committime }"
									pattern="yyyy-MM-dd HH:mm" /></TD>
						<TD width="5%" align="center"><input name="approve" type="checkbox" value="${m.id }"/></TD>
						<TD width="5%" align="center"><input name="disapprove" type="checkbox" value="${m.id }"/></TD>
					</tr>
					</c:forEach>

					<tr bgcolor="#FFFFFF">
						<TD colspan="10" align="center">
							<INPUT style="COLOR: #44606B; background-color: #FFFFFF" type="button" name="" value=" 提交 " onclick="check()">
							&nbsp;&nbsp; &nbsp; 
							<INPUT style="COLOR: #44606B; background-color: #FFFFFF" type="reset" name="" value=" 重置 "></TD>
					</tr>
				</table>
				<input type="hidden" name="agree" value=""> 
				<input type="hidden" name="disagree" value=""> 
				<input type="hidden" name="ctrl" value="">
			</form>
		</div>
	</div>
	<jsp:include page="/index/bottom.jsp"/>
</body>
</html>





