<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
			String basePath = request.getScheme() + "://"
					+ request.getServerName() + ":" + request.getServerPort()
					+ path + "/";
%>
<!DOCTYPE html>
<html>
<head>
<link href="<%=basePath%>style/new.css" Rel="stylesheet" Type="text/css">
<meta Http-equiv="Content-type" content="text/html; Charset=UTF-8">
<link rel="stylesheet"
	href="<%=basePath%>style/jquery-ui/base/jquery.ui.all.css">
<script src="<%=basePath%>script/jquery-1.9.1.min.js"></script>
<script src="<%=basePath%>script/ui/jquery.ui.core.js"></script>
<script src="<%=basePath%>script/ui/jquery.ui.widget.js"></script>
<script src="<%=basePath%>script/ui/jquery.ui.accordion.js"></script>
<style type="">
body {
	font-size: 9pt;
	text-align: left;
}

.accordionContent {
	font-size: 11px;
}
</style>
<script type="text/javascript">
	$(function() {
		$(".accordion").accordion({
			collapsible : true,
			heightStyle : "accordionContent"
		});
		$(".accordion1").accordion({
			collapsible : true,
			heightStyle : "accordionContent"
		});
	});
</script>
<title>Insert title here</title>
</head>
<body style="overflow: scroll;overflow-x:hidden;">
	<div style="width:98%;">
		<h3>&nbsp;&nbsp;会议信息</h3>
		<div class="accordion ui-accordion ui-widget ui-helper-reset"
			style="width:98%;" role="tablist">
			<h3 id="ui-accordion-1-header-0"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-accordion-header-active ui-state-active ui-corner-top"
				role="tab" aria-controls="ui-accordion-1-panel-0"
				aria-selected="true" tabindex="0">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-s"></span>
				部门会议申请
			</h3>
			<ul id="ui-accordion-1-panel-0"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active"
				style="list-style: none outside none; display: block;"
				aria-labelledby="ui-accordion-1-header-0" role="tabpanel"
				aria-expanded="true" aria-hidden="false">
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=toAdd"> 会议申请 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=listByDept"> 会议维护 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingPlanServlet?ctrl=toAdd"> 计划会议申请 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingPlanServlet?ctrl=listDepart"> 计划会议维护
				</a></li>
			</ul>
			<h3>
				<a href="<%=basePath%>MeetingServlet?ctrl=approve"> 会议审批 </a>
			</h3>
			<h3 id="ui-accordion-1-header-2"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" aria-controls="ui-accordion-1-panel-2"
				aria-selected="false" tabindex="0">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				会议室分配
			</h3>
			<ul id="ui-accordion-1-panel-2"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-1-header-2" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=toAllot"> … </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=toReAllot"> … </a></li>
			</ul>
			<h3 id="ui-accordion-1-header-3"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" aria-controls="ui-accordion-1-panel-3"
				aria-selected="false" tabindex="0">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				会议浏览修改
			</h3>
			<ul id="ui-accordion-1-panel-3"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-1-header-3" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=1&type=2">
						最新会议 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=2&type=2">
						历史会议 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=3&type=1">
						最新例会 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=4&type=1">
						历史例会 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=5&type=3">
						最新外部会议 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=6&type=3">
						历史外部会议 </a></li>
			</ul>
			<h3 id="ui-accordion-1-header-4"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all ui-accordion-icons"
				role="tab" aria-controls="ui-accordion-1-panel-4"
				aria-selected="false" tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				会议室维护
			</h3>
			<ul id="ui-accordion-1-panel-4"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-1-header-4" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingRoomServlet?ctrl=toAdd"> 会议室添加 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingRoomServlet?ctrl=list&from=mr"> 会议室维护
				</a></li>
			</ul>
			<h3 id="ui-accordion-1-header-5"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all ui-accordion-icons"
				role="tab" aria-controls="ui-accordion-1-panel-5"
				aria-selected="false" tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				会议查询
			</h3>
			<ul id="ui-accordion-1-panel-5"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-1-header-5" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=list"> 会议查询 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingServlet?ctrl=toMeetingRoomQry"> 会议室查询
				</a></li>
			</ul>
			<h3 id="ui-accordion-1-header-6"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all ui-accordion-icons"
				role="tab" aria-controls="ui-accordion-1-panel-6"
				aria-selected="false" tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				会议报表查询
			</h3>
			<ul id="ui-accordion-1-panel-6"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-1-header-6" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>StatisticsServlet?ctrl=statistics"> 处室情况统计表
				</a></li>
				<li><a target="main"
					href="<%=basePath%>StatisticsServlet?ctrl=statistics2">
						会议室情况统计表 </a></li>
				<li><a target="main"
					href="<%=basePath%>StatisticsServlet?ctrl=count"> 会议召开次数统计表 </a></li>
				<li><a target="main"
					href="<%=basePath%>StatisticsServlet?ctrl=meetingAndMeetingPlan">
						会议计划及会议执行情况 </a></li>
				<li><a target="main" href="<%=basePath%>export?ctrl=toExport">
						会议计划及会议执行情况导出 </a></li>
			</ul>
			<h3 id="ui-accordion-1-header-7"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all ui-accordion-icons"
				role="tab" aria-controls="ui-accordion-1-panel-7"
				aria-selected="false" tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				会议经费
			</h3>
			<ul id="ui-accordion-1-panel-7"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-1-header-7" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingMoneyServlet?ctrl=toAdd"> 会议经费预算录入 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingMoneyServlet?ctrl=list"> 会议经费预算一览 </a></li>
			</ul>
		</div>
		<h3>&nbsp;&nbsp;培训信息</h3>
		<div class="accordion ui-accordion ui-widget ui-helper-reset"
			style="width:98%;" role="tablist">
			<h3 id="ui-accordion-2-header-0"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" aria-controls="ui-accordion-2-panel-0"
				aria-selected="false" tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				培训通知
			</h3>
			<ul id="ui-accordion-2-panel-0"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-2-header-0" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingTrainingServlet?ctrl=toAdd"> 培训通知申请 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingTrainingServlet?ctrl=listByDepart">
						培训通知维护 </a></li>
			</ul>
			<h3 id="ui-accordion-2-header-1"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" aria-controls="ui-accordion-2-panel-1"
				aria-selected="false" tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				培训审批
			</h3>
			<ul id="ui-accordion-2-panel-1"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-2-header-1" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingTrainingServlet?ctrl=approve"> 培训审批 </a></li>
			</ul>
			<h3 id="ui-accordion-2-header-2"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-accordion-header-active ui-state-active ui-corner-top"
				role="tab" aria-controls="ui-accordion-2-panel-2"
				aria-selected="true" tabindex="0">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-s"></span>
				培训教室分配
			</h3>
			<ul id="ui-accordion-2-panel-2"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active"
				style="list-style: none outside none; display: block;"
				aria-labelledby="ui-accordion-2-header-2" role="tabpanel"
				aria-expanded="true" aria-hidden="false">
				<li><a target="main"
					href="<%=basePath%>MeetingTrainingServlet?ctrl=toReAllot">
						培训教室调配 </a></li>
			</ul>
			<h3 id="ui-accordion-2-header-3"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" aria-controls="ui-accordion-2-panel-3"
				aria-selected="false" tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				培训通知查询
			</h3>
			<ul id="ui-accordion-2-panel-3"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-2-header-3" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingTrainingServlet?ctrl=toQuery"> 培训通知查询
				</a></li>
			</ul>
			<h3 id="ui-accordion-2-header-4"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all"
				role="tab" aria-controls="ui-accordion-2-panel-4"
				aria-selected="false" tabindex="-1">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-e"></span>
				培训教室维护
			</h3>
			<ul id="ui-accordion-2-panel-4"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom"
				style="list-style: none outside none; display: none;"
				aria-labelledby="ui-accordion-2-header-4" role="tabpanel"
				aria-expanded="false" aria-hidden="true">
				<li><a target="main"
					href="<%=basePath%>MeetingRoomServlet?ctrl=toAddClassRoom">
						培训教室添加 </a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingRoomServlet?ctrl=listClassRoom&from=cr">
						培训教室维护 </a></li>
			</ul>
		</div>
		<h3>&nbsp;&nbsp;基础信息设置</h3>
		<div class="accordion ui-accordion ui-widget ui-helper-reset"
			style="width:98%;" role="tablist">
			<h3 id="ui-accordion-3-header-0"
				class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-header-active ui-state-active ui-corner-top ui-accordion-icons"
				role="tab" aria-controls="ui-accordion-3-panel-0"
				aria-selected="true" tabindex="0">
				<span class="ui-accordion-header-icon ui-icon ui-icon-triangle-1-s"></span>
				基础信息设置
			</h3>
			<ul id="ui-accordion-3-panel-0"
				class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active"
				style="list-style: none outside none; display: block;"
				aria-labelledby="ui-accordion-3-header-0" role="tabpanel"
				aria-expanded="true" aria-hidden="false">
				<li><a target="main"
					href="<%=basePath%>MeetingCommonServlet?ctrl=list"> 外来单位称谓 <br></br>
						固定单位称谓
				</a></li>
				<li><a target="main"
					href="<%=basePath%>MeetingExplainServlet?ctrl=list"> 有关说明项浏览 </a></li>
			</ul>
		</div>
	</div>
	<div
		class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all ui-accordion-icons"
		style="height: 27px;width: 97%;margin-top: 2px;text-align: center;">
		<a style="vertical-align: middle;" href="<%=basePath%>Logout"> <!-- <img src="images/quit.gif" alt="" border="0" height="20px;" /> -->
			<font size="4"><b> 退出 </b></font></a>
	</div>
	<h3 id="ui-accordion-1-header-0"
		class="ui-accordion-header ui-helper-reset ui-state-default ui-accordion-header-active ui-state-active ui-corner-top ui-accordion-icons"
		role="tab" aria-controls="ui-accordion-1-panel-0" aria-selected="true"
		tabindex="0">…</h3>
	<ul id="ui-accordion-1-panel-0"
		class="accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active"
		style="list-style: none outside none; display: block;"
		aria-labelledby="ui-accordion-1-header-0" role="tabpanel"
		aria-expanded="true" aria-hidden="false">
		<li>…</li>
		<li>…</li>
		<li><a target="main"
			href="http://localhost:8080/meeting/MeetingPlanServlet?ctrl=toAdd">
				… </a></li>
		<li><a target="main"
			href="http://localhost:8080/meeting/MeetingPlanServlet?ctrl=listDepart">
				… </a></li>
	</ul>
	<h3 id="ui-accordion-1-header-1"
		class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all ui-accordion-icons"
		role="tab" aria-controls="ui-accordion-1-panel-1"
		aria-selected="false" tabindex="-1">…</h3>
</body>
</html>