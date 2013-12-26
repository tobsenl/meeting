<%@page contentType="text/html; charset=UTF-8"%>
<%@include file="../include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>会议通知管理系统</title>
<meta Http-equiv="content-type" Content="text/html; Charset=UTF-8">
<link Href="<%=path%>/style/new.css" Rel="stylesheet" Type="text/css">
<link Href="<%=path%>/style/ul.css" Rel="stylesheet" Type="text/css">
<script type="text/javascript" src="<%=path%>/script/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="<%=path%>/script/easyui/easyloader.js"></script>
<script src="<%=basePath%>script/common.js"></script>
<script type="text/javascript">
easyloader.locale = "zh_CN"; 
var url = window.location.href;
using(['dialog','form','validatebox'],function(){
	$(function(){
		$("#roomId").change(function() {
			if($(this).val() != ''){
				var url = "<%=path%>/MeetingRoomServlet?ctrl=roomDetail&roomID="+$(this).val()+
				"&starttime="+$("#starttime").val()+"&endtime="+$("#endtime").val();
				$.ajax({
					url : url,
					type: "post",
					datatype:"json",
					success : function(data) {
						var d = $.parseJSON(data);
						$("#capacity").html("");
						$("#remark").html("");
						$("#capacity").html("");
						$("#remark").html("");
						$("#isFree").val("");
						
						$("#capacity").html("&nbsp;");
						$("#remark").html("&nbsp;");
						$("#capacity").html(d.capacity);
						$("#remark").html(d.remark);
						if(d.isFree == '1'){
							$("#msg").html('<font color="red">不可用</font>');
							$("#isFree").val("false");
						}else if (d.isFree == '0'){
							$("#msg").html('<font color="green">可用</font>');
							$("#isFree").val("true"); 
						}
					}
				});
			}
		});
		$('#dlg').dialog({  
		    title: '会议室分配',  
		    closed: true,  
		    cache: false,  
		    modal: true,
		    buttons:[{
				text:'确定',
				handler:function(){

					var test=$("#msg").find("font").html();
					if(test != ""){
						if(test == "可用"){
							$("#rn").val($("#child option:selected").text());
							$('#form1').form('submit',{
								onSubmit: function(){
									var isValid = $(this).form('validate');
									if (isValid){
										$('#dlg').dialog('close');	
									}
									return isValid;	
								},
								success:function(data){  
									window.location.href = url;
							    }  
							});
						}else{
							alert("该教室不可用！请选用可用的教室！");
						}
					}
					
					
					
				}
			},{
				text:'关闭',
				handler:function(){
					$('#dlg').dialog('close');
				}
			}]  
		}); 
		$("a[id^=at_]").click(function(){
			var id = $(this).attr('id');
			$("#meetingID").val(id.substring(3,id.lastIndexOf('_')));
			$("#roomId").val(id.substring(id.lastIndexOf('_')+1));
			var childs = $(this).parent().parent().children("td");
			$("#mn").html(childs.eq(1).html());
			var val = childs.eq(0).text();
			var leaders = childs.eq(2).html();
			if(leaders != ''){
				$("#leaders").val(leaders);
				$("#l_t").show();
				$('#l_c').show();
			}
			$("#starttime").val($("#stime").val());
			$("#endtime").val($("#etime").val());
			$('#dlg').dialog('open');
		});
		$("a[id^=bk_]").click(function(){
			var url = 'MeetingTrainingServlet?ctrl=goBack&id='+$(this).attr('id').substr(3);
			window.location = url;
		});
	});
	$.extend($.fn.validatebox.defaults.rules, {  
	    equals: {  
	        validator: function(value,param){ 
	            return "true" == $(param[0]).val();  
	        },  
	        message: '教室不可用.'  
	    }  
	});
});

</script>

