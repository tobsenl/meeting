<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>会议通知管理系统</title>
<link Href="<%=basePath%>style/new.css" Rel="stylesheet" Type="text/css">
<script src="<%=basePath%>script/My97DatePicker/WdatePicker.js"></script>
<script src="<%=basePath%>script/jquery-1.9.1.min.js"></script>
<script src="<%=basePath%>script/common.js"></script>
<meta Http-equiv="content-type" Content="text/html; Charset=UTF-8">
<script src="<%=basePath%>script/jquery.form.js" type="text/javascript"></script>
<!-- dialog -->
<script src="<%=basePath%>script/ui/jquery.ui.core.js" type="text/javascript"></script>
<script src="<%=basePath%>script/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script src="<%=basePath%>script/ui/jquery.ui.mouse.js" type="text/javascript"></script>
<script src="<%=basePath%>script/ui/jquery.ui.button.js" type="text/javascript"></script>
<script src="<%=basePath%>script/ui/jquery.ui.draggable.js" type="text/javascript"></script>
<script src="<%=basePath%>script/ui/jquery.ui.position.js" type="text/javascript"></script>
<script src="<%=basePath%>script/ui/jquery.ui.resizable.js" type="text/javascript"></script>
<script src="<%=basePath%>script/ui/jquery.ui.dialog.js" type="text/javascript"></script>
</head>
<script type="text/javascript">
	function clearForm(obj){
		$(obj).find(':input').not(':button, :submit, :reset, :hidden').val('')
		.removeAttr('checked').removeAttr('selected');
	}
	function update(url){
		//url2 = window.location.href;
		window.location.href = url/* +"&url="+url2.substring(url2.indexOf('/meeting')).replace(/\&/g,"%26") */;
	}
	function uppage(){
		var page=Number($("#page").val())+1;
		if((page-1) =="${tolpage}"){
			$("#dd").hide();
			return false;
		}else{
			$("#page").val(page);
			return page;
		}
	}
	function xingqi(obj){
		var time=obj.split(" ");
		time=time[0].split("-");
		var weekDay=["星期天","星期一","星期二","星期三","星期四","星期五","星期六","星期七"];
		var year=time[0],month=time[1],day=time[2];
		var dt=new Date(year,month,day);
		return weekDay[dt.getDay()];
	}
	function time(obj){
		var time=obj.split(" ");
		var month=time[0];
		var days=time[1];
		var day=days.split(",");
		if(month== "Jan"){
			var newtime=time[2]+"-"+01+"-"+day[0]+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "Feb"){
			var newtime=time[2]+"-"+02+"-"+day[0]+" "+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "Mar"){
			var newtime=time[2]+"-"+03+"-"+day[0]+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "apr"){
			var newtime=time[2]+"-"+04+"-"+day[0]+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "May"){
			var newtime=time[2]+"-"+05+"-"+day[0]+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "June"){
			var newtime=time[2]+"-"+06+"-"+day[0]+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "July"){
			var newtime=time[2]+"-"+07+"-"+day[0]+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "Aug"){
			var newtime=time[2]+"-"+08+"-"+day[0]+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "Sept"){
			var newtime=time[2]+"-"+09+"-"+day[0]+" "+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "Oct"){
			var newtime=time[2]+"-"+10+"-"+day[0]+e+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "Nov"){
			var newtime=time[2]+"-"+11+"-"+day[0]+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}else if(month== "Dec"){
			var newtime=time[2]+"-"+12+"-"+day[0]+time[3];
			var hours=time[3];
			var hour=hours.split(":");
			newtime=time[2]+"-"+11+"-"+day[0]+" "+hour[0]+":"+hour[1];
			return newtime;
		}
			return null;
	}
	function on(){
		var forword="${forword}";
		forword=forword.replace("ctrl=list","ctrl=addtable");
		var pageNo=uppage();
		$.ajax({
			url: forword+pageNo,
			dataType: "json",
			success: function(info_){
				var maxlength_=info_.length;
				for(var i=0;i<maxlength_;i++){
					var mc=info_[i];
					var atable="";
					//alert(maxlength_);
					atable=atable+"<tr>";
					atable=atable+"<td align='center'>";
			    	atable=atable+xingqi(time(mc.starttime));
			    	atable=atable+"<br/>"+time(mc.starttime);
			    	atable=atable+"<br/>"+time(mc.endtime);
			    	atable=atable+"</td>";
			    	atable=atable+"<td align='center'>";//会议名称
			    	atable=atable+mc.content;
			    	atable=atable+"</td>";
			    	atable=atable+"<td align='center'>";//主持人
			    	if(mc.presider !=undefined){
			    		atable=atable+mc.presider;
			    	}else{
			    		atable=atable+"&nbsp;";			    		
			    	}
			    	atable=atable+"</td>";
			    	atable=atable+"<td align='center'>";//公司领导
			    	if(mc.leader !=undefined){
			    		atable=atable+"<p align='center'>"+mc.leader+"</p>";
			    	}else{
			    		atable=atable+"&nbsp;";			    		
			    	}
			    	atable=atable+"</td>";
			    	atable=atable+"<td align='center'>";//参加人员
			    	if(mc.depart !=undefined){
			    		atable=atable+mc.depart;
			    	}else{
			    		atable=atable+"&nbsp;";			    		
			    	}
			    	if(mc.fdepart!=undefined){
			    		atable=atable+"<br />"+mc.fdepart;
			    	}else{
			    		atable=atable+"&nbsp;";			    		
			    	}
			    	atable=atable+"</td>";
			    	atable=atable+"<td  align='center'>";//有关说明
			    	if(mc.remark!=undefined){
			    		atable=atable+mc.remark;
			    	}else{
			    		atable=atable+"&nbsp;";			    		
			    	}
			    	atable=atable+"</td>";
			    	atable=atable+"<td align='center'>";//地点
			    	if(mc.type ==3){
			    		if(mc.address ==undefined){
				    		atable=atable+"&nbsp;";
				    	}else{
			    		atable=atable+mc.address;
			    		}
			    	}else if(mc.type !=3){
			    		if(mc.address1 ==undefined){
				    		atable=atable+"&nbsp;";
				    	}else{
			    		atable=atable+mc.address1;
			    		}
			    	}
			    	atable=atable+"</td>";
			    	atable=atable+"<td align='center'>";//状态
			    	if(mc.status =='0'){
			    		atable=atable+"未处理";
			    	}else if(mc.status =='1'){
			    		atable=atable+"已审批";
			    	}else if(mc.status =='2'){
			    		atable=atable+"拒批";
			    	}else if(mc.status =='3'){
			    		atable=atable+"已安排会议室";
			    	}else if(mc.status =='4'){
			    		atable=atable+"退回";
			    	}
			    	atable=atable+"</td>";
			    	atable=atable+"<td align='center'>";
			    	atable=atable+(mc.contact==undefined?"&nbsp;":mc.contact);
			    	atable=atable+"</td><td align='center'>";
			    	atable=atable+(mc.contactphone==undefined?"&nbsp;":mc.contactphone);
			    	atable=atable+"</td>";
			    	atable=atable+"<td align='center'>";//申请部门
			    	atable=atable+mc.commitdepart+"<br /> "+time(mc.committime);
			    	atable=atable+"</td>";
			    	atable=atable+"</tr>";
					if(i<=maxlength_-1){
						var length=$("#dtable tr").length-2;
						$("#dtable tr:eq("+length+")").after(atable);
					}
				}
			},
			});
	}
