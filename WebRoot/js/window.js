var infoTitle;
var infoDetails;
var bgObj;
var msgObj;
var showMsgObj;
function alertWin(title,noticeInfo, w, h)
{ 
	document.body.removeChild(showMsgObj); 
	
	infoTitle = title;
	infoDetails = document.getElementById(noticeInfo).innerHTML;
	
    var titleheight = "22px"
    var bordercolor = "#666699"; // 提示窗口的边框颜色 
    var titlecolor = "#FFFFFF"; // 提示窗口的标题颜色 
    var titlebgcolor = "#666699"; // 提示窗口的标题背景色
    var bgcolor = "#FFFFFF"; // 提示内容的背景色
    
    //var iWidth = document.documentElement.clientWidth; 
    //var iHeight = document.documentElement.clientHeight; 
    var iWidth;
	var iHeight;
	//获取窗口宽度
	if (window.innerWidth)
	{
		iWidth = window.innerWidth;
	}
	else if ((document.body) && (document.body.clientWidth))
	{
		iWidth = document.body.clientWidth;
	}
	//获取窗口高度
	if (window.innerHeight)
	{
		iHeight = window.innerHeight;
	}
	else if ((document.body) && (document.body.clientHeight))
	{
		iHeight = document.body.clientHeight;
	}
	//通过深入Document内部对body进行检测，获取窗口大小
	if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth)
	{
		iHeight = document.documentElement.clientHeight;
		iWidth = document.documentElement.clientWidth;
	}
	if(iHeight == 0)
	{
		iHeight = 600;
	}
	if(iWidth == 0)
	{
		iWidth = 1000;
	}

    bgObj = document.createElement("div"); 
    bgObj.id="bgObjId";
    bgObj.style.cssText = "position:absolute;left:0px;top:0px;width:"+iWidth+"px;height:"+Math.max(document.body.clientHeight, iHeight)+"px;filter:Alpha(Opacity=30);opacity:0.3;background-color:#000000;z-index:101;";
    document.body.appendChild(bgObj); 
    
    msgObj=document.createElement("div");
    msgObj.id="msgObjId";
    msgObj.style.cssText = "position:absolute;font:11px '宋体';top:"+(iHeight-h)/2+"px;left:"+(iWidth-w)/2+"px;width:"+w+"px;text-align:center;border:1px solid "+bordercolor+";background-color:"+bgcolor+";padding:1px;line-height:22px;z-index:102;";
    document.body.appendChild(msgObj);
    
    var table = document.createElement("table");
    msgObj.appendChild(table);
    table.style.cssText = "margin:0px;border:0px;padding:0px;";
    table.cellSpacing = 0;
    var tr = table.insertRow(-1);
    var titleBar = tr.insertCell(-1);
    titleBar.style.cssText = "width:"+w+"px;height:"+titleheight+"px;text-align:left;padding:3px;margin:0px;font:bold 13px '宋体';color:"+titlecolor+";border:1px solid " + bordercolor + ";cursor:move;background-color:" + titlebgcolor;
    titleBar.style.paddingLeft = "10px";
    titleBar.innerHTML = "通告";
    var moveX = 0;
    var moveY = 0;
    var moveTop = 0;
    var moveLeft = 0;
    var moveable = false;
    var docMouseMoveEvent = document.onmousemove;
    var docMouseUpEvent = document.onmouseup;
    titleBar.onmousedown = function() 
    {
        var evt = getEvent();
        moveable = true; 
        moveX = evt.clientX;
        moveY = evt.clientY;
        moveTop = parseInt(msgObj.style.top);
        moveLeft = parseInt(msgObj.style.left);
        
        document.onmousemove = function() 
        {
            if (moveable) 
            {
                var evt = getEvent();
                var x = moveLeft + evt.clientX - moveX;
                var y = moveTop + evt.clientY - moveY;
                if ( x > 0 &&( x + w < iWidth) && y > 0 && (y + h < iHeight) ) 
                {
                    msgObj.style.left = x + "px";
                    msgObj.style.top = y + "px";
                }
            }    
        };
        document.onmouseup = function () 
        { 
            if (moveable) 
            { 
                document.onmousemove = docMouseMoveEvent;
                document.onmouseup = docMouseUpEvent;
                moveable = false; 
                moveX = 0;
                moveY = 0;
                moveTop = 0;
                moveLeft = 0;
            } 
        };
    }
    
    var closeBtn = tr.insertCell(-1);
    closeBtn.style.cssText = "cursor:pointer; padding:2px;background-color:" + titlebgcolor;
    closeBtn.innerHTML = "<span style='font-size:15pt; color:"+titlecolor+";'>×</span>";
    closeBtn.onclick = function()
    { 
        document.body.removeChild(bgObj); 
        document.body.removeChild(msgObj); 
      //当关闭打开的窗口时，将marquee设置为滚动。   tanyj  2011-09-05
      var mq = document.getElementById("marqueeid") ;
      mq.start() ;
    } 
    var msgBox = table.insertRow(-1).insertCell(-1);
    msgBox.style.cssText = "font:10pt '宋体';padding-top:5px;";
    msgBox.colSpan = 2;
    
    //var msgs = "<span>账 号：</span><input type='text' id='txtName' style='width: 120px' /><br />"
    //            +"<span>密 码：</span><input type='password' id='txtPwd' style='width: 120px' /><br />"
    //            +"<input type='button' value='登录' onclick='getValue(\""+bgObj.id+"\",\""+msgObj.id+"\")' />";
	var msgs = title + "<br/>";
	msgs = msgs + infoDetails;
    msgs = msgs +"<center><input type='button' value='打印' onclick= 'startPrint()' style=' BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#D7E7FA); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid' ></center><br/>";
    msgBox.innerHTML = msgs;
    
    // 获得事件Event对象，用于兼容IE和FireFox
    function getEvent() 
    {
        return window.event || arguments.callee.caller.arguments[0];
    }
    
} 

