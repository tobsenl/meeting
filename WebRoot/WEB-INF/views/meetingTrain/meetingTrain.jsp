﻿<%@page contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@include file="../include.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">  
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<title>会议通知管理系统</title>
<meta http-equiv="content-type" content="text/html; Charset=UTF-8">
<link href="<%=path%>/style/new.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/style/ul.css" rel="stylesheet" type="text/css">
<link href="<%=path%>/style/jquery-ui/base/jquery.ui.all.css"
	rel="stylesheet">
<script src="<%=path%>/script/My97DatePicker/WdatePicker.js"></script>
<script src="<%=path%>/script/jquery-1.9.1.min.js"></script>
<script type="text/javascript"
	src="<%=path%>/script/easyui/easyloader.js"></script>
<script src="<%=path%>/script/form2Json.js"></script>
<script src="<%=path%>/script/ui/jquery.ui.core.js"></script>
<script src="<%=path%>/script/ui/jquery.ui.widget.js"></script>
<script src="<%=path%>/script/ui/jquery.ui.button.js"></script>
<script src="<%=path%>/script/ui/jquery.ui.position.js"></script>
<script src="<%=path%>/script/ui/jquery.ui.menu.js"></script>
<script src="<%=path%>/script/ui/jquery.ui.autocomplete.js"></script>
<style>
.ui-autocomplete {
	max-height: 100px;
	overflow-y: auto;
	overflow-x: hidden;
}

* html .ui-autocomplete {
	height: 100px;
}
</style>

