package com.spring.recycle.RoomChatHandler;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
//import java.net.URI;
import java.util.ArrayList;
//import java.util.HashMap;
import java.util.List;
//import java.util.Map;

//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
//import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
//import org.springframework.stereotype.Controller;

import com.spring.recycle.model.dao.RoomChatDaoImpl;
import com.spring.recycle.model.dto.ChatMessageDto;
import com.spring.recycle.model.dto.SessionDto;


@ServerEndpoint(value="/roomChat.do")
public class RoomChatHandler {
    private static final Logger logger = LoggerFactory.getLogger(RoomChatHandler.class);
//    private static final List<Session> sessionList = new ArrayList<Session>();
    private static final List<SessionDto> dtoList = new ArrayList<SessionDto>();
    /*
     * sessionList : 세션에 접속한 사람 목록
     * session : 세션을 연 사람
     */
    
    public RoomChatHandler() {
    	// 서버 열리면 자동적으로 생성된다.
    	// 다른 애들이 생성해도 해쉬코드가 동일하다!
        System.out.println("웹소켓(서버) 객체생성 (hashCode : " + RoomChatHandler.class.hashCode() + ")");
    }
    
    
    @OnOpen
    public void onOpen(Session mySession) { // 내 세션을 가지고 세션 접속을 위해 옴!
    	// liveChat에서 연결할때 히든으로 세션 room 받고 room을 new WebSocket 의 주소로 보냄!
    	/* 오류발생!
    	 * split 에서 ?, *, ^, + 등은 특수하게 사용되기 때문에 오류가 발생한다!
    	 * 오류를 해결하기 위해선 앞에 \ (역슬래시) 를 2개 사용해 주면 해결된다!		*/
    	// uri에서 ? 기준으로 가져옴
    	String[] uri = mySession.getRequestURI().toString().split("\\?")[1].split("&");
    	//System.out.println(uri); // 파라미터 부분 잘 잘려왔는지 체크
    	String id = uri[0].substring(3, uri[0].length());
    	String room = uri[1].substring(5, uri[1].length());
    	
    	try {
			id = URLDecoder.decode(id, "UTF-8");
			room = URLDecoder.decode(room, "UTF-8"); // utf-8 형태로 저장된거 한글로 바꾸기
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
    	
    	//System.out.println(id + " " + room); // room의 value만 잘 떼와졌는지 체크
        logger.info("[" + room + "]에 [" + id + "]id가 [" + mySession.getId() + "]session으로 참여");
        // 세션목록에 내 세션 담기
//        sessionList.add(mySession);
        SessionDto dto = new SessionDto(room, id, mySession);
        
        dtoList.add(dto);
        
        try {
        	mySession.getBasicRemote().sendText("대화방에 연결 되었습니다.");
        	// 접속 메세지 뿌리기
        	// 세션 목록에서 하나씩 세션 가져와서 세션에 뿌리는 것
//            for(Session session : WebSocketHandler.sessionList) {
//            	if(!mySession.getId().equals(session.getId())) {
//            		session.getBasicRemote().sendText("[" + mySession.getId() + "]님이 접속하셨습니다.");
//            	}
//            }
        	for(SessionDto WSDto : dtoList) {
        		if (dto.getRoom().equals(WSDto.getRoom())) { // 룸 번호가 내 룸번호와 동일하면
	        		if (!dto.getSession().getId().equals(WSDto.getSession().getId())) { // 만약 리스트의 id가 나랑 동일하지 않다면
	        			WSDto.getSession().getBasicRemote().sendText("[" + dto.getId() + "]님이 접속하셨습니다."); // 접속 알리기
	        		}
        		}
        	}
        }catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    /*
     * 보낸 세션과 dtoList를 비교하여 동일한 dto을 리턴
     */
    private SessionDto getMyDto(Session session) {
    	for (SessionDto dto : dtoList) {
    		if(dto.getSession().getId().equals(session.getId())) {
    			return dto;
    		}
    	}
    	return null;
    }
    /*
     * 모든 사용자에게 메시지를 전달한다.
     * @param self
     * @param sender
     * @param message
     */
    // 메세지 보내는 함수
    private void sendAllSessionToMessage(SessionDto dto, String message) {
        try {
        	// 세션을 forEach로 하나씩 보낸이 이름과 메세지를 뿌림 (내 세션의 id와 세션목록에서 id가 같다면 안보내기)
            for(SessionDto WSDto : dtoList) {
            	if (dto.getRoom().equals(WSDto.getRoom())) {
	                if(!dto.getSession().getId().equals(WSDto.getSession().getId())) {
	                	// 세션에 메세지 String 타입으로 [보낸이 : 메세지] 형태로 보내기
	                    WSDto.getSession().getBasicRemote().sendText(dto.getId() + " : " + message);
	                }
                }
            }
        }catch (Exception e) {
        	logger.warn("메세지 보내기 오류!" + e.getMessage());
        }
    }
    
    /*
     * 내가 입력하는 메세지
     * @param message
     * @param session
     */
    @OnMessage
    public void onMessage(String message, Session session) {try {
    	message = URLDecoder.decode(message, "UTF-8");
	} catch (UnsupportedEncodingException e1) {
		e1.printStackTrace();
	}
    	SessionDto dto = getMyDto(session);
    	if(dto == null) {
    		logger.error(session.getId() + "에 맞는 dtoList가 없습니다.");
    	} else {
	    	// message 에 , 를 기준으로 메세지 , 사용자 가 넘어옴
	    	String[] messages = message.split(",");
	    	// 메세지의 길이 - 1 번지의 값을 sender 로 지정
	    	String sender = messages[messages.length - 1]; // 뒤쪽의 보낸이 획득
	    	//String sender = message.substring(message.lastIndexOf(","), message.length());
	    	// message 에서 0번지부터 뒤부터 , 가 있는 번지 전 까지 저장
	    	message = message.substring(0, message.lastIndexOf(",")); // 보낸이를 제외한 값(메세지) 획득
	    	// 메세지 로그찍기
	        logger.info("Message From [" + sender + "] : " + message);
	        try {
	        	// 내 세션에 <나> 로 메세지 보내기
	            dto.getSession().getBasicRemote().sendText("<나> : " + message);
	        }catch (Exception e) {
	        	logger.warn(e.getMessage());
	        }
	        // 내 dto와 메세지 보내기
	        sendAllSessionToMessage(dto, message);
    	}
    }
    
    @OnError
    public void onError(Throwable e, Session session) {
        logger.warn("에러 발생\n" + e.getMessage()); // 에러 발생시 알림용
    }
    
    @OnClose
    public void onClose(Session session) {
    	SessionDto dto = getMyDto(session);
    	if(dto == null) {
    		logger.error(session.getId() + "에 맞는 dtoList가 없습니다.");
    	} else {
	        logger.info("["+dto.getSession().getId()+"]의 세션이 닫혔습니다.");
	        dtoList.remove(dto);
    	}
    }
}