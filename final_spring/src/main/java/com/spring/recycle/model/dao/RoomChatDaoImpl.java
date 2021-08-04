package com.spring.recycle.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.ChatMessageDto;
import com.spring.recycle.model.dto.ChatRoomDto;

@Repository
public class RoomChatDaoImpl implements RoomChatDao {

	@Autowired
	private SqlSessionTemplate sqlSession; // sql 연결
	
	@Override
	public int insertChat(ChatMessageDto dto, String room_name) { // 채팅 기록하기
		int res = 0;
		try {
			dto.setRoom_no(sqlSession.selectOne(NAMESPACE + "getRoomId", room_name));
			res = sqlSession.insert(NAMESPACE + "insertChat", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int insertRoom(ChatRoomDto dto) { // 대화방 생성 전 id를 통해 name 획득 후 방 생성
		int res = 0;
		try {
			String creator_id = dto.getCreator_id();
			System.out.println(creator_id);
			dto.setCreator_name(sqlSession.selectOne(NAMESPACE + "getName", creator_id));
			if(sqlSession.selectOne(NAMESPACE + "checkRoom", dto.getRoom_name()) == null) { // checkRoom 으로 대화방 유무 체크
				res = sqlSession.insert(NAMESPACE + "insertRoom", dto);
			} else {
				LoggerFactory.getLogger(RoomChatDaoImpl.class).error("방 이름 중복으로 생성 실패");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int deleteRoom(ChatRoomDto dto) { // 대화방 삭제
		int res = 0;
		try {
			dto.setCreator_name(sqlSession.selectOne(NAMESPACE + "getName", dto.getCreator_id())); // id를 name으로 가져옴
			String room = sqlSession.selectOne(NAMESPACE + "CheckCreator", dto); // 방이 있는지 가져오기
			if(room != null) { // 방이 있다면 (null 할려고 String 로 받음)
				int room_no = Integer.parseInt(room); // string 를 int로 변경
				res = sqlSession.update(NAMESPACE + "deleteRoom", room_no); // 룸 번호 넘겨서 room_delete 1로 변경
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<ChatMessageDto> selectMessage(String room_name) { // 메세지 로그
		List<ChatMessageDto> res = null;
		try {
			int room_no = sqlSession.selectOne(NAMESPACE + "getRoomId", room_name);
			res = sqlSession.selectList(NAMESPACE + "selectChat", room_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<ChatRoomDto> selectRoom(int board_no) { // 대화방 목록
		List<ChatRoomDto> res = null;
		try {
			res = sqlSession.selectList(NAMESPACE + "selectRoom", board_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<ChatRoomDto> roomList() { // 대화방 목록
		List<ChatRoomDto> res = null;
		try {
			res = sqlSession.selectList(NAMESPACE + "roomList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

}