function showWin(title,noticeInfo, w, h)
{ 
    var titleheight = "22px"
    var bordercolor = "#666699"; // 提示窗口的边框颜色 
    var titlecolor = "#FFFFFF"; // 提示窗口的标题颜色 
    var titlebgcolor = "#666699"; // 提示窗口的标题背景色
    var bgcolor = "#FFFFFF"; // 提示内容的背景色
    
    //var iWidth = document.documentElement.clientWidth; 
    //var iHeight = document.documentElement.clientHeight; 
    var iWidth;
	var iHeight;
	//获取窗口宽度
	if (window.innerWidth)
	{
		iWidth = window.innerWidth;
	}
	else if ((document.body) && (document.body.clientWidth))
	{
		iWidth = document.body.clientWidth;
	}
	//获取窗口高度
	if (window.innerHeight)
	{
		iHeight = window.innerHeight;
	}
	else if ((document.body) && (document.body.clientHeight))
	{
		iHeight = document.body.clientHeight;
	}
	//通过深入Document内部对body进行检测，获取窗口大小
	if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth)
	{
		iHeight = document.documentElement.clientHeight;
		iWidth = document.documentElement.clientWidth;
	}
	if(iHeight == 0)
	{
		iHeight = 600;
	}
	if(iWidth == 0)
	{
		iWidth = 1000;
	}
    
	var evt = getEvent();
    moveable = true; 
    moveX = evt.clientX;
    moveY = evt.clientY;
    showMsgObj=document.createElement("div");
    showMsgObj.id="showMsgObj";
    //showMsgObj.style.cssText = "position:absolute;font:11px '宋体';top:"+(moveY-h/2)+"px;left:"+(moveX-w-10)+"px;width:"+w+"px;height:"+h+"px;text-align:center;border:1px solid "+bordercolor+";background-color:"+bgcolor+";padding:1px;line-height:22px;z-index:102;";
    showMsgObj.style.cssText = "position:absolute;font:11px '宋体';top:"+(moveY)+"px;left:"+(moveX-w-10)+"px;width:"+w+"px;text-align:center;border:1px solid "+bordercolor+";background-color:"+bgcolor+";padding:1px;line-height:22px;z-index:102;";
	document.body.appendChild(showMsgObj);
	
    var table = document.createElement("table");
    showMsgObj.appendChild(table);
    table.style.cssText = "margin:0px;border:0px;padding:0px;";
    table.cellSpacing = 0;
    var tr = table.insertRow(-1);
    var titleBar = tr.insertCell(-1);
    titleBar.style.cssText = "width:"+w+"px;height:"+titleheight+"px;text-align:left;padding:3px;margin:0px;font:bold 13px '宋体';color:"+titlecolor+";border:1px solid " + bordercolor + ";cursor:move;background-color:" + titlebgcolor;
    titleBar.style.paddingLeft = "10px";
    titleBar.innerHTML = "通告";
 
    var msgBox = table.insertRow(-1).insertCell(-1);
    msgBox.style.cssText = "font:10pt '宋体';padding-top:5px;";
    msgBox.colSpan = 2;
    
    //var msgs = "<span>账 号：</span><input type='text' id='txtName' style='width: 120px' /><br />"
    //            +"<span>密 码：</span><input type='password' id='txtPwd' style='width: 120px' /><br />"
    //            +"<input type='button' value='登录' onclick='getValue(\""+bgObj.id+"\",\""+msgObj.id+"\")' />";
	var msgs = title +"<br/>";
	msgs = msgs + document.getElementById(noticeInfo).innerHTML;;
    //msgs = msgs +"<br/><br/><center><input type='button' value='打印' onclick= 'startPrint()' style=' BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#D7E7FA); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid' ></center> ";
    msgBox.innerHTML = msgs;
    
    // 获得事件Event对象，用于兼容IE和FireFox
    function getEvent() 
    {
        return window.event || arguments.callee.caller.arguments[0];
    }
} 

