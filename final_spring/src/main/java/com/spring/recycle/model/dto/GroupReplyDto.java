package com.spring.recycle.model.dto;

import java.util.Date;

public class GroupReplyDto {
	
	/*
	CREATE SEQUENCE REPLYSEQ;
	CREATE TABLE REPLY(
    REPLY_NO NUMBER NOT NULL PRIMARY KEY,                                 
    BOARD_NO NUMBER NOT NULL,              
    BOARD_CATEGORY VARCHAR2(30) NOT NULL CHECK (BOARD_CATEGORY IN ('정보안내', '소모임', '공지문의', '상품판매', '상품후기')), 
    REPLY_ID VARCHAR2(20) NOT NULL,     
    REPLY_CONTENT VARCHAR2(1000) NOT NULL,                                 
    REPLY_DATE DATE NOT NULL,
    CONSTRAINT REPLY_FK1 FOREIGN KEY(BOARD_NO) REFERENCES BOARD(BOARD_NO) ON DELETE CASCADE,
    CONSTRAINT REPLY_FK2 FOREIGN KEY(REPLY_ID) REFERENCES MEMBER(MEMBER_ID) ON DELETE CASCADE
);
	 */
	
	private int board_no;
	private int reply_no;
	private String reply_content;
	private String reply_id;
	private Date reply_date;
		
	public GroupReplyDto() {
		super();
	}

	public GroupReplyDto(int board_no, int reply_no, String reply_content, String reply_id, Date reply_date) {
		super();
		this.board_no = board_no;
		this.reply_no = reply_no;
		this.reply_content = reply_content;
		this.reply_id = reply_id;
		this.reply_date = reply_date;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public int getReply_no() {
		return reply_no;
	}

	public void setReply_no(int reply_no) {
		this.reply_no = reply_no;
	}

	public String getReply_content() {
		return reply_content;
	}

	public void setReply_content(String reply_content) {
		this.reply_content = reply_content;
	}

	public String getReply_id() {
		return reply_id;
	}

	public void setReply_id(String reply_id) {
		this.reply_id = reply_id;
	}

	public Date getReply_date() {
		return reply_date;
	}

	public void setReply_date(Date reply_date) {
		this.reply_date = reply_date;
	}
	
	
	
	
	
	

}
