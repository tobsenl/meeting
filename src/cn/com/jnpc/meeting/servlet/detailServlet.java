package cn.com.jnpc.meeting.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.com.jnpc.meeting.dao.MeetingDao;

public class detailServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	MeetingDao meeting = new MeetingDao();
	
    public detailServlet() {
        super();
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        String meetingid = request.getParameter("id");
        String detail = meeting.getMeetingById(meetingid).getDetail();
        request.setAttribute("detail", detail);
        request.getRequestDispatcher("/detail.jsp").forward(request, response);
    }
}
