package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.ChatMessageDto;
import com.spring.recycle.model.dto.ChatRoomDto;

public interface RoomChatDao {

	String NAMESPACE = "RoomChat.";
	
	public int insertChat(ChatMessageDto dto, String room_name);
	public int insertRoom(ChatRoomDto dto);
	public int deleteRoom(ChatRoomDto dto);
	
	public List<ChatMessageDto> selectMessage(String room_name);
	public List<ChatRoomDto> selectRoom(int board_no);
	public List<ChatRoomDto> roomList();
}
