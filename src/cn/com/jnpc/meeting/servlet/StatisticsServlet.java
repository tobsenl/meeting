package cn.com.jnpc.meeting.servlet;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.com.jnpc.meeting.bean.Counter;
import cn.com.jnpc.meeting.bean.Meeting;
import cn.com.jnpc.meeting.bean.MeetingRoom;
import cn.com.jnpc.meeting.dao.JNPC;
import cn.com.jnpc.meeting.dao.MeetingDao;
import cn.com.jnpc.meeting.dao.MeetingRoomDao;
import cn.com.jnpc.utils.DateUtil;
import cn.com.jnpc.utils.PropertyFilter;

/**
 * 处理统计用的Servlet
 */
public class StatisticsServlet extends BaseServlet {
    private static final long serialVersionUID = 1L;

    private MeetingRoomDao meetingRoomDao = new MeetingRoomDao();
    private MeetingDao meetingDao = new MeetingDao();
    private JNPC jnpc = new JNPC();

    public String meetingRoomQry() {
	List<MeetingRoom> resu = meetingRoomDao.getAllMeetingRoomShow();
	request.setAttribute("result", resu);
	String roomID = request.getParameter("roomID");
	String startTime = request.getParameter("startTime");
	String endTime = request.getParameter("endTime");
	List<Meeting> res = meetingDao.getMeetingByRoomAndTime(roomID,
		startTime, endTime);
	request.setAttribute("meetings", res);
	return BASE_JSP + "statistics/meetingRoomQry.jsp";
    }

    public String sdetail() {
	String roomID = getParameter("roomID");
	String startTime = getParameter("startTime");
	String endTime = getParameter("endTime");
	String roomname = getParameter("roomname");
	PropertyFilter rp = new PropertyFilter("m.roomid:EQ_I", roomID);
	PropertyFilter sp = new PropertyFilter("m.starttime:GE_D", startTime);
	PropertyFilter ep = new PropertyFilter("m.endtime:LE_D", endTime);
	List<PropertyFilter> pfList = new ArrayList<PropertyFilter>();
	pfList.add(rp);
	pfList.add(sp);
	pfList.add(ep);
	// List<Object[]> list =
	// meetingDao.getMeetingRoomDetailStatistics(roomID);
	List<Object[]> list = meetingDao
		.getMeetingRoom2DetailStatistics(pfList);
	request.setAttribute("title", roomname + "&nbsp;&nbsp;使用详细情况统计");
	request.setAttribute("result", list);
	return BASE_JSP + "statistics/statistics2Detail.jsp";
    }

    public String statistics() {
	if (vec.contains("380901")) {
	    String startTime = request.getParameter("startTime");
	    String endTime = request.getParameter("endTime");
	    if ((startTime == null || "".equals(startTime))
		    && (endTime == null || "".equals(endTime))) {
		endTime = DateUtil.getCurrentDate("yyyy-MM-dd");
		startTime = DateUtil.dateToString(DateUtil.addMonth(
			DateUtil.stringToDate(endTime, "yyyy-MM-dd"), -1),
			"yyyy-MM-dd");
	    }
	    String org = request.getParameter("org");
	    List<Object[]> list = meetingDao.getMeetingStatistics(startTime,
		    endTime, org);
	    request.setAttribute("result", list);
	    List<Object[]> orgs = jnpc.getAllORG();
	    request.setAttribute("orgs", orgs);// 所有的部门
	    request.setAttribute("title", "会议通知处理情况统计查询");
	    return BASE_JSP + "statistics/statistics.jsp";
	} else {
	    error = "对不起，您没有此项操作的权限！";
	    return toErrorPage(error);
	}
    }

