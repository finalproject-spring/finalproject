package com.spring.recycle.model.dto;

import java.util.Date;

public class MessageDto {
	
	private int message_no;
	private String message_sendid;
	private String message_recvid;
	private String message_content;
	private Date message_senddate;
	private Date message_readdate;
	
	
	public MessageDto() {
	}

	public MessageDto(int message_no, String message_sendid, String message_recvid, String message_content,
			Date message_senddate, Date message_readdate) {
		this.message_no = message_no;
		this.message_sendid = message_sendid;
		this.message_recvid = message_recvid;
		this.message_content = message_content;
		this.message_senddate = message_senddate;
		this.message_readdate = message_readdate;
	}

	public int getMessage_no() {
		return message_no;
	}

	public void setMessage_no(int message_no) {
		this.message_no = message_no;
	}

	public String getMessage_sendid() {
		return message_sendid;
	}

	public void setMessage_sendid(String message_sendid) {
		this.message_sendid = message_sendid;
	}

	public String getMessage_recvid() {
		return message_recvid;
	}

	public void setMessage_recvid(String message_recvid) {
		this.message_recvid = message_recvid;
	}

	public String getMessage_content() {
		return message_content;
	}

	public void setMessage_content(String message_content) {
		this.message_content = message_content;
	}

	public Date getMessage_senddate() {
		return message_senddate;
	}

	public void setMessage_senddate(Date message_senddate) {
		this.message_senddate = message_senddate;
	}

	public Date getMessage_readdate() {
		return message_readdate;
	}

	public void setMessage_readdate(Date message_readdate) {
		this.message_readdate = message_readdate;
	}

	@Override
	public String toString() {
		return "MessageDto [message_no=" + message_no + ", message_sendid=" + message_sendid + ", message_recvid="
				+ message_recvid + ", message_content=" + message_content + ", message_senddate=" + message_senddate
				+ ", message_readdate=" + message_readdate + "]";
	}

	
}
