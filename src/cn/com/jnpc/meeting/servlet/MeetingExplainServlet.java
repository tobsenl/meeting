package cn.com.jnpc.meeting.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.jnpc.meeting.bean.MeetingExplain;
import cn.com.jnpc.meeting.dao.MeetingExplainDao;

public class MeetingExplainServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public static final int SUCCEED = 1;
    public static final int ERROR = 0;
    private String errors = "";
    private MeetingExplainDao meetingExplainDao;

    @Override
    public void init() throws ServletException {
	super.init();
	meetingExplainDao = new MeetingExplainDao();
    }

    public MeetingExplainServlet() {
	super();
	// TODO Auto-generated constructor stub
    }

    protected void doGet(HttpServletRequest request,
	    HttpServletResponse response) throws ServletException, IOException {
	doPost(request, response);
    }

    protected void doPost(HttpServletRequest request,
	    HttpServletResponse response) throws ServletException, IOException {
	String ctrl = request.getParameter("ctrl");
	String name = request.getParameter("name");
	String style = request.getParameter("style");
	String unit = request.getParameter("unit");
	String display = request.getParameter("display");
	String parentid = request.getParameter("parentid");
	String id = request.getParameter("id");
	boolean flag = false;
	if ("list".equals(ctrl)) {
	    list(request, response);
	} else if ("add".equals(ctrl)) {
	    flag = meetingExplainDao.add(name, style, unit, display, parentid);
	    if (flag) {
		request.setAttribute("msg", SUCCEED);
	    } else {
		request.setAttribute("msg", ERROR);
	    }
	    list(request, response);
	} else if ("addChild".equals(ctrl)) {
	    flag = meetingExplainDao.add(name, style, unit, display, parentid);
	    if (flag) {
		request.setAttribute("msg", SUCCEED);
	    } else {
		request.setAttribute("msg", ERROR);
	    }
	    list(request, response);
	} else if ("update".equals(ctrl)) {
	    flag = meetingExplainDao.update(id, name, style, unit, display);
	    if (flag) {
		request.setAttribute("msg", SUCCEED);
	    } else {
		request.setAttribute("msg", ERROR);
	    }
	    list(request, response);
	} else if ("del".equals(ctrl)) {
	    flag = meetingExplainDao.del(id);
	    if (flag) {
		request.setAttribute("msg", SUCCEED);
	    } else {
		request.setAttribute("msg", ERROR);
	    }
	    list(request, response);
	}
    }

    private void list(HttpServletRequest request, HttpServletResponse response)
	    throws ServletException, IOException {
	Vector<String> vec = (Vector<String>) request.getSession()
		.getAttribute("vec");
	if (vec == null) {
	    errors = "系统session超时，请重新登录！";
	    toErrorPage(request,errors,response);
	}
	if (vec.contains("381001")) {
	    List<MeetingExplain> mes = meetingExplainDao.getAll();
	    request.setAttribute("mes", mes);
	    request.getRequestDispatcher("/WEB-INF/views/setting/explain.jsp")
		    .forward(request, response);
	} else {
	    errors = "对不起，您没有此项操作的权限！";
	    toErrorPage(request, errors,response);
	}
    }

    private String toErrorPage(HttpServletRequest request, String error,HttpServletResponse response) {
	request.setAttribute("error", error);
	try {
	    request.getRequestDispatcher("/error.jsp").forward(request,
		    response);
	} catch (Exception e) {
	    e.printStackTrace();
	}
	return "";
    }

}
