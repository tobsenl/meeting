package cn.com.jnpc.meeting.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Logout extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
	request.setCharacterEncoding("UTF-8");
	response.setLocale(java.util.Locale.CHINESE);
        HttpSession session = request.getSession(true);
        String userid = (String)session.getAttribute("userid");
        String passwd = (String)session.getAttribute("passwd");
        session.removeAttribute("userid");
        session.removeAttribute("passwd");
        session.removeAttribute("vec");
        response.sendRedirect("http://www0.jnpc.com.cn/login/login.jsp");
//        PrintWriter out = res.getWriter();
//        out.println("<html><head></head><body>");
//        out.println("<FORM METHOD=POST ACTION=\"http://login.jnpc.com.cn/login/all_index.jsp\" name=form1>");
//        out.println("<INPUT TYPE=\"hidden\" NAME=\"userid\" value=" + userid + ">");
//        out.println("<INPUT TYPE=\"hidden\" NAME=\"passwd\" value=" + passwd + ">");
//        out.println("<INPUT TYPE=\"hidden\" NAME=\"return\" value=\"1\">");
//        out.println("</FORM></body></html>");
//        // out.println("<SCRIPT LANGUAGE=\"JavaScript\">form1.target=\"_top\";form1.submit();</SCRIPT>");
//        out.flush();
//        out.close();
    }
}