function closeWin()
{
	document.body.removeChild(showMsgObj); 
}

function startPrint(obj)
{
    var oWin=window.open("","_blank");
    var strPrint="<h4 style=’font-size:18px; text-align:center;’>以下为打印内容</h4>\n";
    strPrint=strPrint + "<script type=\"text/javascript\">\n";
    strPrint=strPrint + "function printWin()\n";
    strPrint=strPrint + "{";
    strPrint=strPrint +    "var oWin=window.open(\"\",\"_blank\");\n";
    strPrint=strPrint + "oWin.document.write(document.getElementById(\"content\").innerHTML);\n";
    strPrint=strPrint + "oWin.focus();\n";
    strPrint=strPrint + "oWin.document.close();\n";
    strPrint=strPrint + "oWin.print()\n";
    strPrint=strPrint + "oWin.close()\n";
    strPrint=strPrint + "}\n";
    strPrint=strPrint + "<\/script>\n";
    
    strPrint=strPrint + "<hr size=’1′ />\n";
    strPrint=strPrint + "<div id=\"content\">\n";
    strPrint=strPrint + "<b>" + "主题：" + infoTitle + "</b><br/>";
    strPrint=strPrint + infoDetails + "\n";
    strPrint=strPrint + "</div>\n";
    strPrint=strPrint + "<hr size=’1′ />\n";
    strPrint=strPrint + "<div style='text-align:center'><button onclick='printWin()'style='BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#D7E7FA); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid'>打  印</button>&nbsp<button onclick='window.opener=null;window.close();' style='BORDER-RIGHT: #2C59AA 1px solid; PADDING-RIGHT: 2px; BORDER-TOP: #2C59AA 1px solid; PADDING-LEFT: 2px; FONT-SIZE: 12px; FILTER: progid:DXImageTransform.Microsoft.Gradient(GradientType=0, StartColorStr=#ffffff, EndColorStr=#D7E7FA); BORDER-LEFT: #2C59AA 1px solid; CURSOR: hand; COLOR: black; PADDING-TOP: 2px; BORDER-BOTTOM: #2C59AA 1px solid'>关  闭</button></div>\n";
    oWin.document.write(strPrint);
    oWin.focus();
    oWin.document.close();
}


//执行后台 click()
function getValue(bgObjId,msgObjId) 
{
    document.getElementById("txtVal").value = "姓名是：" + document.getElementById("txtName").value+",   密码是："+document.getElementById("txtPwd").value;
    var bgObj = document.getElementById(bgObjId);
    var msgObj = document.getElementById(msgObjId);
    
    document.body.removeChild(bgObj); 
    document.body.removeChild(msgObj); 
    
    //执行隐藏服务器按钮后台事件
    // document.getElementById("btnOk").click(); 
}