<script type="text/javascript">
easyloader.locale = "zh_CN"; 
using(['form','validatebox'],function(){
	$(function() {
		
		$("#presider").autocomplete({
			minLength : 1,
			delay : 300,
			source : function(request, response) {
				var url = "ajax?ctrl=ens&presider="+ encodeURI(encodeURI($("#presider").val()));
				$.ajax({
					url : url,
					type : "post",
					dataType : "json",
					success : function(data,
							textStatus, jqXHR) {
						response($.map(data, function(
								item, index) {
							return {
								name : item.name,
								org : item.org 
							};
						}));
					}
				});
			},
			focus : function(event, ui) {
				$("#presider").val(ui.item.name/*  + '(' + ui.item.org + ')' */);
				return false;
			},
			select : function(event, ui) {
				$("#presider").val(ui.item.name);
				return false;
			},
			close : function(event, ui) {
				var url = "ajax?ctrl=checkP&presider="+ encodeURI(encodeURI($("#presider").val())) + "&starttime="
						+ $("#st").val() + "&endtime="+ $("#et").val() + "&id="+ $("#id").val();
				$.getJSON(url, function(data) {
					if (data == 1) {
						alert("主持人在该时间段已有会议!");
					}
				});
			}}).data("ui-autocomplete")._renderItem = function(ul,item) {
				return $("<li>").append("<a>" + item.name + " <font size='1.5'color='#3C3C3C'>"+ item.org + "</font></a>").appendTo(ul);
		};
		
		
		function split(val) {
			return val.split(/,\s*/);
		}
		function extractLast(term) {
			return split(term).pop();
		}
		$("#depart").bind("keydown",function(event) {
			if (event.keyCode === $.ui.keyCode.TAB && $(this).data("ui-autocomplete").menu.active) {
				event.preventDefault();
			}
		}).autocomplete({
			source : function(request, response) {
				$.getJSON("ajax?ctrl=pu&unit="+ encodeURI(encodeURI(extractLast($("#depart").val()))), response);
			},
			search : function() {
				var term = extractLast(this.value);
				if (term.length < 2) {
					return false;
				}
			},
			focus : function() {
				return false;
			},
			select : function(event, ui) {
				var terms = split(this.value);
				terms.pop();
				terms.push(ui.item.value);
				terms.push("");
				this.value = terms.join(",");
				return false;
			}
		}); 
			$("#sub").click(function(){
				var remark = "";
				remark += $("#remark").val();
				$("input[id^=me_c_]:checked").each(function() {
					remark += $(this).val() + ",";
				});
				$("select[id^=me_s_]").each(function() {
					var val = $(this).val();
					if (val.length > 0) {
						remark += $(this).val() + ",";
					}
				});
				$("input[id^=me_t_]").each(
					function() {
						var id = $(this).attr("id");
						var val = $(this).val();
						if (val.length > 0) {
							var n = id.substr(5);
							remark += $("#n_me_t_" + n).val() + " " + val
									+ $("#u_me_t_" + n).val() + ",";
						}
				});
				$("#remark").val(remark);
				var is_commit=true;
				var roomid =$("#reserve_roomid").val();
				if (roomid != "" && roomid != null && roomid != undefined){
					var src_id= $("#id").val() == null ? "" : $("#id").val() ;
					var src_url="checkroomid&room_id="+roomid+ "&starttime=" + $("#st").val() + "&endtime=" + $("#et").val()+"&id="+src_id ;
					var url="ajax?ctrl="+src_url;
					$.ajaxSettings.async = false;//确保同步.此处不需要异步
					$.get(url, function(data,x,b) {
						//使方法同步
						data=eval(data);
						//alert(data[0].error);
							if (data[0].error == "") {
								is_commit = true;
							}
							else{
								is_commit = false;
									alert(data[0].error);
							}
						});
					if(is_commit){
						$("#form1").attr('action','<%=path%>/MeetingTrainingServlet?json='+form2json("form"));
						$('#form1').form('submit',{
							success:function(data){
								 window.location.href = '<%=path%>/MeetingTrainingServlet?ctrl=listByDepart';
				       		}  
						});
					}
				}
				
				//$("#sub").attr("disabled", true);
				//$("#form1").attr('action','<%=path%>/MeetingTrainingServlet?json='+form2json("form"));
				//$('#form1').form('submit',{ 
				//	success:function(data){  
				//		 window.location.href = '<%=path%>/MeetingTrainingServlet?ctrl=listByDepart';
		       	//	}  
				//});
			});
		
		$("input:radio[name='flow']").click(function(){
			var val = $(this).val(); 
		 	if(val == 1){
		 		$("#tr").hide();
		 		$("#mr").show();
		 	}else if(val == 2){
		 		$("#tr").show();
		 		$("#mr").hide();
		 	}
		});
		$( document).on("click","#tt",function(){
			$(this).tooltip({
				 content: $('<div></div>'),
		            showEvent: 'click',
		            position: 'top',
		            onShow: function(){  
		                $(this).tooltip('arrow').css('left', 20);  
		                $(this).tooltip('tip').css('left', $(this).offset().left);  
		            },  
		            onUpdate: function(cc){
		                cc.panel({  
		                    width: 500,  
		                    height: 'auto',  
		                    border: false,  
		                    href: 'MeetingServlet?ctrl=roomDetail&starttime='+$('#st').val()+
		                    		'&endtime='+$('#et').val()+'&roomid='+$('#child2').val()
		                });
		          }
			});
		});
		/*$( document).on("click","#zz",function(){
			$(this).tooltip({
				 content: $('<div></div>'),
		            showEvent: 'click',
		            position: 'top',
		            onShow: function(){  
		                $(this).tooltip('arrow').css('left', 20);  
		                $(this).tooltip('tip').css('left', $(this).offset().left);  
		            },  
		            onUpdate: function(cc){
		                cc.panel({  
		                    width: 500,  
		                    height: 'auto',  
		                    border: false,  
		                    href: 'MeetingServlet?ctrl=roomDetail&starttime='+$('#st').val()+
		                    		'&endtime='+$('#et').val()+'&roomid='+$('#child').val()
		                });
		          }
			});
		});*/
	});
	if($("#org")){
		if('${meeting.org}' != ""){
			var temp=$("#org").find("option:contains('${meeting.org}')");
			//alert(temp);
			//console.log(temp);
			//console.log(temp[0]);
			//console.log($(temp[0]).attr("checked"));
			if(temp){
				$(temp[0]).attr("selected","selected");
				$("[name='org']").val('${meeting.org}');
			}else{
				temp=$("#org").find("option[value='${meeting.org}']");
				if(temp){
					$(temp[0]).attr("selected","selected");
					$("[name='org']").val('${meeting.org}');
				}
			}
		}
		$("#org").attr('disabled','disabled');
	};
});
function setV(va){
	v=document.getElementById(va);
	document.getElementById("reserve_roomid").value=v.options[v.selectedIndex].value;
}
</script>
</head>
<body>
	<div class="container">
		<jsp:include page="/index/top.jsp" />
		<form id="form1" name="timeForm" method="post">
			<div
				style="width: 950px; height: auto; text-align: center; margin: 0 auto;">
				<dl class="dl-table">
					<dt><em>*</em> 时间：</dt>
					<dd>
						<input class="Wdate easyui-validatebox" id="st" type="text"
							style="width: 200px" name="starttime"
							data-options="prompt:'开始时间',required:true"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d %H:%m',maxDate:'#F{$dp.$D(\'et\',{m:-30})}'})"
							value="<fmt:formatDate value="${meeting.starttime }" pattern="yyyy-MM-dd HH:mm"/>" />
						&nbsp;&nbsp; <font style="font-weight: bold;">至</font>&nbsp;&nbsp;
						<input class="Wdate easyui-validatebox" id="et" type="text"
							style="width: 200px" name="endtime"
							data-options="prompt:'结束时间',required:true"
							onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'st\')||\'%y-%M-%d %H:%m\'}'})"
							value="<fmt:formatDate value="${meeting.endtime }" pattern="yyyy-MM-dd HH:mm"/>" />
					</dd>
					<dt><em>*</em> 教员名称：</dt>
					<dd>
						<input class="input" type="text" id="presider" name="presider" class="easyui-validatebox" data-options="prompt:'',required:true"
							size="35" value="${meeting.presider }">
					</dd>
					<dt><em>*</em> 培训课程名称：</dt>
					<dd>
						<textarea rows="3" name="content" style="width: 550px;"
							class="easyui-validatebox" data-options="prompt:'',required:true">${meeting.content }</textarea>
					</dd>
					<dt>培训课程描述(选填)：</dt>
					<dd>
						<textarea rows="3" name="detail" style="width: 550px;"
							class="easyui-validatebox" data-options="prompt:''">${meeting.detail }</textarea>
					</dd>
					<dt>组织处室：</dt>
					<dd>
						<select id="org" name="org" class="easyui-combobox"
							style="width: 260px;">
							<option value="">请选择组织处室</option>
							<c:forEach items="${orgs }" var="org">
							<c:choose>
									<c:when test="${fn:trim(meeting['org']) != ''}">
										<option value="${org[1] }" >${org[1] }</option>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${org[0] != u_org }">
												<option value="${org[1] }" >${org[1] }</option>
											</c:when>
											<c:otherwise>
												<option value="${org[1] }" selected="selected">${org[1] }</option>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
							</c:choose>
							</c:forEach>
						</select>
					</dd>
					<dt>培训项目负责人：</dt>
					<dd>
						<input class="input" id="contact" name="contact" size="35"
							type="text" value="${empty meeting.contact ? '':meeting.contact}" />
					</dd>
					<dt>联系电话：</dt>
					<dd>
						<input class="input" id="contactphone" name="contactphone"
							size="35" type="text"
							value="${empty meeting.contactphone ? '':meeting.contactphone}" />
					</dd>
					<dt><em>*</em> 会议室/教室：</dt>
					<dd>
						<div id="_radio">
							<input type="radio" name="flow" value="1"
								<c:if test="${meeting.flow == '1' }">checked="checked"</c:if> />会议室
							&nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" name="flow"
								value="2"
								<c:if test="${ empty meeting.flow || meeting.flow == '2' }">checked="checked"</c:if> />培训教室
						</div>
						<div id="mr"
							<c:if test="${ empty meeting.flow || meeting.flow == '2' }">style="display: none;"</c:if>>
							<select id="child" onchange="setV('child')">
								<option value="">请选择会议室</option>
								<c:forEach items="${mrs }" var="mr">
									<option value="${mr.id }"
										<c:if test="${mr.id == meeting.roomid || mr.id == meeting.reserve_roomid}">selected="selected"</c:if>>${mr.building
										}${mr.room }</option>
								</c:forEach>
							</select> <!-- <a href="javascript:void(0);" id="zz">点击显示详细</a> -->
						</div>
						<div id="tr"
							<c:if test="${meeting.flow == '1' }">style="display: none;"</c:if>>
							<select id="child2" onchange="setV('child2')">
								<option value="">请选择培训教室</option>
								<c:forEach items="${mrs2 }" var="mr">
									<option value="${mr.id }"
										<c:if test="${mr.id == meeting.roomid || mr.id == meeting.reserve_roomid }">selected="selected"</c:if>>${mr.building
										}${mr.room }</option>
								</c:forEach>
							</select> <a href="javascript:void(0);" id="tt">点击显示详细</a>
						</div>
					</dd>
					<dt><em>*</em> 参加单位/人员：</dt>
					<dd>
						<textarea rows="3" id="depart" name="depart" style="width: 550px" class="easyui-validatebox" data-options="prompt:'',required:true">${empty meeting.depart ?'' : meeting.depart }</textarea>
					</dd>
					<dt>有关说明：</dt>
					<dd>
						<div>
							<%-- <c:forEach var="me" items="${mes }" varStatus="i">
								<c:if test="${me.style == '1' }">
									${me.name }&nbsp;<input id="me_c_${i.count }" type="checkbox"
										value="${me.name }" />&nbsp;
								</c:if>
								<c:if test="${me.style == '2' }">
									${me.name }<input id="n_me_t_${i.count }" type="hidden"
										value="${me.name }" />
									&nbsp;<input id="me_t_${i.count }" type="text" value=""
										size="1" />
									<input id="u_me_t_${i.count }" type="hidden"
										value="${me.unit }" />&nbsp;${me.unit }
								</c:if>
								<c:if test="${me.style == '3' }">
									<select id="me_s_${i.count }">
										<option value="">--${me.name }--</option>
										<c:forEach var="child" items="${me.child }">
											<option value="${child.name }">${child.name }</option>
										</c:forEach>
									</select>
								</c:if>
								<c:if test="${i.count == 10 }">
									<br />
								</c:if>
							</c:forEach>
						</div> --%>
						<div style="margin-top: 3px;">
							<textarea rows="3" id="remark" name="remark" style="width: 550px">${meeting.remark }</textarea>
						</div>
						<div style="clear: both;"></div>
					</dd>
					<dt></dt>
					<dd style="text-indent: 100px;">
					<c:if test="${xv != 0 }">
						<c:if test="${xv != 1 }">
							<c:choose>
							<c:when test="${meeting.status != '1' && meeting.status != '3' }">
							<input id="sub" type="button" value="提交">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
							type="reset" value="重置"> <input type="hidden" name="ctrl"
							value="${ctrl }"> <input type="hidden" id="id" name="id"
							value="${meeting.id }"> <input type="hidden" name="type"
							value="4"> <input type="hidden" name="reserve_roomid"
							id="reserve_roomid" value="${meeting.reserve_roomid}"> <input type="hidden" name="url"
							value="${url }"> <input type="hidden" name="show"
							value="${show }"> <input type="hidden" name="status"
							value="0">
							</c:when>
							<c:otherwise>
							<input id="sub" type="button" value="返回" onclick="javascript :history.back(-1);">
							</c:otherwise>
							</c:choose>
						</c:if>
						<c:if test="${xv == 1 }">
							<input id="sub" type="button" value="提交">
						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
							type="reset" value="重置"> <input type="hidden" name="ctrl"
							value="${ctrl }"> <input type="hidden" id="id" name="id"
							value="${meeting.id }"> <input type="hidden" name="type"
							value="4"> <input type="hidden" name="reserve_roomid"
							id="reserve_roomid" value="${meeting.reserve_roomid}"> <input type="hidden" name="url"
							value="${url }"> <input type="hidden" name="show"
							value="${show }"> <input type="hidden" name="status"
							value="0">
						</c:if>
					</c:if>
					<c:if test="${xv == 0 }">
						<input id="sub" type="button" value="返回" onclick="javascript :history.back(-1);">
					</c:if>
					</dd>
				</dl>
				<br style="clear: both;" />
			</div>
			<br style="clear: both;" />
		</form>
	</div>
	<jsp:include page="/index/bottom.jsp" />
</body>
</html>