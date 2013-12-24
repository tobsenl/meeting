<%@page import="cn.com.jnpc.meeting.bean.Meeting"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
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
</head>

<body style="y-overflow: scroll;">
	<table width="100%" border="1" align="center" cellspacing="0"
		bordercolordark="#FFFFFF" bordercolorlight="#006699"
		rules=all&nbsp;frame=center&nbsp; bordercolor="#006699"
		style="color: #006699;empty-cells: show;" class="css">

		<tr>
			<TD width="7%" align="center" style="color: #003366"><b>${day }</b></TD>
			<TD width="10%" align="center" style="color: #003366"><b>${time }</b></TD>
			<TD width="20%" align="center" height="26" style="color: #003366"><b>${name }</b></TD>
			<TD width="8%" align="center" height="26" style="color: #003366">
				<p align="center">
					<b>${ren }</b>
				</p>
			</TD>
			<TD width="17%" align="center" height="26" style="color: #003366"><b>${danwei }</b></TD>
			<TD width="9%" align="center" height="26" style="color: #003366"><b>${addre }</b></TD>
			<TD width="29%" align="center" height="26" style="color: #003366"><b>${people }</b></TD>

		</tr>
					<%
						List list=(List)request.getAttribute("meetings");
						List[] listarray =(List[])list.get(0);
						for(int i=0;i<listarray.length;i++){
							List listnew=listarray[i];
							String week = listnew.get(0).toString();
							String date = listnew.get(1).toString();
								//这一天里面的会议记录数	    		
							int rowSpan = listnew.size()-2;
							for(int j=2;j<listnew.size();j++){
								Meeting meet=(Meeting)listnew.get(j);
								if(j==2){
									%>
								<tr>
								<td width="7%" valign="middle" align="center" rowspan="<%=rowSpan %>" style="color: #003366">
									<%=week %><p><%=date %></p>
								</td>
									<%
								}else{
								%>
								<tr>
								<%
								}
									%>
								<td width="10%" align="center"><br />
									<%=(meet.getReserve_address()==null?"":meet.getReserve_address()) %>
								</td>
								<td width="20%" align="center"><%=(meet.getContent()==null?"":meet.getContent()) %></td>
								<td width="8%" align="center"><%=(meet.getPresider()==null?"":meet.getPresider()) %></td>
								<td width="17%" align="center"><%=(meet.getAddress1()==null?"":meet.getAddress1()) %></td>
								<td width="9%" align="center"><%=(meet.getDetail()==null?"":meet.getDetail()) %></td>
								<td width="29%" align="center"><%=(meet.getDepart()==null?"":meet.getDepart())%></td>
								</tr>
								<%
							}
						}
					%>
		<tr>
			<td align="right" height="20px" colspan="11">${tag }</td>
		</tr>
	</table>
</body>
</html>
