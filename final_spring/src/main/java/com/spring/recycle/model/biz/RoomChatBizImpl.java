package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.RoomChatDao;
import com.spring.recycle.model.dto.ChatMessageDto;
import com.spring.recycle.model.dto.ChatRoomDto;

@Service
public class RoomChatBizImpl implements RoomChatBiz {
	
	@Autowired
	private RoomChatDao dao;

	@Override
	public boolean insertChat(ChatMessageDto dto, String room_name) {
		if(dao.insertChat(dto, room_name) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public boolean insertRoom(ChatRoomDto dto) {
		if(dao.insertRoom(dto) == 1) {
			return true;
		}
		return false;
	}
	
	@Override
	public boolean deleteRoom(ChatRoomDto dto) {
		if(dao.deleteRoom(dto) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public List<ChatMessageDto> selectMessage(String room) {
		return dao.selectMessage(room);
	}

	@Override
	public List<ChatRoomDto> selectRoom(int board_no) {
		return dao.selectRoom(board_no);
	}

	@Override
	public List<ChatRoomDto> roomlist() {
		return dao.roomList();
	}


}
