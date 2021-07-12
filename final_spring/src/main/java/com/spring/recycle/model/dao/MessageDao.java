package com.spring.recycle.model.dao;

import java.util.HashMap;
import java.util.List;

import com.spring.recycle.model.dto.MessageDto;

public interface MessageDao {
	
	String NAMESPACE = "message.";
	
	// public List<MessageDto> getRecvMessage(String message_recvid);
	public MessageDto recvDetail(int message_no);
	
	// public List<MessageDto> getSendMessage(String message_sendid);
	public MessageDto sendDetail(int message_no);
	
	public int insertRecvMessage(MessageDto dto);
	public int insertSendMessage(MessageDto dto);
	
	public String unreadMsgCount(String message_recvid);
	
	public int updateMessage(int message_no);
	
	// 받은 쪽지 다중 삭제 (수신)
	public int MultiDeleteRecvMessage(int[] message_noList);
	// 받은 쪽지 다중 삭제 (발신)
	public int MultiDeleteSendMessage(int[] message_noList);

	// 받은 쪽지 삭제 (수신)
	public int deleteRecvMessage(int message_no);
	// 받은 쪽지 삭제 (발신)
	public int deleteSendMessage(int message_no);
	
	// 받은 쪽지함 목록 & 페이징
	public List<MessageDto> getRecvMessagelist(HashMap<String, Object> map);

	// 보낸 쪽지함 목록 & 페이징
	public List<MessageDto> getSendMessagelist(HashMap<String, Object> map);
	
	// 게시물 총 개수(받은 메세지함)
	public int recvListCount(String message_recvid);
	
	// 게시물 총 개수(보낸 메세지함)
	public int sendListCount(String message_sendid);
	
	// 유저 ID 존재유무 체크
	public int idCheck(String member_id);

}
