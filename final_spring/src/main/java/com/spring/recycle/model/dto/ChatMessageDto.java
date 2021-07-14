package com.spring.recycle.model.dto;

import java.util.Date;

public class ChatMessageDto {
	private int chat_no;
	private int room_no;
	private String chat_id;
	private String message;
	private Date send_date;
	
	public ChatMessageDto() {}
	public ChatMessageDto(int chat_no, int room_no, String chat_id, String message, Date send_date) {
		this.chat_no = chat_no;
		this.room_no = room_no;
		this.chat_id = chat_id;
		this.message = message;
		this.send_date = send_date;
	}
	public int getChat_no() {
		return chat_no;
	}
	public void setChat_no(int chat_no) {
		this.chat_no = chat_no;
	}
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public String getChat_id() {
		return chat_id;
	}
	public void setChat_id(String chat_id) {
		this.chat_id = chat_id;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Date getSend_date() {
		return send_date;
	}
	public void setSend_date(Date send_date) {
		this.send_date = send_date;
	}
}