</script>
<body>
	<div class="container">
		<jsp:include page="/index/top.jsp"></jsp:include>
		<div style="height: auto; text-align: center; margin: 0 auto;">
			<form id="form1" action="MeetingServlet" method="post">
				<label for="roomID">会议室:</label> <select name="_roomID" style="width: 260px;">
					<option value="">请选择会议室</option>
					<c:forEach items="${mrs }" var="mr">
						<option value="${mr.id }">${mr.building }${mr.room }</option>
					</c:forEach>
				</select> &nbsp;&nbsp;&nbsp;&nbsp; <label for="org">部门:</label> <select id="org" name="_org"
					class="Wdate" style="height: 20px;">
					<option value="">-------------</option>
					<c:forEach items="${orgs }" var="o">
						<option value="${o[0] }" <c:if test="${org == o[0] }">selected="selected"</c:if>>${o[1]
							}</option>
					</c:forEach>
				</select> &nbsp;&nbsp;&nbsp;&nbsp; <label for="content">会议类容:</label> <input id="content" name="_content"
					type="text" value="${content }" size="35"><br />
				<br /> <label for="starttime">开始日期:</label> <input class="Wdate" id="st" type="text"
					name="_starttime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'st2\')}'})"
					value="${starttime }" /> <label for="starttime2">&nbsp;&nbsp;至:&nbsp;&nbsp;</label> <input
					class="Wdate" id="st2" type="text" name="_starttime2"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'st\')}'})"
					value="${starttime2 }" /> &nbsp;&nbsp;&nbsp;&nbsp; <label for="endtime">结束日期:</label> <input
					class="Wdate" id="et" type="text" name="_endtime"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'et2\')}'})" value="${endtime }" />
				<label for="endtime2">&nbsp;&nbsp;至:&nbsp;&nbsp;</label> <input class="Wdate" id="et2"
					type="text" name="_endtime2"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'et\')}'})" value="${endtime2 }" />
				&nbsp;&nbsp; <input style="COLOR: #44606B; background-color: #FFFFFF" type="submit" value="搜索">&nbsp;&nbsp;
				<input style="COLOR: #44606B; background-color: #FFFFFF" type="button" value="清空"
					onclick="clearForm(this.form)"> 
					<input type="hidden" name="ctrl" value="list" /> 
					<%-- <input type="hidden" name="from" value="${from }" /> --%>
			</form>
			<br />
		</div>
		<div style="height: auto; text-align: center; margin: 0 auto;">
			<table class="dtable" id="dtable" align="center" cellpadding="1" cellspacing="1">
				<tr>
					<th width="9%" align="center">日期</th>
					<th width="10%" align="center">会议名称</th>
					<th width="8%" align="center">主持人</th>
					<th width="10%" align="center">
						<p align="center">公司领导</p>
					</th>
					<th width="10%" align="center">参加单位/人员</th>
					<th width="10%" align="center">有关说明</th>
					<!-- <th width="10%" align="center">预定会议室</th> -->
					<th width="10%" align="center">地点</th>
					<th width="5%" align="center">状态</th>
					<th width="8%" align="center">联系人</th>
					<th width="8%" align="center">电话</th>					
					<th width="8%" align="center">申请部门<br />日期
					</th>
				</tr>
				<c:forEach items="${meetings }" var="mp">
					<tr>
						<td  align="center"><fmt:formatDate value="${mp.starttime }" pattern="E" /><br />
							<fmt:formatDate value="${mp.starttime }" pattern="yyyy-MM-dd HH:mm" /><br /> <fmt:formatDate
								value="${mp.endtime }" pattern="yyyy-MM-dd HH:mm" /></td>
						<td align="center">${mp.content }</td>
						<td  align="center">${mp.presider }</td>
						<td  align="center">
							<p align="center">${mp.leader }</p>
						</td>
						<td align="center">${mp.depart }<br />${mp.fdepart
							}
						</td>
						<td align="center">${mp.remark }</td>
						<%-- <td width="10%" align="center"><c:if
								test="${empty mp.schedule_roomid  }">
							</c:if> <c:if test="${!empty mp.schedule_roomid  }">${mp.building2 }${mp.room2 }(${mp.capacity2 }人)</c:if>
						</td> --%>
						<td align="center"><c:if test="${mp.type =='3' }">${mp.address }</c:if> <c:if
								test="${mp.type !='3' }">${mp.address1 }</c:if></td>
						<td align="center"><c:if test="${mp.status =='0' }">
								<font color="">未处理</font>
							</c:if> <c:if test="${mp.status =='1' }">
								<font color="green">已审批</font>
							</c:if> <c:if test="${mp.status =='2' }">
								<font color="red">拒批</font>
							</c:if> <c:if test="${mp.status =='3' }">
								<font color="">已安排</font>
							</c:if> <c:if test="${mp.status =='4' }">
								<font color="">退回</font>
							</c:if></td>
							
						<td align="center">${mp.contact }<br /> </td>
						<td align="center">${mp.contactphone }<br /> </td>
						<td align="center">${mp.commitdepart }<br /> <fmt:formatDate
								value="${mp.committime }" pattern="yyyy-MM-dd HH:mm" /></td>
						<%-- <td width="3%" align="center"><a
							<c:if test="${from =='mt' }">href="javascript:update('MeetingTrainingServlet?ctrl=toUpdate&show=all&id=${mp.id }')"</c:if>
							<c:if test="${from =='m' }">href="javascript:update('MeetingServlet?ctrl=toUpdate&show=all&id=${mp.id }')"</c:if>>修改</a>
							<a href="javascript:confirmDelete('MeetingServlet?ctrl=del&id=${mp.id }')">删除</a></td> --%>
					</tr>
				</c:forEach>
				<tr id="dd">
					<input type="hidden" value="${pageNo }" id="page"/>
					<td colspan="12"><div id="add"  onclick="on()">点击显示更多</div></td>
				</tr>
			</table>
		</div>
		<br class="clear"/>
		<br class="clear"/>
	</div>
	<br class="clear"/>
	<jsp:include page="/index/bottom.jsp" />
</body>