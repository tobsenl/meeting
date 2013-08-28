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
</style>
<title>Insert title here</title>
<script type="text/javascript">
$(document).ready(function(){
	$("h3 span").attr("class","ui-accordion-header-icon ui-icon ui-icon-triangle-1-s");
	$("a").attr("target","main");
	//初始化列表块
	$("#accordion1,#accordion2,#accordion3").attr("class","accordion ui-accordion ui-widget ui-helper-reset");
	//初始化样式title
	$("#accordion1 h3,#accordion2 h3,#accordion3 h3").attr("class","ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all");
	//初始化样式是否存在下拉框标记
	$("#accordion3 h3 span,#accordion1 h3 span,#accordion2 h3 span").attr("class","ui-accordion-header-icon ui-icon ui-icon-triangle-1-e");
	//列表框样式
	$("#accordion1 ul,#accordion2 ul,#accordion3 ul").attr("class","accordionContent ui-accordion-content ui-helper-reset ui-widget-content ui-corner-bottom ui-accordion-content-active");
	//隐藏列表框
	$("#accordion1 ul,#accordion2 ul,#accordion3 ul").attr("style","list-style: none outside none; display: none;");
	//鼠标上移事件.
	$("#accordion1 h3,#accordion2 h3,#accordion3 h3").mouseover(function(e){
		var temp=$(this).attr("class");
		if(temp != "ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-accordion-header-active ui-state-active ui-corner-top"){
		$(this).attr("class","ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all ui-state-hover");
		}
	})
	//鼠标移开事件 如果已经点开.则不变.如果为点开修改
	$("#accordion1 h3,#accordion2 h3,#accordion3 h3").mouseout(function(e){
		var temp=$(this).attr("class");
		if(temp != "ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-accordion-header-active ui-state-active ui-corner-top"){
			$(this).attr("class","ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all");
		}
	})
	//title点击事件 修改title 下拉框标记 以及显示列表框
	$("#accordion1 h3,#accordion2 h3,#accordion3 h3").click(function(e){
		var temp=$(this).attr("class");
		//收起
		if(temp == "ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-accordion-header-active ui-state-active ui-corner-top"){
			if($(this).find("span").attr("class")){
			$(this).attr("class","ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all");
				$(this).find("span").attr("class","ui-accordion-header-icon ui-icon ui-icon-triangle-1-e");
				$(this).next().attr("style","list-style: none outside none; display: none;");
			}
		//显示
		}else{
			if($(this).find("span").attr("class")){
				_parent=$(this).parent("div");
				_parent.children("ul").attr("style","list-style: none outside none; display: none;");
				_parent.children("h3").find("span").attr("class","ui-accordion-header-icon ui-icon ui-icon-triangle-1-e");
				_parent.children("h3").attr("class","ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-corner-all");
				$(this).attr("class","ui-accordion-header ui-helper-reset ui-state-default ui-accordion-icons ui-accordion-header-active ui-state-active ui-corner-top");
				$(this).find("span").attr("class","ui-accordion-header-icon ui-icon ui-icon-triangle-1-s");
				$(this).next().removeAttr("style");
			}
		}
	})
	}
)
</script>
</head>
<body style="overflow: scroll;overflow-x:hidden;display: ">
	<div style="width:98%;">
		<h3>&nbsp;&nbsp;会议信息</h3>
		<div id="accordion1"
			style="width:98%;">
			<h3><span ></span>部门会议申请
			</h3>
			<ul style="list-style: none;">
				<li><a href="<%=basePath%>MeetingServlet?ctrl=toAdd"
					>会议申请</a></li>
				<li><a href="<%=basePath%>MeetingServlet?ctrl=listByDept"
					>会议维护</a></li>
				<li><a href="<%=basePath%>MeetingPlanServlet?ctrl=toAdd"
					>计划会议申请</a></li>
				<li><a href="<%=basePath%>MeetingPlanServlet?ctrl=listDepart"
					>计划会议维护</a></li>
			</ul>
			<h3 >
				<a href="<%=basePath%>MeetingServlet?ctrl=approve" >会议审批</a>
			</h3>
			<h3><span ></span>会议室分配</h3>
			<ul style="list-style: none;" >
				<li><a href="<%=basePath%>MeetingServlet?ctrl=toAllot"
					>会议室分配</a></li>
				<li><a href="<%=basePath%>MeetingServlet?ctrl=toReAllot"
					>会议室调配</a></li>
			</ul>
			<h3><span ></span>会议浏览修改</h3>
			<ul style="list-style: none;" >
				<li><a
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=1&type=2"
					>最新会议</a></li>
				<li><a
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=2&type=2"
					>历史会议</a></li>
				<li><a
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=3&type=1"
					>最新例会</a></li>
				<li><a
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=4&type=1"
					>历史例会</a></li>
				<li><a
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=5&type=3"
					>最新外部会议</a></li>
				<li><a
					href="<%=basePath%>MeetingServlet?ctrl=listMeeting&title=6&type=3"
					>历史外部会议</a></li>
			</ul>
			<h3><span ></span>会议室维护</h3>
			<ul style="list-style: none;" >
				<li><a href="<%=basePath%>MeetingRoomServlet?ctrl=toAdd"
					>会议室添加</a></li>
				<li><a href="<%=basePath%>MeetingRoomServlet?ctrl=list&from=mr"
					>会议室维护</a></li>
			</ul>
			<h3><span ></span>会议查询</h3>
			<ul style="list-style: none;" >
				<li><a href="<%=basePath%>MeetingServlet?ctrl=list"
					>会议查询</a></li>
				<li><a href="<%=basePath%>MeetingServlet?ctrl=toMeetingRoomQry"
					>会议室查询</a></li>
			</ul>
			<h3><span ></span>会议报表查询</h3>
			<ul style="list-style: none;" >
				<li><a href="<%=basePath%>StatisticsServlet?ctrl=statistics"
					>处室情况统计表</a></li>
				<li><a href="<%=basePath%>StatisticsServlet?ctrl=statistics2"
					>会议室情况统计表</a></li>
				<li><a href="<%=basePath%>StatisticsServlet?ctrl=count"
					>会议召开次数统计表</a></li>
				<li><a
					href="<%=basePath%>StatisticsServlet?ctrl=meetingAndMeetingPlan"
					>会议计划及会议执行情况</a></li>
				<li><a href="<%=basePath%>export?ctrl=toExport" >会议计划及会议执行情况导出</a></li>
			</ul>
			<h3><span ></span>会议经费</h3>
			<ul style="list-style: none;" >
				<li><a href="<%=basePath%>MeetingMoneyServlet?ctrl=toAdd"
					>会议经费预算录入</a></li>
				<li><a href="<%=basePath%>MeetingMoneyServlet?ctrl=list"
					>会议经费预算一览</a></li>
			</ul>
		</div>
		<h3>&nbsp;&nbsp;培训信息</h3>
		<div id="accordion2" style="width:98%;">
			<h3><span ></span>培训通知</h3>
			<ul style="list-style: none;" >
				<li><a href="<%=basePath%>MeetingTrainingServlet?ctrl=toAdd"
					>培训通知申请</a></li>
				<li><a
					href="<%=basePath%>MeetingTrainingServlet?ctrl=listByDepart"
					>培训通知维护</a></li>
			</ul>
			<h3>
				<a href="<%=basePath%>MeetingTrainingServlet?ctrl=approve"
					>培训审批</a>
			</h3>
			<h3>
				<a href="<%=basePath%>MeetingTrainingServlet?ctrl=toReAllot"
					>培训教室调配</a>
			</h3>
			<h3>
				<a href="<%=basePath%>MeetingTrainingServlet?ctrl=toQuery"
					>培训通知查询</a>
			</h3>
			<h3><span ></span>培训教室维护</h3>
			<ul style="list-style: none;" >
				<li><a
					href="<%=basePath%>MeetingRoomServlet?ctrl=toAddClassRoom"
					>培训教室添加</a></li>
				<li><a
					href="<%=basePath%>MeetingRoomServlet?ctrl=listClassRoom&from=cr"
					>培训教室维护</a></li>
			</ul>
			<!--<h3><span ></span>培训通知查询</h3>
			<ul style="list-style: none;" >
				<li><a href="<%=basePath%>MeetingServlet?ctrl=list&from=mt" >培训通知查询</a></li>
			</ul>
			 -->
		</div>
		<h3>&nbsp;&nbsp;基础信息设置</h3>
		<div id="accordion3" style="width:98%;">
			<h3><span ></span>基础信息设置</h3>
			<ul style="list-style: none;" >
				<li><a href="<%=basePath%>MeetingCommonServlet?ctrl=list"
					>外来单位称谓<br />固定单位称谓
				</a></li>
				<li><a href="<%=basePath%>MeetingExplainServlet?ctrl=list"
					>有关说明项浏览</a></li>
			</ul>
		</div>
	</div>
	<div
		style="height: 27px;width: 97%;margin-top: 2px;text-align: center;"
		class="ui-accordion-header ui-helper-reset ui-state-default ui-corner-all ui-accordion-icons">
		<a href="<%=basePath%>Logout" style="vertical-align: middle;"> <!-- <img src="images/quit.gif" alt="" border="0" height="20px;" /> -->
			<font size="4"><b>退出</b></font>
		</a>
	</div>
</body>
</html>