package cn.com.jnpc.meeting.servlet;

import java.io.IOException;
import java.io.ObjectInputStream.GetField;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletException;

import cn.com.jnpc.email.EmailSender;
import cn.com.jnpc.email.OutLook;
import cn.com.jnpc.meeting.bean.Meeting;
import cn.com.jnpc.meeting.bean.MeetingRoom;
import cn.com.jnpc.meeting.dao.JNPC;
import cn.com.jnpc.meeting.dao.MeetingDao;
import cn.com.jnpc.meeting.dao.MeetingExplainDao;
import cn.com.jnpc.meeting.dao.MeetingRoomDao;
import cn.com.jnpc.utils.DateUtil;
import cn.com.jnpc.utils.Page;
import cn.com.jnpc.utils.PropertyFilter;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class MeetingServlet extends BaseServlet {

    private static final long serialVersionUID = 1L;
    private MeetingRoomDao meetingRoomDao = new MeetingRoomDao();
    private MeetingDao meetingDao = new MeetingDao();
    private JNPC jnpc = new JNPC();
    Page<Meeting> page = new Page<Meeting>(10);
    private MeetingExplainDao meetingExplainDao = new MeetingExplainDao();

    // public String allot() {
    // String id = request.getParameter("id");
    // request.setAttribute("mrs", meetingRoomDao.getFreeRoom(id));
    // request.setAttribute("id", id);
    // request.setAttribute("leader",
    // meetingDao.getMeetingById(id).getLeader());
    // return "/views/meeting/meetingAllot.jsp";
    // }
    /**
     * 添加会议
     * 
     * @Title: add
     * @return
     */
    public String add() {
	int flag;
	String json = request.getParameter("json");

	Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm")
		.create();
	Meeting m = gson.fromJson(json, Meeting.class);
	m.setCommiterid(userid);
	flag = meetingDao.meetingAdd(m, userid);
	// 添加记录并返回是否添加成功
	if (flag != -1 && flag != -999 && flag != -99 && flag != -98) { // 添加成功
	    return listByDept();
	} else if (flag == -99) {
	    error = "主持人在此时间段正参与其他会议，请检查！";
	} else if (flag == -98) {
	    error = "领导在此时间段正参与其他会议，请检查！";
	} else if (flag == -999) {
	    error = "已经存在一条相同的记录！";
	} else { // 添加不成功
	    error = "";
	}
	return toErrorPage(error);
    }

    /**
     * 分配会议室
     * 
     * @Title: allotRoom
     * @return
     */
    public String toAllotRoom() {
	// String roomID = request.getParameter("roomID");
	// String id = request.getParameter("id");
	// String leaders = request.getParameter("leaders");
	// String isEmail = request.getParameter("isemail");
	// int flag = meetingDao.allotRoom(id, roomID, userid);
	// if (flag > 0) {
	// if ("true".equals(isEmail)) {// 是否发送提醒
	// if (leaders != null && !"".equals(leaders)) {
	// OutLook ol = new OutLook();
	// String[] lemails = jnpc.getLeadersEmail(leaders.split(","));
	// ol.sendAppointment(meetingDao.getMeetingById(id), lemails);
	// }
	// }
	// return toAllot();
	// } else if (flag == -99) {
	// error = "会议室分配冲突,请重新分配";
	// return toErrorPage(error);
	// } else {
	// return toErrorPage(error);
	// }
	String roomID = request.getParameter("roomId");
	String meetingId = request.getParameter("id");
	getParameter("from");
	List<MeetingRoom> fmrs = meetingRoomDao.getFreeRoom(meetingId);// 可用的会议室
	List<MeetingRoom> amrs = meetingRoomDao.getAllMeetingRoomShow();// 所有会议室
	for (MeetingRoom mr1 : amrs) {
	    for (MeetingRoom mr2 : fmrs) {
		if (mr1.getId().equals(mr2.getId())) {
		    mr1.setIsFree("1");// 标记为可用
		    break;
		}
	    }
	}
	request.setAttribute("roomId", roomID);
	request.setAttribute("meetingId", meetingId);
	request.setAttribute("mrs", amrs);
	return BASE_JSP + "meeting/meetingAllot.jsp";
    }

    public String allotRoom() {
	String roomID = request.getParameter("roomId");
	String meetingId = request.getParameter("meetingID");
	String from = request.getParameter("from");
	int flag = meetingDao.allotRoom(meetingId, roomID, userid);
	if (flag >= 0) {
	    if ("re".equals(from)) {
		return toReAllot();
	    }
	    return toAllot();
	} else if (flag == -99) {
	    error = "会议室分配冲突,请重新分配";
	    return toErrorPage(error);
	} else {
	    return toErrorPage("");
	}
    }

    /**
     * 去审批会议
     * 
     * @Title: approve
     * @return
     */
    public String approve() {
	if (vec.contains("380201")) {
	    request.setAttribute("meetings",
		    meetingDao.getMeetingByStatus("0", "1"));
	    request.setAttribute("title", "会议审批");
	    return BASE_JSP + "meeting/approve.jsp";
	} else {
	    error = "对不起，您没有会议审核的权限！";
	    return toErrorPage(error);
	}
    }

    /**
     * 审批会议
     * 
     * @Title: approved
     * @return
     */
    public String approved() {
	int flag;
	String[] approves = request.getParameterValues("approve");
	String[] disapproves = request.getParameterValues("disapprove");
	flag = meetingDao.approve(approves, disapproves, userid);
	if (flag != -1) {
	    return approve();
	} else {
	    return toErrorPage(error);
	}
    }

    /**
     * 删除会议
     * 
     * @Title: del
     * @return
     */
    public void del() {
	int flag;
	String id = request.getParameter("id");
	flag = meetingDao.delete(id);
	if (flag != -1) {
	    writeObjToPage(0);
	} else {
	    writeObjToPage(1);
	}
    }

    /**
     * 退回会议
     * 
     * @Title: goBack
     * @return
     */
    public String goBack() {
	String id = request.getParameter("id");
	Meeting m = meetingDao.getMeetingById(id);
	boolean flag = meetingDao.goBackMeet(id);
	if (flag) {
	    String email = jnpc.getEmailByUserID(m.getCommiterid());
	    EmailSender es = new EmailSender();
	    es.send(email, m);
	    return toAllot();
	} else {
	    return toErrorPage("");
	}
    }

    /**
     * 查找会议
     * 
     * @Title: list
     * @return
     */
    public String list() {
	if (vec.contains("380101")) {
	    String from = request.getParameter("from");
	    String starttime = request.getParameter("_starttime");
	    String starttime2 = request.getParameter("_starttime2");
	    String endtime = request.getParameter("_endtime");
	    String endtime2 = request.getParameter("_endtime2");
	    String org = request.getParameter("_org");
	    String buildingid = request.getParameter("_buildingid");
	    String roomID = request.getParameter("_roomID");
	    String roomName = request.getParameter("_roomName");
	    String content = request.getParameter("_content");
	    String pageNo = request.getParameter("pageNo");
	    request.setAttribute("from", from);
	    request.setAttribute("starttime", starttime);
	    request.setAttribute("starttime2", starttime2);
	    request.setAttribute("endtime", endtime);
	    request.setAttribute("endtime2", endtime2);
	    request.setAttribute("org", org);
	    request.setAttribute("buildingid", buildingid);
	    request.setAttribute("roomID", roomID);
	    request.setAttribute("roomName", roomName);
	    request.setAttribute("content", content);
	    PropertyFilter st = new PropertyFilter("m.starttime:GE_D",
		    starttime);
	    PropertyFilter st2 = new PropertyFilter("m.starttime:LE_D",
		    starttime2);
	    PropertyFilter et = new PropertyFilter("m.endtime:GE_D", endtime);
	    PropertyFilter et2 = new PropertyFilter("m.endtime:LE_D", endtime2);
	    PropertyFilter orgpf = new PropertyFilter("m.commitdepart:EQ_S",
		    org);
	    PropertyFilter rpf = new PropertyFilter("m.roomid:EQ_I", roomID);
	    PropertyFilter cpf = new PropertyFilter("m.content:LIKE_S", content);
	    List<PropertyFilter> pfList = new ArrayList<PropertyFilter>();
	    // PropertyFilter t = null;
	    // if ("m".equals(from)) {// 会议
	    // t = new PropertyFilter("m.type:UNEQ_I", "4");
	    // } else

	    if ("mt".equals(from)) {// 培训通知
		PropertyFilter t = new PropertyFilter("m.type:EQ_I", "4");
		pfList.add(t);
	    }
	    pfList.add(st);
	    pfList.add(st2);
	    pfList.add(et);
	    pfList.add(et2);
	    pfList.add(orgpf);
	    pfList.add(rpf);
	    pfList.add(cpf);
	    // pfList.add(t);
	    if (pageNo == null || "".equals(pageNo)) {
		page.setPageNo(1);
	    } else {
		page.setPageNo(Integer.parseInt(pageNo));
	    }
	    page.setForwordName("MeetingServlet?ctrl=list&starttime="
		    + starttime + "&starttime2=" + starttime2 + "&endtime="
		    + endtime + "&endtime2=" + endtime2 + "&org=" + org
		    + "&roomID=" + roomID + "&content=" + content + "&from="
		    + from + "&pageNo=");
	    request.setAttribute("meetings", meetingDao
		    .getMeeting(page, pfList).getResult());
	    request.setAttribute("tag", page.getTag());
	    request.setAttribute("orgs", jnpc.getAllORG());// 所有部门
	    return meetingList();
	} else {
	    error = "对不起，您没有此项操作的权限！";
	    return toErrorPage(error);
	}
    }

    public String listByDept() {
	String pageNo = request.getParameter("pageNo");
	if (pageNo == null || "".equals(pageNo)) {
	    page.setPageNo(1);
	} else {
	    page.setPageNo(Integer.parseInt(pageNo));
	}
	page.setForwordName("MeetingServlet?ctrl=listByDept&pageNo=");
	request.setAttribute("meetings",
		meetingDao.getMeetingByUserid(page, userid).getResult());
	request.setAttribute("tag", page.getTag());
	request.setAttribute("title", "会议申请浏览");

	return BASE_JSP + "meeting/meetingList2.jsp";
    }

    public String listMeeting() {
	if (vec.contains("380401")) {
	    String type = request.getParameter("type");
	    String t = request.getParameter("title");// 1:最新会议,2:历史会议;3:最新例会,4:历史例会
	    String pageNo = request.getParameter("pageNo");
	    if (pageNo == null || "".equals(pageNo)) {
		page.setPageNo(1);
	    } else {
		page.setPageNo(Integer.parseInt(pageNo));
	    }
	    String title = "";
	    if ("1".equals(t)) {
		title = "最新会议";
		request.setAttribute("meetings",
			meetingDao.getMeeting(page, type).getResult());
	    } else if ("2".equals(t)) {
		title = "历史会议";
		request.setAttribute("meetings",
			meetingDao.getHistoryMeeting(page, type).getResult());
	    } else if ("3".equals(t)) {
		title = "最新例会";
		request.setAttribute("meetings",
			meetingDao.getMeeting(page, type).getResult());
	    } else if ("4".equals(t)) {
		title = "历史例会";
		request.setAttribute("meetings",
			meetingDao.getHistoryMeeting(page, type).getResult());
	    } else if ("5".equals(t)) {
		title = "最新外部会议";
		request.setAttribute("meetings",
			meetingDao.getMeeting(page, type).getResult());
	    } else if ("6".equals(t)) {
		title = "历史外部会议";
		request.setAttribute("meetings",
			meetingDao.getHistoryMeeting(page, type).getResult());
	    }
	    request.setAttribute("title", title);
	    page.setForwordName("MeetingServlet?ctrl=listMeeting&type=" + type
		    + "&title=" + t + "&pageNo=");
	    request.setAttribute("tag", page.getTag());
	    return BASE_JSP + "meeting/meetingList2.jsp";
	} else {
	    return toErrorPage("");
	}
    }

    // public String allotSubmit() {
    // int flag;
    // String roomID = request.getParameter("radio");
    // String id = request.getParameter("meetingID");
    // String leader = request.getParameter("leader");
    // String isEmail = request.getParameter("isemail");
    // flag = meetingDao.allotRoom(id, roomID, userid);
    // if (flag > 0) {
    // if ("true".equalsIgnoreCase(isEmail) && leader != null
    // && !"".equals(leader)) {
    // EmailSender es = new EmailSender();
    // es.send(meetingDao.getMeetingDetailById(id));
    // }
    // return toAllot();
    // } else if (flag == -99) {
    // error = "会议室分配冲突,请重新分配";
    // return toErrorPage(error);
    // } else {
    // return toErrorPage(error);
    // }
    // }
    public String meetingList() {
	request.setAttribute("orgs", jnpc.getAllORG());// 所有部门
	// 所有没有删除的会议室
	List<MeetingRoom> mrs = meetingRoomDao.getAllMeetingRoomShow();
	// 所有没有删除的会议室
	// List<MeetingRoom2> mrs = meetingRoom2Dao.getParentRoom();// 获取所有的建筑
	request.setAttribute("mrs", mrs);
	request.setAttribute("title", "会议浏览");
	// request.setAttribute("meetings",
	// meetingDao.getMeeting(page, new ArrayList<PropertyFilter>())
	// .getResult());
	// request.setAttribute("tag", page.getTag());
	return BASE_JSP + "meeting/meetingList.jsp";
    }

    /**
     * 去申请会议
     * 
     * @return
     * @throws ServletException
     * @throws IOException
     */
    public String toAdd() {
	if (vec.contains("380101")) {
	    // 所有的领导
	    request.setAttribute("leaderList", jnpc.getLeaders());
	    // 所有的会议室建筑
	    // request.setAttribute("mrs", meetingRoom2Dao.getParentRoom());
	    // 所有的培训教室
	    // request.setAttribute("trs", meetingRoom2Dao.getTrainingRoom());
	    // 所有的会议室
	    request.setAttribute("mrs", meetingRoomDao.getMeetingRoom());
	    // 所有部门
	    request.setAttribute("orgs", jnpc.getAllORG());
	    request.setAttribute("ctrl", "add");
	    request.setAttribute("u_org", u_org);
	    // 页面标题
	    request.setAttribute("title", "申请会议");
	    // 所有显示的有关说明
	    request.setAttribute("mes", meetingExplainDao.getAllShow());
	    return BASE_JSP + "meeting/meeting.jsp";
	} else {
	    error = "对不起，您没有部门会议申请的权限！";
	    return toErrorPage(error);
	}
    }

    /**
     * 去分配会议室
     * 
     * @Title: toAllot
     * @return
     */
    public String toAllot() {
	if (vec.contains("380301")) {
	    request.setAttribute("title", "会议室分配");
	    request.setAttribute("btn", "分配会议室");// 页面按钮文字
	    request.setAttribute("from", "");
	    // // 获取所有的建筑
	    // List<MeetingRoom2> mrs = meetingRoom2Dao.getParentRoom();
	    request.setAttribute("mrs", meetingRoomDao.getMeetingRoom());
	    request.setAttribute("meetings",
		    meetingDao.getMeetingByStatus("1", "1"));
	    return BASE_JSP + "meeting/meetingToAllot.jsp";
	} else {
	    error = "对不起，您没有会议室分配的权限！";
	    return toErrorPage(error);
	}
    }

    /**
     * 去查找会议
     * 
     * @Title: toMeetingQry
     * @return
     */
    public String toMeetingQry() {
	if (vec.contains("380401")) {
	    return list();
	} else {
	    error = "对不起，您没有会议浏览修改的权限！";
	    return toErrorPage(error);
	}
    }

    /**
     * 去查找会议室使用情况。
     * 
     * @Title: toMeetingRoomQry
     * @return
     */
    public String toMeetingRoomQry() {
	if (vec.contains("380101")) {
	    request.setAttribute("title", "会议室详细信息查询");
	    List<MeetingRoom> res = meetingRoomDao.getAllMeetingRoomShow();
	    request.setAttribute("result", res);
	    return BASE_JSP + "statistics/meetingRoomQry.jsp";
	} else {
	    error = "对不起，您没有此项操作的权限！";
	    return toErrorPage(error);
	}
    }

    /**
     * 去重新分配会议室
     * 
     * @Title: toReAllot
     * @return
     */
    public String toReAllot() {
	if (vec.contains("380301")) {
	    request.setAttribute("title", "重新分配会议室");
	    request.setAttribute("btn", "调配会议室");// 页面按钮文字
	    request.setAttribute("from", "re");
	    // 获取所有的建筑
	    // List<MeetingRoom2> mrs = meetingRoom2Dao.getParentRoom();
	    request.setAttribute("mrs", meetingRoomDao.getMeetingRoom());
	    request.setAttribute("meetings",
		    meetingDao.getMeetingByStatus("3", "1"));
	    return BASE_JSP + "meeting/meetingToAllot.jsp";
	} else {
	    error = "对不起，您没有重新分配会议室的权限！";
	    return toErrorPage(error);
	}
    }

    /**
     * 去修改会议
     * 
     * @Title: toUpdate
     * @return
     */
    public String toUpdate() {
	request.setAttribute("ctrl", "update");
	String id = request.getParameter("id");
	Meeting meeting = meetingDao.getMeetingById(id);
	request.setAttribute("meeting", meeting);
	request.setAttribute("title", "修改会议");
	getParameter("show");
	getParameter("url");
	// 得到公司领导
	List<Object> leaderList = jnpc.getLeaders();
	request.setAttribute("leaderList", leaderList);
	List<MeetingRoom> mrs = meetingRoomDao.getMeetingRoom();
	request.setAttribute("mrs", mrs);
	request.setAttribute("orgs", jnpc.getAllORG());
	request.setAttribute("mes", meetingExplainDao.getAllShow());
	return BASE_JSP + "meeting/meeting.jsp";
    }

    /**
     * 修改会议
     * 
     * @Title: update
     * @return
     */
    public String update() {
	int flag;
	String show = request.getParameter("show");
	String json = request.getParameter("json");
	Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm")
		.create();
	Meeting m = gson.fromJson(json, Meeting.class);
	Meeting oldm = meetingDao.getMeetAllById(m.getId());// 获取之前未修改所有信息..关联查出
	flag = meetingDao.meetingUpdate(m);// 更新
	if (flag != -1 && flag != -999 && flag != -99 && flag != -98) {
	    Meeting nw = meetingDao.getMeetAllById(m.getId());// 获取修改后所有信息
	    // return "redirect:" + url;
	    // String leader = m.getLeader();
	    // if (leader != null && !"".equals(leader)) {
	    // OutLook ol = new OutLook();
	    // ol.sendAppointment(m);
	    // } else {
	    // EmailSender es = new EmailSender();
	    // es.send(m);
	    // }
	    if (!isEmpty(oldm.getAddress1())) {
		String warning = compareM(oldm, nw);// 比较修改部分.
		if (!warning.equals("<br/><br/>")) {
		    EmailSender es = new EmailSender();
		    es.send(nw, warning);
		}
	    }
	    if ("my".endsWith(show)) {
		return listByDept();
	    } else {
		return list();
	    }

	} else if (flag == -99) {
	    error = "主持人在此时间段正参与其他会议，请检查！";
	} else if (flag == -98) {
	    error = "领导在此时间段正参与其他会议，请检查！";
	} else if (flag == -999) {
	    error = "已经存在一条相同的记录！";
	} else {
	    error = "";
	}
	return toErrorPage(error);
    }

    public String compareM(Meeting old, Meeting nw) {
	StringBuffer bf = new StringBuffer();
	try {
	    String oldstartTime = old.getStarttime() == null ? "" : DateUtil
		    .dateToString(old.getStarttime(), "YYYY-MM-dd HH:mm:ss");// 会议起始时间
	    String newstartTime = nw.getStarttime() == null ? "" : DateUtil
		    .dateToString(nw.getStarttime(), "YYYY-MM-dd HH:mm:ss");
	    String oldendTime = old.getEndtime() == null ? "" : DateUtil
		    .dateToString(old.getEndtime(), "YYYY-MM-dd HH:mm:ss");// 会议结束时间
	    String newendTime = nw.getEndtime() == null ? "" : DateUtil
		    .dateToString(nw.getEndtime(), "YYYY-MM-dd HH:mm:ss");
	    String oldcontent = old.getContent() == null ? "" : old
		    .getContent();// 会议内容
	    String newcontent = nw.getContent() == null ? "" : nw.getContent();
	    String oldleader = old.getLeader() == null ? "" : old.getLeader();// 参会领导
	    String newleader = nw.getLeader() == null ? "" : nw.getLeader();
	    String olddepart = old.getDepart() == null ? "" : old.getDepart();// 参会部门
	    String newdepart = nw.getDepart() == null ? "" : nw.getDepart();
	    String oldremark = old.getRemark() == null ? "" : old.getRemark();// 会议说明
	    String newremark = nw.getRemark() == null ? "" : nw.getRemark();
	    String oldpresider = old.getPresider() == null ? "" : old
		    .getPresider();// 会议主持人
	    String newpresider = nw.getPresider() == null ? "" : nw
		    .getPresider();
	    String oldcontact = old.getContact() == null ? "" : old
		    .getContact();// 联系人
	    String newcontact = nw.getContact() == null ? "" : nw.getContact();
	    String oldcontactphone = old.getContactphone() == null ? "" : old
		    .getContactphone();// 联系人电话
	    String newcontactphone = nw.getContactphone() == null ? "" : nw
		    .getContactphone();
	    String oldaddress = old.getAddress1() == null ? "" : old
		    .getAddress1();// 会议地址
	    String newaddress = nw.getAddress1() == null ? "" : nw
		    .getAddress1();
	    String oldfdepart = old.getFdepart() == null ? "" : old
		    .getFdepart();// 外部参会人员
	    String newfdepart = nw.getFdepart() == null ? "" : nw.getFdepart();
	    if (!oldleader.equals(newleader)) {
		bf.append("会议领导由原 " + oldleader + " 变更为 <font color=red >"
			+ newleader + "</font> <br/>");
	    }
	    if (oldstartTime != null && newstartTime != null
		    && !oldstartTime.equals(newstartTime)) {
		bf.append("会议开始时间由原 " + oldstartTime + " 变更为 <font color=red >"
			+ newstartTime + "</font> <br/>");
	    }
	    if (oldendTime != null && newendTime != null
		    && !oldendTime.equals(newendTime)) {
		bf.append("会议结束时间由原 " + oldendTime + " 变更为 <font color=red >"
			+ newendTime + "</font> <br/>");
	    }
	    if (!oldaddress.equals(newaddress)) {
		bf.append("会议地址由原 " + oldaddress + " 变更为 <font color=red >"
			+ newaddress + "</font> <br/>");
	    }
	    if (!olddepart.equals(newdepart)) {
		bf.append("参加会议部门/人员由原 " + olddepart + " 变更为 <font color=red >"
			+ newdepart + "</font> <br/>");
	    }
	    if (!oldfdepart.equals(newfdepart)) {
		bf.append("参加会议外部人员由原 " + oldfdepart + " 变更为 <font color=red >"
			+ newfdepart + "</font> <br/>");
	    }
	    if (!oldremark.equals(newremark)) {
		bf.append("会议说明由原 " + oldremark + " 变更为 <font color=red >"
			+ newremark + "</font> <br/>");
	    }
	    if (!oldpresider.equals(newpresider)) {
		bf.append("会议主持人由原 " + oldpresider + " 变更为 <font color=red >"
			+ newpresider + "</font> <br/>");
	    }
	    if (!oldcontactphone.equals(newcontactphone)) {
		bf.append("会议联系人电话由原 " + oldcontactphone
			+ " 变更为 <font color=red >" + newcontactphone
			+ "</font> <br/>");
	    }
	    if (!oldcontact.equals(newcontact)) {
		bf.append("会议联系人由原 " + oldcontact + " 变更为 <font color=red >"
			+ newcontact + "</font> <br/>");
	    }
	    if (!oldcontent.equals(newcontent)) {
		bf.append("会议内容由原 " + oldcontent + " 变更为 <font color=red >"
			+ newcontent + "</font> <br/>");
	    }
	    bf.append("<br/><br/>");
	    return bf.toString();
	} catch (Exception e) {
	    e.getCause();
	    e.getMessage();
	} finally {
	    return bf.toString();
	}
    }

    public String roomDetail() {
	String roomid = getParameter("roomid");

	String starttime = request.getParameter("starttime");
	String endtime = request.getParameter("endtim");
	List<Meeting> meetings = new ArrayList<Meeting>();
	MeetingRoom meetingRoom = new MeetingRoom();
	int i = 0;
	if (isEmpty(starttime)) {
	    // starttime = DateUtil.getCurrentDate("yyyy-MM-dd HH:mm:ss");
	    i++;
	}
	if (isEmpty(endtime)) {
	    // endtime = DateUtil.dateToString(DateUtil.addDay(new Date(), 7),
	    // "yyyy-MM-dd");
	    i++;
	}
	if (isEmpty(roomid)) {
	    i++;
	} else {
	    meetingRoom = meetingDao.getMeetingRoomById(roomid);
	}
	if (!(i > 0)) {
	    meetings = meetingDao.getMeetingByRoomAndTime(roomid, starttime,
		    endtime);
	}
	request.setAttribute("meetings", meetings);
	request.setAttribute("mr", meetingRoom);
	return BASE_JSP + "meetingRoom/roomDetail.jsp";
    }

    // /**
    // * 没有发送提醒的会议
    // *
    // * @Title: alert
    // * @return
    // */
    // public String noAlert() {
    // if (vec.contains("380301")) {
    //
    // String pageNo = request.getParameter("pageNo");
    // if (pageNo == null || "".equals(pageNo)) {
    // page.setPageNo(1);
    // } else {
    // page.setPageNo(Integer.parseInt(pageNo));
    // }
    // request.setAttribute("title", "领导参会一览");
    // page.setForwordName("MeetingServlet?ctrl=noAlert&pageNo=");
    // page = meetingDao.getMeetingOfLeaderAttend(page, "3");
    // request.setAttribute("meetins", page.getResult());
    // request.setAttribute("tag", page.getTag());
    // return BASE_JSP + "meeting/alert.jsp";
    // } else {
    // error = "您没有发送提醒的权限";
    // return toErrorPage(error);
    // }
    // }
    //
    // /**
    // * 发送了提醒的会议
    // *
    // * @Title: alert
    // * @return
    // */
    // public String alerted() {
    // if (vec.contains("380301")) {
    // String pageNo = request.getParameter("pageNo");
    // if (pageNo == null || "".equals(pageNo)) {
    // page.setPageNo(1);
    // } else {
    // page.setPageNo(Integer.parseInt(pageNo));
    // }
    // request.setAttribute("title", "领导参会一览");
    // page.setForwordName("MeetingServlet?ctrl=noAlert&pageNo=");
    // page = meetingDao.getMeetingOfLeaderAttend(page, "5");
    // request.setAttribute("tag", page.getTag());
    // return BASE_JSP + "meeting/alert.jsp";
    // } else {
    // error = "您没有发送提醒的权限";
    // return toErrorPage(error);
    // }
    // }

    // /**
    // * 发送会议提醒
    // *
    // * @Title: alert
    // * @return
    // */
    // public String alert() {
    // String meetingid = request.getParameter("id");
    // OutLook ol = new OutLook();
    // Meeting meeting = meetingDao.getMeetingById(meetingid);
    // String leaders = meeting.getLeader();
    // if (leaders != null && !"".equals(leaders)) {
    // String[] lemails = leaders.split(",");
    //
    // // ol.sendAppointment(meeting, lemails);
    // return "";
    // } else {
    // error = "该会议没有领导参加！";
    // return toErrorPage(error);
    // }
    // }

}
