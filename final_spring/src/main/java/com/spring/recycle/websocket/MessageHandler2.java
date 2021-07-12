package com.spring.recycle.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.spring.recycle.model.biz.MessageBiz;
import com.spring.recycle.model.dto.MessageDto;

public class MessageHandler2 extends TextWebSocketHandler {

	private Logger logger = LoggerFactory.getLogger(MessageHandler2.class);
	
	@Autowired
	private MessageBiz biz;
	
	// 로그인 한 전체
	List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
	
	// 로그인 중인 개별 유저
	private static Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
	
	// https://bloodfinger.tistory.com/40
    // https://javaengine.tistory.com/entry/%EC%9B%B9-%EC%86%8C%EC%BC%93spring%EC%9D%84-%EC%9D%B4%EC%9A%A9%ED%95%9C-%EC%B1%84%ED%8C%85-1

	
	// 클라이언트와 웹소켓이 연결되고 실행되는 메소드, 서버 접속 성공
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        logger.info("연결 됨!");
    	String member_id = getMemberid(session);
        if(member_id!=null) {
        	logger.info(member_id + "연결 됨!");
        	users.put(member_id, session); // 로그인 중인 개별유저 저장
        }
    }
     
 	
     private String getMemberid(WebSocketSession session) {
		Map<String, Object> httpSession = session.getAttributes();
		String member_id = (String) httpSession.get("member_id");
		return member_id==null? null: member_id;
	}


	// 클라이언트가 웹소켓서버로 메시지를 전송했을 때 실행되는 메소드
     @Override
 	 protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
    	 String member_id = getMemberid(session);
    	 String msg = message.getPayload();
    	 
    	// 로그인 시 실행
 		if (message.getPayload().equals("login")) {
 			
 			// 받은 쪽지 중 읽지 않은 쪽지 개수
 			int result = biz.unreadMsgCount(member_id);

 			// 사용자 아이디값이 소켓 접속시 users에 넣은 아이디값이 존재하는지 비교
 			if (users.containsKey(member_id)) {
 				// TextMessage객체를 생성해서 클라이언트에 전송할 텍스트 생성
 				TextMessage countmsg = new TextMessage("" + result + "");
 				users.get(member_id).sendMessage(countmsg);
 				// 키값을 통해 사용자한테 부여한 세션값 추출 후 메시지 전송
 			}
 		} else { // 쪽지 보냈을때 탐(message.jsp에서 데이터 전송받음) / 1:1쪽지

 			String recvid = message.getPayload().split(",")[0];
 			String content = message.getPayload().split(",")[1];

 			MessageDto dto = new MessageDto();
 			dto.setMessage_recvid(recvid);
 			dto.setMessage_sendid(member_id); // 발신인
 			dto.setMessage_content(content);

 			int res1 = biz.insertRecvMessage(dto);
 			int res2 = biz.insertSendMessage(dto);

 			// ★★★쪽지 테이블에 보낸 쪽지 데이터 삽입
 			int result = biz.unreadMsgCount(recvid);
 			// 수신인이 받은 문자 개수 추출
// 			if (member_id.containsKey(recvid)) {
 //				TextMessage msg = new TextMessage("" + result + "");
 	//			member.get(recvid).sendMessage(msg);

 				// ★★★ 키값을 통해 사용자한테 부여한 세션값 추출 후 메시지 전송
		}
	}

 	
 	// 연결해제
 	@Override
 	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
 		String member_id = getMemberid(session);
 		if (member_id != null) { // 로그인 값이 있는 경우만
 			logger.info(member_id + " 연결 종료됨");
 			users.remove(session.getId());
 			sessions.remove(session);
 		}
 	}
	// 에러 발생시 
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		logger.info(session.getId() + " 익셉션 발생 : " + exception.getMessage());
	}
}
