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

import com.spring.recycle.model.biz.MessageBiz;
import com.spring.recycle.model.dto.MemberDto;

public class MessageHandler extends TextWebSocketHandler {
	
	// https://simsimjae.tistory.com/25
	// https://stothey0804.github.io/project/WebSocketExam/
	// https://hdhdeveloper.tistory.com/38
	private Logger logger = LoggerFactory.getLogger(MessageHandler.class);
	
	@Autowired
	private MessageBiz biz;
	
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
		
		String msg = message.getPayload();
		if(msg != null) {
			
		}
		//int result = biz.unreadMsgCount(member_id);
	
        for(WebSocketSession sess: sessions) {
            sess.sendMessage(new TextMessage(member_id+": "+message.getPayload()));
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
		MemberDto dto = (MemberDto) httpSession.get("dto"); // 세션에 저장된 m_id 기준 조회
		String member_id = dto.getMember_id();
		return member_id==null? null: member_id;
	}

}
