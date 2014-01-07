package cn.com.jnpc.meeting.servlet;

import java.util.ArrayList;
import java.util.List;

import cn.com.jnpc.meeting.bean.Meeting;
import cn.com.jnpc.meeting.dao.JNPC;
import cn.com.jnpc.meeting.dao.MeetingDao;
import cn.com.jnpc.meeting.dao.MeetingRoomDao;
import cn.com.jnpc.utils.Page;
import cn.com.jnpc.utils.PropertyFilter;

public class QueryOld extends BsServlet{

	private static final long serialVersionUID = 1L;
	
	private MeetingRoomDao meetingRoomDao = new MeetingRoomDao();
	private MeetingDao meetingDao = new MeetingDao();
	private JNPC jnpc = new JNPC();
	Page<Meeting> page = new Page<Meeting>(10);
	
	
	public String toQuery() {
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";
		request.setAttribute("orgs", jnpc.getAllORG());// 所有部门
		request.setAttribute("mrs", meetingRoomDao.getMeetingRoom());
		request.setAttribute("ctrl", "toQuery");
		request.setAttribute("action", basePath
		//		+ "MeetingServlet?ctrl=querylist");
				+ "QueryOld?ctrl=querylist");
		request.setAttribute("ctrlname", "历史会议查询");
		request.setAttribute("from", "nt");

		request.setAttribute("name", "会议名称");
		request.setAttribute("department", "会议申请部门");
		request.setAttribute("address", "会议地址");
		request.setAttribute("meetingtime", "会议时间");
		return BASE_JSP + "meeting/meetingQry.jsp";
	}

	public String getQuery() {
		String path = request.getContextPath();
		String basePath = request.getScheme() + "://" + request.getServerName()
				+ ":" + request.getServerPort() + path + "/";
		request.setAttribute("orgs", jnpc.getAllORG());// 所有部门
		request.setAttribute("mrs", meetingRoomDao.getMeetingRoom2());
		request.setAttribute("ctrl", "getQuery");
		request.setAttribute("action", basePath
		//		+ "MeetingServlet?ctrl=querylist");
				+ "QueryOld?ctrl=querylist");
		request.setAttribute("ctrlname", "历史培训申请查询");
		request.setAttribute("from", "mt");

		request.setAttribute("name", "培训课程名称");
		request.setAttribute("department", "none");
		request.setAttribute("address", "培训教室");
		request.setAttribute("meetingtime", "培训时间");
		return BASE_JSP + "meeting/meetingQry.jsp";
	}

	public String querylist() {
		String from = request.getParameter("from");
		String starttime = request.getParameter("_starttime") != null ? request
				.getParameter("_starttime") : request.getParameter("starttime");
		String starttime2 = request.getParameter("_starttime2") != null ? request
				.getParameter("_starttime2") : request
				.getParameter("starttime2");
		String endtime = request.getParameter("_endtime") != null ? request
				.getParameter("_endtime") : request.getParameter("endtime");
		String endtime2 = request.getParameter("_endtime2") != null ? request
				.getParameter("_endtime2") : request.getParameter("endtime2");
		String org = request.getParameter("_org") != null ? request
				.getParameter("_org") : request.getParameter("org");
		String roomID = request.getParameter("_roomID") != null ? request
				.getParameter("_roomID") : request.getParameter("roomID");
		String content = request.getParameter("_content") != null ? request
				.getParameter("_content") : request.getParameter("content");
		String pageNo = request.getParameter("pageNo");
		starttime = (starttime == null || starttime == "null") ? "" : starttime;
		starttime2 = (starttime2 == null || starttime2 == "null") ? ""
				: starttime2;
		endtime = (endtime == null || endtime == "null") ? "" : endtime;
		endtime2 = (endtime2 == null || endtime2 == "null") ? "" : endtime2;
		org = (org == null || org == "null") ? "" : org;
		roomID = (roomID == null || roomID == "null") ? "" : roomID;
		content = (content == null || content == "null") ? "" : content;
		pageNo = (pageNo == null || pageNo == "null") ? "" : pageNo;
		from = (from == null || from == "null") ? "" : from;

		PropertyFilter st = new PropertyFilter("m.starttime:GE_D", starttime);
		PropertyFilter st2 = new PropertyFilter("m.starttime:LE_D", starttime2);
		PropertyFilter et = new PropertyFilter("m.endtime:GE_D", endtime);
		PropertyFilter et2 = new PropertyFilter("m.endtime:LE_D", endtime2);
		PropertyFilter rpf = new PropertyFilter("m.roomid:EQ_I", roomID);
		PropertyFilter orgpf = new PropertyFilter("m.commitdepart:EQ_S", org);
		PropertyFilter cpf = new PropertyFilter("m.content:LIKE_S", content);
		PropertyFilter stu = new PropertyFilter("m.status:EQ_I", "3");
		List<PropertyFilter> pfList = new ArrayList<PropertyFilter>();

		request.setAttribute("from", from);
		if ("mt".equals(from)) {// 培训通知
			PropertyFilter t = new PropertyFilter("m.type:EQ_I", "4");
			request.setAttribute("day", "日期");
			request.setAttribute("time", "时间");
			request.setAttribute("name", "培训课程名称");
			request.setAttribute("ren", "教员");
			request.setAttribute("danwei", "培训组织处室/项目负责人");
			request.setAttribute("addre", "培训地点");
			request.setAttribute("people", "参加单位/人员");
			pfList.add(t);
		} else {
			request.setAttribute("day", "日期");
			request.setAttribute("time", "时间");
			request.setAttribute("name", "会议名称");
			request.setAttribute("ren", "主持人");
			request.setAttribute("danwei", "承办单位");
			request.setAttribute("addre", "会议地点");
			request.setAttribute("people", "参加单位/人员");
		}
		pfList.add(st);
		pfList.add(st2);
		pfList.add(et);
		pfList.add(et2);
		pfList.add(orgpf);
		pfList.add(rpf);
		pfList.add(cpf);
		pfList.add(stu);
		page.setPageSize(100);
		if (pageNo == null || "".equals(pageNo)) {
			page.setPageNo(1);
		} else {
			page.setPageNo(Integer.parseInt(pageNo));
		}
		page.setForwordName("QueryOld?ctrl=querylist&starttime=" + starttime
				+ "&starttime2=" + starttime2 + "&endtime=" + endtime
				+ "&endtime2=" + endtime2 + "&org=" + org + "&roomID=" + roomID
				+ "&content=" + content + "&from=" + from + "&pageNo=");
		request.setAttribute("meetings",
				meetingDao.getShowMeeting(page, pfList, from).getResult());
		request.setAttribute("tag", page.getTag());
		return BASE_JSP + "meeting/meetingQrylist.jsp";
	}
}