    public String statistics2() {
	if (vec.contains("380901")) {
	    String roomID = getParameter("_roomID");
	    String startTime = getParameter("startTime");
	    String endTime = getParameter("endTime");
	    PropertyFilter rp = new PropertyFilter("m.roomid:EQ_I", roomID);
	    PropertyFilter sp = new PropertyFilter("m.starttime:GE_D",
		    startTime);
	    PropertyFilter ep = new PropertyFilter("m.endtime:LE_D", endTime);
	    List<PropertyFilter> pfList = new ArrayList<PropertyFilter>();
	    pfList.add(rp);
	    pfList.add(sp);
	    pfList.add(ep);
	    List<MeetingRoom> mrs = meetingRoomDao.getMeetingRoom();
	    request.setAttribute("mrs", mrs);
	    // request.setAttribute("mrs", meetingRoom2Dao.getParentRoom());//
	    // 所有的会议室建筑
	    request.setAttribute("title", "会议室情况统计表");
	    // List<Object[]> list = meetingDao.getMeetingRoomStatistics
	    // (roomID);
	    List<Object[]> list = meetingDao.getMeetingRoom2Statistics(pfList);
	    request.setAttribute("result", list);
	    return BASE_JSP + "statistics/statistics2.jsp";
	} else {
	    error = "对不起，您没有此项操作的权限！";
	    return toErrorPage(error);
	}
    }

    public String count() {
	if (vec.contains("380901")) {
	    String year = request.getParameter("year");
	    String month = request.getParameter("month");
	    String day = request.getParameter("day");
	    if (isEmpty(year)) {
		year = DateUtil.getCurrentDate("yyyy");
	    }
	    if (isEmpty(month)) {
		month = DateUtil.getCurrentDate("MM");
	    }
	    if (isEmpty(day)) {
		day = DateUtil.getCurrentDate("dd");// 此处请参阅API
						    // java.text.SimpleDateFormat
	    }
	    List<Counter> counters = meetingDao.meetingCount(
		    Integer.parseInt(year), Integer.parseInt(month),
		    Integer.parseInt(day));
	    Date curDate = DateUtil.getDate(Integer.parseInt(year),
		    Integer.parseInt(month), 0);// 当前月的最后一天
	    Date queryDate = DateUtil.getDate(Integer.parseInt(year),
		    Integer.parseInt(month) - 1, Integer.parseInt(day));// 当前月的查询当天。
	    Date firstNextDate = DateUtil.addDay(curDate, 1);// 下个月的第一天
	    Date nextDate = DateUtil.addMonth(curDate, +1);// 下个月的最后一天
	    request.setAttribute("counters", counters);
	    request.setAttribute("title", "会议召开次数统计");
	    request.setAttribute("querybegin", year + "-" + month + "-" + 1);
	    Date queryend = isEmpty(day) ? curDate : queryDate;
	    request.setAttribute("queryend",
		    DateUtil.dateToString(queryend, "yyyy-MM-dd"));
	    request.setAttribute("querynextend",
		    DateUtil.dateToString(nextDate, "yyyy-MM-dd"));
	    request.setAttribute("querynextbegin",
		    DateUtil.dateToString(firstNextDate, "yyyy-MM-dd"));
	    return BASE_JSP + "statistics/count.jsp";
	} else {
	    error = "对不起，您没有此项操作的权限！";
	    return toErrorPage(error);
	}
    }

    public String meetingAndMeetingPlan() {
	if (vec.contains("380901")) {
	    String y = request.getParameter("year");
	    String m = request.getParameter("month");
	    request.setAttribute("title", "会议计划及会议执行情况");
	    int year = (y == null || "".equals(y)) ? Integer.parseInt(DateUtil
		    .getCurrentDate("yyyy")) : Integer.parseInt(y);
	    int month = ((m == null || "".equals(m)) ? Integer
		    .parseInt(DateUtil.getCurrentDate("MM")) : Integer
		    .parseInt(m));
	    request.setAttribute("result",
		    meetingDao.getActualPlan(year, month));
	    return BASE_JSP + "statistics/asp.jsp";
	} else {
	    error = "对不起，您没有此项操作的权限！";
	    return toErrorPage(error);
	}
    }

}
