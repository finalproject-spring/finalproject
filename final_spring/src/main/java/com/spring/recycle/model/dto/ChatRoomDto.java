package com.spring.recycle.model.dto;

import java.util.Date;

public class ChatRoomDto {
	private int room_no;
	private String room_name;
	private Date create_date;
	private String creator_name;
	private String creator_id;
	private int board_no;
	
	public ChatRoomDto() {}
	public ChatRoomDto(int room_no, String room_name, Date create_date, String creator_name, String creator_id, int board_no) {
		this.room_no = room_no;
		this.room_name = room_name;
		this.create_date = create_date;
		this.creator_name = creator_name;
		this.creator_id = creator_id;
		this.board_no = board_no;
	}
	public int getRoom_no() {
		return room_no;
	}
	public void setRoom_no(int room_no) {
		this.room_no = room_no;
	}
	public String getRoom_name() {
		return room_name;
	}
	public void setRoom_name(String room_name) {
		this.room_name = room_name;
	}
	public Date getCreate_date() {
		return create_date;
	}
	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}
	public String getCreator_name() {
		return creator_name;
	}
	public void setCreator_name(String creator_name) {
		this.creator_name = creator_name;
	}
	public String getCreator_id() {
		return creator_id;
	}
	public void setCreator_id(String creator_id) {
		this.creator_id = creator_id;
	}

	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	
}
