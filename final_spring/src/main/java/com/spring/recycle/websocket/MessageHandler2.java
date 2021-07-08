package com.spring.recycle.websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import com.spring.recycle.model.biz.MessageBiz;

public class MessageHandler2 extends TextWebSocketHandler {

	private Logger logger = LoggerFactory.getLogger(MessageHandler2.class);
	
	@ServerEndpoint(value="/wsMessage.do")
	public class WebSocketHandler {
	    private final Logger logger = LoggerFactory.getLogger(MessageHandler2.class);

		@Autowired
		private MessageBiz biz;
		
		// 로그인 한 전체
		private final List<WebSocketSession> sessions = new ArrayList<WebSocketSession>();
		
		// 로그인 중인 개별 유저
		private final Map<String, WebSocketSession> users = new HashMap<String, WebSocketSession>();
		
	    
	    public WebSocketHandler() {
	
	    }
	    
	    @OnOpen
	    public void onOpen(Session mySession) { // 내 세션을 가지고 세션 접속을 위해 옴!

	        logger.info("onOpen");
	  
	      
	    }
	    /*
	     * 보낸 세션과 dtoList를 비교하여 동일한 dto을 리턴
	     */

	    /*
	     * 모든 사용자에게 메시지를 전달한다.
	     * @param self
	     * @param sender
	     * @param message
	     */
	    // 메세지 보내는 함수

	    /*
	     * 내가 입력하는 메세지
	     * @param message
	     * @param session
	     */
	    @OnMessage
	    public void onMessage(String message, Session session) {
	      
	         logger.info("onMessage");
	       }
	    }
	    
	    @OnError
	    public void onError(Throwable e, Session session) {
	        logger.warn("에러 발생\n" + e.getMessage()); // 에러 발생시 알림용
	    }
	    
	    @OnClose
	    public void onClose(Session session) {
	    	logger.info("onClose");
	    }

	
}
