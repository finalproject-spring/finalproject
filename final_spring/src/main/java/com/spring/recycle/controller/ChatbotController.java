package com.spring.recycle.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.api.gax.rpc.ApiException;
import com.google.gson.Gson;
import com.spring.recycle.util.DetectIntentTexts;
import com.spring.recycle.util.PapagoApi;
import com.spring.recycle.util.PapagoDetectLangs;

@Controller
public class ChatbotController {

	private Logger logger = LoggerFactory.getLogger(ChatbotController.class);
	
	// 채팅창 입장 시 세션 발급
	@RequestMapping("/chatbot.do")
	public String openChatbot(HttpSession session) {
		String session_id = UUID.randomUUID().toString();
		session.setAttribute("session-id", session_id);
		return "chatbot/chatbot";
	}
	
	@ResponseBody
	@RequestMapping(value="/chatbot_message.do")
	public void chatMessage(HttpServletResponse response, String senderName, String message, HttpSession session) throws ApiException, IOException, ParseException {
		logger.info("senderName : " + senderName + " message :" + message);
		String project_id = "final-project-319907";
		String session_id = (String) session.getAttribute("session-id");
		PapagoDetectLangs papagoDetectLangs = new PapagoDetectLangs();
		String lang = papagoDetectLangs.DetectLangs(message);
		logger.info("입력언어" + lang);
		// 사용자가 입력한 언어가 한글이 아니라면
		if(!lang.contains("ko")) {
			// 한국어로 번역
			PapagoApi papagoApi = new PapagoApi();
			String translatedMsg = papagoApi.Papago(message, lang, "ko");
			logger.info("한글로 번역된 발신 메세지 : " + translatedMsg);
			List<String> list = new ArrayList<>();
			list.add(translatedMsg);
			String responseMessage = DetectIntentTexts.detectIntentTexts(project_id, list, session_id, "(ko-KR)");
			
			// 수신 메세지 번역
			String resTranslagedMsg = papagoApi.Papago(responseMessage, "ko", lang);
			logger.info("수신 메세지 : " + resTranslagedMsg);
			Gson gson = new Gson();
			Map<String, Object> responseChat = new HashMap<>();
			responseChat.put("message", resTranslagedMsg);
			
			response.getWriter().print(gson.toJson(responseChat));
		} else {
			List<String> list = new ArrayList<>();
			list.add(message);
			
			String responseMessage = DetectIntentTexts.detectIntentTexts(project_id, list, session_id, "(ko-KR)");
			
			Gson gson = new Gson();
			Map<String, Object> responseChat = new HashMap<>();
			responseChat.put("message", responseMessage);
			
			response.getWriter().print(gson.toJson(responseChat));
		}
	}
}
