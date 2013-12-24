package cn.com.jnpc.utils;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Vector;

import cn.com.jnpc.meeting.bean.Meeting;

public class MeetingDateUntils {
	private List[] vector = null;
	
	int dayNew = 1; //标记会议为新的时间（1天之内发布的会议为新）       

	//各种格式的日期
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd"); 		
	SimpleDateFormat sdfIntDate = new SimpleDateFormat("yyyyMMdd");
	//只有小时和分的时间格式，前面加年是为了避免小时只有一位时总位数变小
	SimpleDateFormat sdfTime = new SimpleDateFormat("yyyyHHmm");
	Calendar calendarNow = Calendar.getInstance();//获取当前时间       

		
	
    /**
     * 得到所有会议的日期分布
     * @param 
     * @return 
     */   
    public Vector getDate(List<Meeting> meeting){
    	//开始和结束时间的日历
		Calendar startC =  Calendar.getInstance();
		Calendar endC=   Calendar.getInstance();
		Vector sigleDayVct = new Vector();//会议分布的日期和不重复已排序的日期	
		Vector dayVct = new Vector();
		
		//遍历所有取出的会议，找出会议分布在哪些日期
		for (int i=0;i<meeting.size();i++){
						  
			//会议开始和结束时间，包括日期和时分     
			String  startTime = meeting.get(i).getStarttime().toString().substring(0,16);       
			String  endTime =  meeting.get(i).getEndtime().toString().substring(0,16);
			String  startDate = startTime.substring(0,10);			
   
			String startYear = startTime.substring(0,4);       
			String startMonth = startTime.substring(5,7);       
			String startDay = startTime.substring(8,10);
			String startHour = startTime.substring(11,13);
			String startMin = startTime.substring(14);

			String endYear = endTime.substring(0,4);       
			String endMonth = endTime.substring(5,7);       
			String endDay = endTime.substring(8,10);
			String endHour = endTime.substring(11,13);
			String endMin = endTime.substring(14);
	
			startC.set(Integer.parseInt(startYear),
						Integer.parseInt(startMonth)-1,
						Integer.parseInt(startDay),
						Integer.parseInt(startHour),
						Integer.parseInt(startMin) );				
			endC.set(Integer.parseInt(endYear),
						Integer.parseInt(endMonth)-1,
						Integer.parseInt(endDay),
						Integer.parseInt(endHour),
						Integer.parseInt(endMin) ); 
			//整数形式的日期，便于比较
			long startD = Long.parseLong(sdfIntDate.format(startC.getTime()));
		    long endD = Long.parseLong(sdfIntDate.format(endC.getTime()));
		    long nowD = Long.parseLong(sdfIntDate.format(calendarNow.getTime())); 			    
		    
//		    long endT = Long.parseLong(sdfTime.format(endC.getTime()));
//		    long nowT = Long.parseLong(sdfTime.format(calendarNow.getTime()));
		   //会议一天开完，直接在dayVct 中增加一项这一日期，否则即跨天的会议每一天都要显示
		    
	    	if(startD==endD ){//开始天=结束天 并且 开始时间小于=当前天
	    		dayVct.add(startDate);
	    	}else {							 //
	    		//从会议开始日期起，每一天都要加入到dayVct中，直到会议结束日期
	    		for(; startD<=endD;){//
	    			String thisDate = sdf.format(startC.getTime());
	    			dayVct.add(thisDate );	
	    			//将startC加一天，一直到和endC同一天，循环结束
	    			startC.set(	startC.get(Calendar.YEAR),startC.get(Calendar.MONTH),startC.get(Calendar.DAY_OF_MONTH)+1);
	    			startD = Long.parseLong(sdfIntDate.format(startC.getTime()));
	    		}
	    	}
		    
		}	
	
		//会议日期的两种格式，整数形式用来排序，字符格式用来显示 
		HashMap tempHm = new HashMap();
		
		//从所有的会议记录中提取会议的不重复日期
		for (int i=0;i<dayVct.size();i++){
			String str1 = dayVct.get(i).toString();
			Long intDay = Long.valueOf(str1.substring(0,4)+
					str1.substring(5,7)+str1.substring(8));
		    if(!tempHm.containsKey(intDay)){
		    	tempHm.put(intDay,dayVct.get(i));				
			}
		}	
		
		//对会议日期排序
		Object[] obj = tempHm.keySet().toArray();
		Arrays.sort(obj);
		//将已排序的日期存入变量
		for(int i=0;i<obj.length;i++){
			sigleDayVct.add(tempHm.get(obj[i]));
		}    	
		return sigleDayVct;
    }
    
