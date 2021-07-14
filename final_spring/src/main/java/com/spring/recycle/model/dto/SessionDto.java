package com.spring.recycle.model.dto;

import javax.websocket.Session;

public class SessionDto {

	private String room;
	private String id;
	private Session session;
	public SessionDto() {
		
	}
	public SessionDto(String room, String id, Session session) {
		this.room = room;
		this.id = id;
		this.session = session;
	}
	public String getRoom() {
		return room;
	}
	public void setRoom(String room) {
		this.room = room;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Session getSession() {
		return session;
	}
	public void setSession(Session session) {
		this.session = session;
	}
	
}
