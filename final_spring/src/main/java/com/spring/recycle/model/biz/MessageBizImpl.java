package com.spring.recycle.model.biz;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.MessageDao;
import com.spring.recycle.model.dto.MessageDto;

@Service
public class MessageBizImpl implements MessageBiz {

	@Autowired
	private MessageDao dao;

	@Override
	public int insertRecvMessage(MessageDto dto) {
		return dao.insertRecvMessage(dto);
	}

	@Override
	public int insertSendMessage(MessageDto dto) {
		return dao.insertSendMessage(dto);
	}

	@Override
	public String unreadMsgCount(String message_recvid) {
		return dao.unreadMsgCount(message_recvid);
	}

	@Override
	public MessageDto recvDetail(int message_no) {
		return dao.recvDetail(message_no);
	}

	@Override
	public MessageDto sendDetail(int message_no) {
		return dao.sendDetail(message_no);
	}

	@Override
	public int updateMessage(int message_no) {
		
		return dao.updateMessage(message_no);
	}

	@Override
	public int deleteRecvMessage(int message_no) {
		return dao.deleteRecvMessage(message_no);
	}

	@Override
	public int deleteSendMessage(int message_no) {
		return dao.deleteSendMessage(message_no);
	}

	@Override
	public List<MessageDto> getRecvMessagelist(HashMap<String, Object> map) {
		return dao.getRecvMessagelist(map);
	}

	@Override
	public List<MessageDto> getSendMessagelist(HashMap<String, Object> map) {
		return dao.getSendMessagelist(map);
	}

	@Override
	public int recvListCount(String message_recvid) {
		return dao.recvListCount(message_recvid);
	}

	@Override
	public int sendListCount(String message_sendid) {
		return dao.sendListCount(message_sendid);
	}

	@Override
	public int idCheck(String member_id) {
		return dao.idCheck(member_id);
	}

	@Override
	public int MultiDeleteRecvMessage(int[] message_noList) {
		return dao.MultiDeleteRecvMessage(message_noList);
	}

	@Override
	public int MultiDeleteSendMessage(int[] message_noList) {
		return dao.MultiDeleteSendMessage(message_noList);
	}


}
