<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>会议通知管理系统</title>
<meta http-equiv="content-type" content="text/html; Charset=UTF-8">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<script src="<%=basePath%>script/My97DatePicker/WdatePicker.js"></script>
<script src="<%=basePath%>script/jquery-1.9.1.min.js"></script>
<script>
$(document).ready(function(){
	$("tr").on("click","#search",function(){
		$("#queryform").attr("action",$("#action").val());
		$("#queryform").submit();
	});
	function clearForm(obj){
		$(obj).find(':input').not(':button, :submit, :reset, :hidden').val('')
		.removeAttr('checked').removeAttr('selected');
	}
});
</script>
</head>

<body>
	<table width="61%" border="1" cellspacing="0" bordercolordark="#FFFFFF"
		bordercolorlight="#006699" rules=all&nbsp;frame=above&nbsp;
		bordercolor="#006699">
<form id="queryform" method="post">

		<tr>
		
			<td height="1" width="100%" style="color: #003366" valign="left">
				<table width="70%" border="0" align="center">
					<tr>
					 <td colspan="2" align="center"><font size="2"><b>${ctrlname}</b></font></td>
					</tr>
					<tr style="height: 35px;">
						<td align="center">${name }</td>
						<td>
						<input type="text" name="_content" id="_content" size="60"/>
						</td>
					</tr>
					<c:if test="${department!='none' }">
					<tr style="height: 35px;">
						<td align="center">${department }</td>
						<td><select id="org" name="_org" class="Wdate"
							style="height: 20px;">
								<option value="">-------------</option>
								<c:forEach items="${orgs }" var="o">
									<option value="${o[0] }"
										<c:if test="${org == o[0] }">selected="selected"</c:if>>${o[1]}</option>
								</c:forEach></td>
					</tr>
					</c:if>
					<tr style="height: 35px;">
						<td align="center">${address }</td>
						<td><select name="_roomID" style="width: 260px;">
								<option value="">请选择会议室</option>
								<c:forEach items="${mrs }" var="mr">
									<option value="${mr.id }">${mr.building }${mr.room }</option>
								</c:forEach>
						</select></td>
					</tr>
					<tr style="height: 75px;">
						<td align="center">${meetingtime }</td>
						<td>
						<label for="starttime">开始日期:</label>
						<input class="Wdate" id="st" type="text" name="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'st2\')}'})" value="${starttime }" /> 
						<label for="starttime2">&nbsp;&nbsp;至:&nbsp;&nbsp;</label>
						<input class="Wdate" id="st2" type="text" name="" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'st\')}'})" value="${starttime2 }" /> 
						&nbsp;&nbsp;&nbsp;&nbsp; 
						<br/>
						<labelfor="endtime">结束日期:</label> 
						<input class="Wdate" id="et" type="text" name="_endtime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'et2\')}'})" value="${endtime }" />
						<label for="endtime2">&nbsp;&nbsp;至:&nbsp;&nbsp;</label>
						<input class="Wdate" id="et2" type="text" name="_endtime2" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'et\')}'})" value="${endtime2 }" />
						</td>
					</tr>
					<tr style="height: 35px;">
						<td colspan="2" style="text-align: center;"><input type="button" id="search" value="搜索" onclick="checkForm()"><input type="button" value="清空" onclick="clearForm(this.form)"></td>
						<input type="hidden" name="ctrl" id="ctrl" value="${ctrl }"/>
						<input type="hidden" name="action" id="action" value="${action }"/>
						<input type="hidden" name="from" id="from" value="${from }"/>
					</tr>
</form>
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
