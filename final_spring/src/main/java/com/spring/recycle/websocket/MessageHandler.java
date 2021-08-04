package com.spring.recycle.websocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.spring.recycle.model.biz.MemberBiz;
import com.spring.recycle.model.biz.MessageBiz;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.MessageDto;

public class MessageHandler extends TextWebSocketHandler {
	
	private Logger logger = LoggerFactory.getLogger(MessageHandler.class);
	
	@Autowired
	private MessageBiz biz;
	
	@Autowired
	private MemberBiz membiz;
	
	//로그인 한 전체
	private List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	// 로그인중인 개별유저
	private Map<String, WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();
	
	// 클라이언트가 서버로 연결시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		String member_id = getMemberId(session);
		sessions.add(session);
       
		if(member_id != null) {
			logger.info(member_id + " : 연결 됨");
			users.put(member_id, session);   // 로그인중 개별유저 저장
			session.sendMessage(new TextMessage("msgNum :"+biz.unreadMsgCount(member_id)));
		}
	}
	// 클라이언트가 Data 전송 시
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String member_id = getMemberId(session);
		List<MemberDto> list = membiz.memberList();
		MessageDto dto = new MessageDto();
		
		if(member_id != null) {
			// 전체 쪽지
			if(message.getPayload().split(",")[0].equals("all")) {
				String content = message.getPayload().split(",")[1];
				for (int i = 0; i <list.size(); i++) {
					if(!list.get(i).getMember_id().equals("admin")) {
						String recvid = list.get(i).getMember_id();
						dto.setMessage_sendid("admin");
						dto.setMessage_content(content);
						dto.setMessage_recvid(recvid);
						
						biz.insertRecvMessage(dto);
						biz.insertSendMessage(dto);
						
						String msgNum = biz.unreadMsgCount(recvid);
						
						if (users.containsKey(recvid)) {
							TextMessage recvmsg = new TextMessage("msgNum :" + msgNum);
							users.get(recvid).sendMessage(recvmsg);
						
						}
					}
				}
				
			} else {
				String recvid = message.getPayload().split(",")[0];
				String content = message.getPayload().split(",")[1];
				
				dto.setMessage_recvid(recvid);
				dto.setMessage_sendid(member_id);
				dto.setMessage_content(content);
				
				biz.insertRecvMessage(dto);
				biz.insertSendMessage(dto);
				
				String msgNum = biz.unreadMsgCount(recvid);
				
				
				if (users.containsKey(recvid)) {
					TextMessage recvmsg = new TextMessage("msgNum :" + msgNum);
					users.get(recvid).sendMessage(recvmsg);
				}
			}
		}
	
        for(WebSocketSession sess: sessions) {
        	if(member_id != null) {
        		sess.sendMessage(new TextMessage(member_id+" :"+message.getPayload()));
        	}
        }

	}
	// 연결 해제될 때
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		String member_id = getMemberId(session);
		if(member_id != null) {	// 로그인 값이 있는 경우만
			logger.info(member_id + " 연결 종료됨");
			users.remove(member_id);
			sessions.remove(session);
		}
	}
	// 에러 발생시
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		logger.info(session.getId() + " 익셉션 발생: " + exception.getMessage());

	}
	
    // 접속한 유저의 http세션을 조회하여 id를 얻는 함수
	private String getMemberId(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		MemberDto dto = (MemberDto) httpSession.get("dto");
		if (dto != null) {
			String member_id = dto.getMember_id();
			return member_id;
		}
		return null;
	}

}
