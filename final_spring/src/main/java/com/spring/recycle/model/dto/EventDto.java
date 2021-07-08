package com.spring.recycle.model.dto;

public class EventDto {
	/*
	 * 
	 * CREATE SEQUENCE EVENTSEQ;
	CREATE TABLE EVENT(
	EVENT_NO NUMBER PRIMARY KEY,
	EVENT_TITLE VARCHAR2(50) NOT NULL,
	EVENT_CONTENT LONG NOT NULL,
	EVENT_START VARCHAR2(50) NOT NULL,
	EVENT_END VARCHAR2(50) NOT NULL
); 
	 */
	
	private int event_no;
	private String event_title;
	private String event_content;
	private String event_start;
	private String event_end;
	
	
	
	public EventDto() {
		super();
	}



	public EventDto(int event_no, String event_title, String event_content, String event_start, String event_end) {
		super();
		this.event_no = event_no;
		this.event_title = event_title;
		this.event_content = event_content;
		this.event_start = event_start;
		this.event_end = event_end;
	}



	public int getEvent_no() {
		return event_no;
	}



	public void setEvent_no(int event_no) {
		this.event_no = event_no;
	}



	public String getEvent_title() {
		return event_title;
	}



	public void setEvent_title(String event_title) {
		this.event_title = event_title;
	}



	public String getEvent_content() {
		return event_content;
	}



	public void setEvent_content(String event_content) {
		this.event_content = event_content;
	}



	public String getEvent_start() {
		return event_start;
	}



	public void setEvent_start(String event_start) {
		this.event_start = event_start;
	}



	public String getEvent_end() {
		return event_end;
	}



	public void setEvent_end(String event_end) {
		this.event_end = event_end;
	}
	
	
	
	
}
