package com.sara.base.to;

import java.util.ArrayList;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EventBean {
	private String title,allDay,start,end;
	private ArrayList<BaseBean> properties;
	
	String ALL_DAY_REGEX = "^((19|20)\\d\\d)?([- /.])?(0[1-9]|1[012])([- /.])?(0[1-9]|[12][0-9]|3[01])$";
	Pattern pattern =  Pattern.compile(ALL_DAY_REGEX);
    Matcher matcher = pattern.matcher(this.getStart());
	
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAllDay() {
		return allDay;
	}
	public void setAllDay(String allDay) {
		this.allDay = allDay;
	}
	public String getStart() {
		return start;
	}
	public void setStart(String start) {
		this.start = start;
	}
	public String getEnd() {
		return end;
	}
	public void setEnd(String end) {
		this.end = end;
	}
	public ArrayList<BaseBean> getProperties() {
		return properties;
	}
	public void setProperties(ArrayList<BaseBean> properties) {
		this.properties = properties;
	}
	
	
	
	

}
