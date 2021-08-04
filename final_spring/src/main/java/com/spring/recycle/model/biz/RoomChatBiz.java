package com.spring.recycle.model.biz;

import java.util.List;

import com.spring.recycle.model.dto.ChatMessageDto;
import com.spring.recycle.model.dto.ChatRoomDto;

public interface RoomChatBiz {
	
	public boolean insertChat(ChatMessageDto dto, String room_name);
	public boolean insertRoom(ChatRoomDto dto);
	public boolean deleteRoom(ChatRoomDto dto);
	
	public List<ChatMessageDto> selectMessage(String room);
	public List<ChatRoomDto> selectRoom(int board_no);
	public List<ChatRoomDto> roomlist();
}