</head>
<body>
<div class="container" >
		<jsp:include page="/index/top.jsp"/>
			<div style="height:auto; text-align: center;margin: 0 auto;">
				<table class="dtable" align="center" cellpadding="1" cellspacing="1">
					<tr>
					<th width="10%" align="center">日期</th>
					<th width="10%" align="center">课程名称</th>
					<th width="5%" align="center">教员</th>
					<th width="15%" align="center">参加单位/人员</th>
					<th width="10%" align="center">有关说明</th>
					<th width="10%" align="center">预定教室</th>
					<th width="10%" align="center">分配教室</th>
					<th width="10%" align="center">状态</th>
					<th width="15%" align="center">申请部门<br />日期</th>
					<th width="5%" align="center">操作</th>
					</tr>
					<c:forEach items="${meetings }" var="mp">
						<tr>
							<td width="10%" align="center"><!-- ${mp.id } --><fmt:formatDate
								value="${mp.starttime }" pattern="E" /><br /> <fmt:formatDate
								value="${mp.starttime }" pattern="yyyy-MM-dd HH:mm" />
								<input type="hidden" id="stime" value='<fmt:formatDate
								value="${mp.starttime }" pattern="yyyy-MM-dd HH:mm" />'/>
								<input type="hidden" id="etime" value='<fmt:formatDate
								value="${mp.endtime }" pattern="yyyy-MM-dd HH:mm" />'/>
								<br />
							<fmt:formatDate value="${mp.endtime }"
								pattern="yyyy-MM-dd HH:mm" /></td>
						<td width="10%" align="center">${mp.content }</td>
						<td width="5%" align="center">${mp.presider }</td>
						<td width="15%" align="center">${mp.depart }</td>
						<td width="10%" align="center">${mp.remark }</td>
						<td width="10%" align="center">${mp.reserve_address }</td>
						<td width="10%" align="center">${mp.address1 }</td>
						<td width="10%" align="center"><c:if
								test="${mp.status =='0' }">
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
						<td width="15%" align="center">${mp.commitdepart }<br />
							<fmt:formatDate value="${mp.committime }"
								pattern="yyyy-MM-dd HH:mm" /></td>
							<TD  align="center">
								<a href="javascript:;" id="at_${mp.id }_${mp.roomid}">${btn }</a>
								<br/>
								<a href="MeetingTrainingServlet?ctrl=toUpdate&show=all&xv=1&id=${mp.id }">修改</a>
								<br/>
								<a href="javascript:confirmDelete('<%=basePath%>MeetingServlet?ctrl=del&id=${mp.id }')">删除</a>
								<br/>
								<a href="javascript:;" id="bk_${mp.id }">退回</a>
							</TD>
						</tr>
					</c:forEach>
				</table>
			</div>
	</div>
	<div id="dlg" style="text-align: center;vertical-align: middle;margin: 0 auto;width: 400px;height: 245px;overflow: hidden;">
		<form id="form1" action="MeetingServlet" method="post">
			<dl class="dl-table" style="width: 100%;">
				<dt style="width: 25%;">培训名称：</dt>
				<dd style="width: 75%;"><label id="mn"></label></dd>
				<dt style="width: 25%;">分配培训教室：</dt>
				<dd style="width: 75%;">
					<select id="roomId" name="roomId" class="easyui-validatebox" data-options="required:true">
						<option value="">请选择培训教室</option>
						<c:forEach items="${mrs }" var="mr">
							<option value="${mr.id }">${mr.building }${mr.room }</option>
						</c:forEach>
					</select>
					&nbsp;&nbsp;<span id="msg"></span>
				</dd>
				<dt style="width: 25%;">容纳人数：</dt>
				<dd style="width: 75%;"><label id="capacity">&nbsp;</label></dd>
				<dt style="width: 25%;">说明：</dt>
				<dd style="width: 75%;"><label id="remark">&nbsp;</label></dd>
				<dt id="l_t" style="display: none;width: 25%;">提醒：</dt>
				<dd id="l_c" style="display: none;width: 75%;">
					<select id="" name="isemail">
						<option value="true">是</option>
						<option value="false" selected="selected">否</option>
					</select>&nbsp;&nbsp;
					<em>是否给领导发送提醒</em>
				</dd>
			</dl>			
			<input type="hidden" name="ctrl" value="allotRoom">
			<input type="hidden" id="isFree" value="false">
			<input type="hidden" name="leaders" id="leaders" value="">
			<input type="hidden" name="building" id="bn" value="">
			<input type="hidden" name="roomname" id="rn" value="">
			<input type="hidden" name="leaders" id="leaders" value="">
			<input type="hidden" id="starttime" value="">
			<input type="hidden" id="endtime" value="">
			<input type="hidden" name="meetingID" id="meetingID" value="">
		</form>
	</div>
	<jsp:include page="/index/bottom.jsp"/>
</body>