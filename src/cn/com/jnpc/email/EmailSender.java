package cn.com.jnpc.email;

import org.apache.commons.mail.HtmlEmail;

import cn.com.jnpc.meeting.bean.Meeting;
import cn.com.jnpc.utils.DateUtil;

public class EmailSender {

	public void send(String emailTo, Meeting meeting, String type) {
		HtmlEmail email = new HtmlEmail();
		email.setHostName(EmailConfigReader.getHost());
		email.setAuthentication(EmailConfigReader.getUsername(),
				EmailConfigReader.getPassword());
		email.setDebug(EmailConfigReader.getDebug());
		try {
			StringBuilder sb = new StringBuilder();
			if ("4".equals(type)) {
				email.setCharset("utf-8");
				email.setFrom(EmailConfigReader.getFromAddress());
				email.addTo(emailTo);
				email.setSubject("培训申请退回");
				sb.append("<div align='center'>");
				sb.append("<table > ");
				sb.append("<tr align='center'><td align='right'>培训课程名称：</td><td align='left'>");
				sb.append(meeting.getContent());
				sb.append("</td></tr>");
				sb.append("<tr align='center'><td align='right'>培训申请地点：</td><td align='left'>");
				sb.append(meeting.getRoomid());
				sb.append("</td></tr>");
				sb.append("<tr align='center'><td align='right'>培训申请时间：</td><td align='left'>");
				sb.append(meeting.getStarttime() + "至" + meeting.getEndtime());
				sb.append("</td></tr>");
				sb.append("<tr align='center'><td align='right'>培训课程内容：</td><td align='left'>");
				sb.append(meeting.getContent());
				sb.append("</td></tr>");
				sb.append("</td></tr>");
				// sb.append
				// ("<tr align='center'><td align='right'>参会领导：</td><td align='left'>");
				// sb.append (meeting.getLeader ());
				// sb.append ("</td></tr>");
				sb.append("<tr align='center'><td align='right'>参加培训人员：</td><td align='left'>");
				sb.append(meeting.getDepart());
				sb.append("</td></tr>");
				sb.append("</table>");
				sb.append("<p>您申请的培训申请被退回！如有疑问请联系");
				sb.append(EmailConfigReader.getContact1());
				sb.append("&nbsp;电话:");
				sb.append(EmailConfigReader.getPhone1());
				sb.append("&nbsp;电子邮件:");
				sb.append("<a href='mailto:" + EmailConfigReader.getEmail1()
						+ "'>" + EmailConfigReader.getEmail1() + "</a>");
			} else {
				email.setCharset("utf-8");
				email.setFrom(EmailConfigReader.getFromAddress());
				email.addTo(emailTo);
				email.setSubject("会议申请退回");
				sb.append("<div align='center'>");
				sb.append("<table > <tr align='center'><tr><th colspan='2'>");
				sb.append(meeting.getContent());
				sb.append("</th></tr>");
				sb.append("<tr align='center'><td align='right'>会议地点：</td><td align='left'>");
				sb.append(meeting.getRoomid());
				sb.append("</td></tr>");
				sb.append("<tr align='center'><td align='right'>会议时间：</td><td align='left'>");
				sb.append(meeting.getStarttime() + "至" + meeting.getEndtime());
				sb.append("</td></tr>");
				sb.append("<tr align='center'><td align='right'>会议内容：</td><td align='left'>");
				sb.append(meeting.getContent());
				sb.append("</td></tr>");
				sb.append("</td></tr>");
				sb.append("<tr align='center'><td align='right'>参会领导：</td><td align='left'>");
				sb.append(meeting.getLeader());
				sb.append("</td></tr>");
				sb.append("<tr align='center'><td align='right'>参会人员：</td><td align='left'>");
				sb.append(meeting.getDepart());
				sb.append("</td></tr>");
				sb.append("</table>");
				sb.append("<p>您申请的会议申请被退回！如有疑问请联系");
				sb.append(EmailConfigReader.getContact());
				sb.append("&nbsp;电话:");
				sb.append(EmailConfigReader.getPhone());
				sb.append("&nbsp;电子邮件:");
				sb.append("<a href='mailto:" + EmailConfigReader.getEmail()
						+ "'>" + EmailConfigReader.getEmail() + "</a>");
			}
			sb.append(".</p></div>");
			email.setHtmlMsg(sb.toString());
			email.send();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	public void send(Meeting meeting, String warning,HtmlEmail email) {
		
		email.setHostName(EmailConfigReader.getHost());
		email.setDebug(EmailConfigReader.getDebug());
		email.setAuthentication(EmailConfigReader.getUsername(),
				EmailConfigReader.getPassword());
		try {
			email.setCharset("utf-8");
			email.setFrom(EmailConfigReader.getFromAddress());
			email.addTo(EmailConfigReader.getEmail());
			//email.addTo("chencheng_asj@jnpc.com.cn");
			if(email.getSubject()==null || email.getSubject().equals("")){
				email.setSubject(meeting.getContent());
			}
			StringBuilder sb = new StringBuilder();
			sb.append(warning);
			sb.append("以下是最新会议内容:");
			sb.append("<div>");
			sb.append("<table > <tr align='center'><tr><th colspan='2'>");
			sb.append(meeting.getContent()==null?"":meeting.getContent());
			sb.append("</th></tr>");
			if(meeting.getAddress1()!=null && !meeting.getAddress1().equals("")){
				sb.append("<tr align='center'><td align='right'>会议地点：</td><td align='left'>");
				sb.append(meeting.getAddress1()==null?"":meeting.getAddress1());
				sb.append("</td></tr>");
			}else{
				sb.append("<tr align='center'><td align='right'>预定会议室：</td><td align='left'>");
				sb.append(meeting.getAddress()==null?"":meeting.getAddress());
				sb.append("</td></tr>");
			}
			sb.append("<tr align='center'><td align='right'>会议时间：</td><td align='left'>");
			sb.append(DateUtil.dateToString(meeting.getStarttime(),
					"yyyy-MM-dd HH:mm:ss")
					+ " 至 "
					+ DateUtil.dateToString(meeting.getEndtime(),
							"yyyy-MM-dd HH:mm:ss"));
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>会议内容：</td><td align='left'>");
			sb.append(meeting.getContent()==null?"":meeting.getContent());
			sb.append("</td></tr>");
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>参会领导：</td><td align='left'>");
			sb.append(meeting.getLeader()==null?"":meeting.getLeader());
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>内部参会人员：</td><td align='left'>");
			sb.append(meeting.getDepart()==null?"":meeting.getDepart());
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>外部参会人员：</td><td align='left'>");
			sb.append(meeting.getFdepart()==null?"":meeting.getFdepart());
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>参会说明：</td><td align='left'>");
			sb.append(meeting.getRemark()==null?"":meeting.getRemark());
			sb.append("</td></tr>");
			sb.append("</table></div>");
			sb.append("<br/><font color=red>请以最新会议内容为准.</font><br/><br/>");
			// System.out.println(sb.toString());
			email.setHtmlMsg(sb.toString());
			email.send();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	public void send(Meeting meeting,HtmlEmail email) {
		
		email.setHostName(EmailConfigReader.getHost());
		email.setDebug(EmailConfigReader.getDebug());
		email.setAuthentication(EmailConfigReader.getUsername(),
				EmailConfigReader.getPassword());
		try {
			email.setCharset("utf-8");
			email.setFrom(EmailConfigReader.getFromAddress());
			email.addTo(EmailConfigReader.getEmail());
			//email.addTo("chencheng_asj@jnpc.com.cn");
			if(email.getSubject()==null || email.getSubject().equals("")){
				email.setSubject(meeting.getContent());
			}
			StringBuilder sb = new StringBuilder();
			
			sb.append("会议删除:");
			sb.append("<div>");
			sb.append("<table > <tr align='center'><tr><th colspan='2'>");
			sb.append(meeting.getContent()==null?"":meeting.getContent());
			sb.append("</th></tr>");
			if(meeting.getAddress1()!=null && !meeting.getAddress1().equals("")){
				sb.append("<tr align='center'><td align='right'>会议地点：</td><td align='left'>");
				sb.append(meeting.getAddress1()==null?"":meeting.getAddress1());
				sb.append("</td></tr>");
			}else{
				sb.append("<tr align='center'><td align='right'>预定会议室：</td><td align='left'>");
				sb.append(meeting.getAddress()==null?"":meeting.getAddress());
				sb.append("</td></tr>");
			}
			sb.append("<tr align='center'><td align='right'>会议时间：</td><td align='left'>");
			sb.append(DateUtil.dateToString(meeting.getStarttime(),
					"yyyy-MM-dd HH:mm:ss")
					+ " 至 "
					+ DateUtil.dateToString(meeting.getEndtime(),
							"yyyy-MM-dd HH:mm:ss"));
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>会议内容：</td><td align='left'>");
			sb.append(meeting.getContent()==null?"":meeting.getContent());
			sb.append("</td></tr>");
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>参会领导：</td><td align='left'>");
			sb.append(meeting.getLeader()==null?"":meeting.getLeader());
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>内部参会人员：</td><td align='left'>");
			sb.append(meeting.getDepart()==null?"":meeting.getDepart());
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>外部参会人员：</td><td align='left'>");
			sb.append(meeting.getFdepart()==null?"":meeting.getFdepart());
			sb.append("</td></tr>");
			sb.append("<tr align='center'><td align='right'>参会说明：</td><td align='left'>");
			sb.append(meeting.getRemark()==null?"":meeting.getRemark());
			sb.append("</td></tr>");
			sb.append("</table></div>");
			sb.append("<br/><font color=red>该会议已删除.</font><br/><br/>");
			// System.out.println(sb.toString());
			email.setHtmlMsg(sb.toString());
			email.send();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
