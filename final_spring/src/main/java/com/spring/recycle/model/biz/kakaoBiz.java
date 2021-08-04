package com.spring.recycle.model.biz;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

public class kakaoBiz {
	
	  private final static String CLIENT_ID = "cc288a0383552958e9ae7ba110fadc1c";
	  //private final static String REDIRECT_URI = "http://localhost:8787/recycle/login_kakaocallback.do";
	  private final static String REDIRECT_URI = "http://qclass.iptime.org:8787/recycle/login_kakaocallback.do";
	  
	  // 토큰 얻기
	  public String getAccessToken (String authorize_code) {
		  String access_Token = "";
		  String refresh_Token = "";
		  String reqURL = "https://kauth.kakao.com/oauth/token";

		  try {
			  URL url = new URL(reqURL);
			  
			  HttpURLConnection con = (HttpURLConnection) url.openConnection();
			  
			  con.setRequestMethod("POST");
			  con.setDoOutput(true);

			  // POST 요청에 필요로 요구하는 파라미터 스트림을 통해 전송
			  BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(con.getOutputStream()));
			  StringBuilder sb = new StringBuilder();
			  sb.append("&grant_type=authorization_code");
			  sb.append("&client_id="+CLIENT_ID);
			  sb.append("&redirect_uri="+REDIRECT_URI);
			  sb.append("&code=" + authorize_code);
			  bw.write(sb.toString());
			  bw.flush();
			  
			  int responseCode = con.getResponseCode();
			  System.out.println("responseCode : " + responseCode);

			  BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			  String line = "";
			  String result = "";
			  
			  while ((line = br.readLine()) != null) {
				  result += line;
			  }
			  
			  JsonElement element = JsonParser.parseString(result);

			  access_Token = element.getAsJsonObject().get("access_token").getAsString();
			  refresh_Token = element.getAsJsonObject().get("refresh_token").getAsString();
			  
			  br.close();
			  bw.close();
		  } catch (IOException e) {
               e.printStackTrace();
		  }
		  
		  return access_Token;
	  }
	  
	  // 로그아웃
	  public void kakaoLogout () {
		  String reqURL ="https://kauth.kakao.com/oauth/logout&client_id="+CLIENT_ID+"&logout_redirect_uri=http://qclass.iptime.org:8787/recycle/member_logout.do";
		  try {
			  URL url = new URL(reqURL);
			  
			  HttpURLConnection con = (HttpURLConnection) url.openConnection();
			  
			  con.setRequestMethod("GET");
			  con.setDoOutput(true);
			  
			  int responseCode = con.getResponseCode();
			  System.out.println("로그아웃 responseCode : " + responseCode);


		  } catch (IOException e) {
               e.printStackTrace();
		  }
	  }

}
