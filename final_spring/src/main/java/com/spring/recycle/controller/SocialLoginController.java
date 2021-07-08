package com.spring.recycle.controller;

import java.math.BigInteger;
import java.security.SecureRandom;

import javax.servlet.http.HttpSession;

import org.codehaus.jackson.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class SocialLoginController {

	
	private Logger logger = LoggerFactory.getLogger(SocialLoginController.class);
	
	private final static String K_CLIENT_ID = "cc288a0383552958e9ae7ba110fadc1c";
	private final static String K_REDIRECT_URI = "http://localhost:8787/recycle/login_kakao.do";
	
	public static String getAuthorizationUrl(HttpSession session) {
		SecureRandom random = new SecureRandom();
	    String state = new BigInteger(130, random).toString();
	    String prompt = "login";
	    String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?client_id="+K_CLIENT_ID+"&redirect_uri=" + K_REDIRECT_URI + "&response_type=code&" + "&state=" + state + "&prompt=" + prompt;
		
	    return kakaoUrl; 
	}
	
	public static JsonNode getAccessToken(String autorize_code) {
		return null;
	}
	
	@RequestMapping("/login_kakao.do")
	public String kakaoLogin(@RequestParam(value="code", required = false) String code) throws Exception {
		
	  
		return "login/socialLogin";
	}

}
