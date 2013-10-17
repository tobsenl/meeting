<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html >  
<html >
<head>
<%
String path = request.getContextPath();%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>会议通知管理系统</title>
<script src="<%=path%>/script/jquery-1.9.1.min.js"></script>
<script>
var browser=navigator.appName
	var b_version=navigator.appVersion
	var version=b_version.split(";");
	var trim_Version=version[1].replace(/[ ]/g,"");
	if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE7.0")
	{
		var s='<frame src="index/left.jsp" name="left" id="left" scrolling="no">';
		s=s+'<frame src="index/main.jsp" name="main" id="main" scrolling="no">';
		//$("frameset").html(s);
		$("frameset").first().attr("scrolling","no");
		//alert();
	}
	else if(browser=="Microsoft Internet Explorer" && trim_Version=="MSIE6.0")
	{
	    alert("IE 6.0");
	}
</script>
</head>

<frameset rows="*" cols="13%,*" framespacing="0" frameborder="yes"
	border="0">
	<frame src="index/left.jsp" name="left" id="left" ></frame>
	<frame src="index/main.jsp" name="main" id="main" scrolling="no"></frame>
</frameset>
<noframes>
	<body>
	</body>
</noframes>
</html>