    /**
     * 得到所有会议的最终显示内容
     * @param 
     * @return 
     */   
    public List[] analyzeMeeting(List<Meeting> meeting,Vector sigleDayVct){
    	String week = null;   	    //当天的星期
    	
    	String  isNew = null;       //会议是否标记为新
    	String  time = null;        //会议时间
    	String  content = null;     //会议名称
    	String  presider = null;    //会议主持人
    	String  remark = null;      //承办单位及说明
    	String  place = null;       //会议地点
    	String  conferee = null;    //参加部门、人员	
    	String  id=null;
    	
    	
    	//几个日历，分别用来表示现在的准确时刻、会议当天的星期、会议提交的时刻
    	Calendar cal = Calendar.getInstance();
    	Calendar calWeek = Calendar.getInstance();
    	Calendar calCommit = Calendar.getInstance();
    	//整数形式的日期和时间，便于比较
    	long nowIntDay = Long.parseLong(sdfIntDate.format(cal.getTime()));
    	long nowIntTime = Long.parseLong(sdfTime.format(cal.getTime()));
    	//有多少天有会议，这个数组就有几个元素，每个元素代表一天的会议信息
    	this.vector = new ArrayList[sigleDayVct.size()];
    	//逐天提取当天的会议信息
    	for(int d=0;d<sigleDayVct.size();d++){
    		//每天的会议信息存在一个Vector里面
    		vector[d] = new ArrayList(); 
    		String thisStringDay = sigleDayVct.get(d).toString();
    		long thisIntDay = Long.parseLong(thisStringDay.substring(0,4)+
    										 thisStringDay.substring(5,7)+
    										 thisStringDay.substring(8));
    		calWeek.set(Integer.parseInt(thisStringDay.substring(0,4)),
    					Integer.parseInt(thisStringDay.substring(5,7))-1,
    					Integer.parseInt(thisStringDay.substring(8))		);
    		week = this.getWeek(calWeek);
    		//前两个元素是String，分别代表当天的星期和日期
    		vector[d].add(week);
			vector[d].add(thisStringDay);
    		//后面的元素都是Vector，每一个Vector里面包含一条会议记录
    		for(int m=0;m<meeting.size();m++){
    			//会议开始和结束时间，包括日期和时分     
    			String startTime = meeting.get(m).getStarttime().toString().substring(0,16);       
    			String endTime = meeting.get(m).getEndtime().toString().substring(0,16);
    			String startDate =meeting.get(m).getStarttime().toString().substring(0,10);
    			String endDate = meeting.get(m).getEndtime().toString().substring(0,10);
    			//会议提交时间，根据会议提交的时间来判断是否为新
    			String commitTime = meeting.get(m).getCommittime().toString().substring(0,16);
    			calCommit.set(Integer.parseInt(commitTime.substring(0,4)),
    						  Integer.parseInt(commitTime.substring(5,7))-1,
    						  Integer.parseInt(commitTime.substring(8,10))+dayNew,
    						  Integer.parseInt(commitTime.substring(11,13)),
    						  Integer.parseInt(commitTime.substring(14))		);
    			if (calCommit.after(calendarNow))       
    				isNew = "T";       
				else       
					isNew = "F";     			
    			
    			long startIntDay = Long.parseLong(startDate.substring(0,4)+
    											  startDate.substring(5,7)+
    											  startDate.substring(8));
    			long endIntDay = Long.parseLong(endDate.substring(0,4)+
    											endDate.substring(5,7)+
    											endDate.substring(8));   

    			String endYear = endTime.substring(0,4); 
    			String endHour = endTime.substring(11,13);
    			String endMin = endTime.substring(14);
    			
    			if(startIntDay==endIntDay){
    				time = startTime.substring(11,16)+"--"+endTime.substring(11,16);
    			}else{
    				time = time=startTime.substring(2,16)+"<BR>"+endTime.substring(2,16);
    			} 
    			//对某些信息做为空判断
    		   	content = (meeting.get(m).getContent()==null? " ":meeting.get(m).getContent());           //会议名称
    	    	presider = (meeting.get(m).getPresider()==null? " ":meeting.get(m).getPresider());        //会议主持人
    	    	remark = (meeting.get(m).getRemark()==null? " ":meeting.get(m).getRemark());             //承办单位及说明
    	    	id = (meeting.get(m).getId()==null? " ":meeting.get(m).getId());             //id
    	    	
    	    	String building = (meeting.get(m).getAddress1()==null? " ":meeting.get(m).getAddress1());
    	    	//String room = (allMeeting[m][2]==null? " ":allMeeting[m][2]);
    	    	String leaders = (meeting.get(m).getLeader()==null? " ":(meeting.get(m).getLeader()+"<br>"));
    	    	String depart = (meeting.get(m).getDepart()==null? " ":meeting.get(m).getDepart());
    	    	//place = building+room;     //会议地点    	    	
    	    	conferee = leaders+','+depart; //参加部门、人员	
    			    			
    			long endIntTime = Long.parseLong(endYear+endHour+endMin);
    			
    			//当天在会议开始日期和结束日期之间，且会议到现在还没有结束，应该显示
    			if(startIntDay<=thisIntDay && thisIntDay<=endIntDay && 
        				(endIntDay<nowIntDay ||	(endIntDay==nowIntDay && endIntTime<nowIntTime))){
    				meeting.get(m).setDepart(conferee);
    				meeting.get(m).setReserve_address(time);
    				Meeting meetingnew=meeting.get(m);
    				vector[d].add(meetingnew);    				
    			}    			
    		}
    	}   	  
    	return vector;
    }    
  
    /**
     * 根据日期得到当天的星期
     * @param 
     * @return 
     */     
    public String getWeek(Calendar c){
    	int intWeek=c.get(7);  
		String wk = null;
		 switch (intWeek){       
				case 1:       
					wk="星期日";       
					break;       
				case 2:       
					wk="星期一";
					break;       
				case 3:       
					wk="星期二";       
					break;       
				case 4:       
					wk="星期三";       
					break;       
				case 5:       
					wk="星期四";       
					break;       
				case 6:       
					wk="星期五";       
					break;       
				case 7:       
					wk="星期六";       
					break;
		 }
		 return wk;
    }
    

}
