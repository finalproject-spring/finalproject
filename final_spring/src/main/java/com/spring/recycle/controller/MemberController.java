 package com.spring.recycle.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.ProtocolException;
import java.net.URL;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.commons.mail.HtmlEmail;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.WebUtils;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.spring.recycle.model.biz.MemberBiz;
import com.spring.recycle.model.biz.kakaoBiz;
import com.spring.recycle.model.dao.MemberDao;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.NaverLoginDto;
import com.spring.recycle.util.ScriptUtils;


@Controller
public class MemberController {
	
	   
	   private Logger logger = LoggerFactory.getLogger(MemberController.class);
	   
	   @Autowired
	   private MemberBiz biz;
	   @Autowired
	   private BCryptPasswordEncoder pwEncoder;
	   @Autowired
	   private JavaMailSender mailSender;
	   @Autowired
	   private MemberDao dao;
	   
	   // 지현 추가
	   private MemberDto dto = new MemberDto();
	   private NaverLoginDto ndto = new NaverLoginDto();
	   
	   private final static String K_CLIENT_ID = "cc288a0383552958e9ae7ba110fadc1c";
	   //로컬호스트용
	   // private final static String K_REDIRECT_URI = "http://localhost:8787/recycle/login_kakaocallback.do";
	   //서버용
	   private final static String K_REDIRECT_URI = "http://qclass.iptime.org:8787/recycle/login_kakaocallback.do";
	   
	   //로그인 페이지폼으로 가기 
	   @RequestMapping(value = "/login_loginform.do" , method = RequestMethod.GET)
	   public String loginForm(Model model, HttpSession session) {
	      logger.info("[Controller] loginform.do");
	      
	      if(session.getAttribute("dto") != null) {
	    	  return "main/main";
	      }
	      NaverLoginDto dto = new NaverLoginDto();
	      String naverAuthUrl = dto.getAuthorizationUrl(session);
	      
		  String state = UUID.randomUUID().toString();
		  session.setAttribute("state", state);
		  
	      String kakaoAuthUrl = "https://kauth.kakao.com/oauth/authorize?client_id="+K_CLIENT_ID+"&redirect_uri="+K_REDIRECT_URI+"&response_type=code&prompt=login";
	      model.addAttribute("naver_url",naverAuthUrl);
	      model.addAttribute("kakao_url",kakaoAuthUrl);
	      return "member/memberlogin";
	   }
	   
	   
	   @RequestMapping( value = "/login.do" , method = RequestMethod.POST)
	   public String login(HttpServletRequest request , MemberDto dto , RedirectAttributes redirect, HttpServletResponse response) throws IOException {
	      
	      logger.info("[Controller] login.do");
	      
	      HttpSession session = request.getSession();
	      
	      if (session.getAttribute("dto") != null) {
	    	  session.removeAttribute("dto");
	      }
	      
	      String rawPw = "";    //사용자가 회원가입할 때 사용한 비번 
	      String encodePw = ""; //db에저장된 인코딩된 비번
	      
	      MemberDto dto2 = biz.login(dto); // 제출한 id 와 일치하는 id있는지
	      if(dto2 != null) { // 일치하는 아이디 존재한다면
	         rawPw = dto.getMember_pw(); //사용자가 제출한 비번 
	         encodePw = dto2.getMember_pw(); // db에 저장한 인코딩된 비번
	         if(true == pwEncoder.matches(rawPw, encodePw)) { // 비밀번호 일치여부 판단 
	            dto2.setMember_pw(""); //인코딩된 비밀번호 지움 
	            session.setAttribute("dto", dto2); // session에 사용자이 정보 저장
	            session.setMaxInactiveInterval(3600); // session 시간 60분
	            // 로그인 유지 쿠키 적용
	            if (dto.isUseCookie()) {
	            	Cookie cookie = new Cookie("loginCookie", session.getId());
	            	cookie.setPath("/");
	            	int amount = 60*60*24*7;
	            	cookie.setMaxAge(amount);
	            	response.addCookie(cookie);
	            	Date sessionLimit = new Date(System.currentTimeMillis() + (1000*amount));
	            	logger.info("================"+dto2.getMember_id() + session.getId() + sessionLimit);
	            	biz.keepLogin(dto2.getMember_id(), session.getId(), sessionLimit);
	            }
	            
	            return "main/main"; // 메인페이지로 이동
	         
	         }else {
	        	ScriptUtils.alertAndMovePage(response, "로그인에 실패했습니다.","login_loginform.do");
	         }
	      }else { // 일치하는 id가 존재하지 않을 경우
	         redirect.addFlashAttribute("result", dto2);
	         ScriptUtils.alertAndMovePage(response, "일치하는 회원 정보가 없습니다.","login_loginform.do");
	      }
		return "main/main";
	      
	   }
	   
	   
	   @ResponseBody
	   @RequestMapping(value = "/login_VerifyRecaptcha.do", method = RequestMethod.POST)
	   public int VerifyRecaptcha(HttpServletRequest request) {
	      logger.info("캡챠");
	       VerifyRecaptcha.setSecretKey("6LfoNKcbAAAAALy-0-TXaFeZrRzgsl64Fd3de8ng");
	       String gRecaptchaResponse = request.getParameter("recaptcha");
	       try {
	          if(VerifyRecaptcha.verify(gRecaptchaResponse))
	             return 0; // 성공
	          else return 1; // 실패
	       } catch (Exception e) {
	           e.printStackTrace();
	           return -1; //에러
	       }
	   }
	   
	   @RequestMapping("/login_memberjoin.do")
	   public String Success(HttpSession session) {
	      logger.info("회원가입 페이지 로 이동");
	      if(session.getAttribute("dto") != null) {
	    	  return "main/main";
	      }
	      return "member/memberjoin";      
	   }
	   
	   @RequestMapping(value = "/login_memberjoinres.do" , method = RequestMethod.POST)
	   public String joinRes(MemberDto dto, HttpServletRequest request, MultipartFile uploadfile) throws IOException {
		   
		  String rawPw="";
		  String encodePw="";
	      rawPw = dto.getMember_pw();
	      encodePw = pwEncoder.encode(rawPw);
	      dto.setMember_pw(encodePw);
	      biz.join(dto);
	      
	      
	      
	      return "member/memberlogin";
	   }
	   
	   //아이디 중복 검사
	   @RequestMapping(value = "/login_memberIdChk.do" , method = RequestMethod.POST)
	   @ResponseBody
	   public String memberIdChk(String memberId) {
	      System.out.println(memberId);
	      
	      logger.info("memberIdChk()");
	      
	      int res = biz.idCheck(memberId);
	      logger.info("결과 값= " + res);
	      if(res !=0) {
	         return "fail";   // 중복 아이디가 존재
	      }else {
	         return "success";   // 중복 아이디 x
	      }
	      
	   } //memberIdChk 종료

	   
	   /*이메일 인증*/
	   @ResponseBody
	   @RequestMapping(value = "/login_mailCheck.do")
	   public String mailCheck(String email) {
	      /* 인증번호(난수) 생성 */
	      Random random = new Random();
	      int checkNum = random.nextInt(888888) + 111111;
	      logger.info("이메일 데이터 전송 확인");
	      logger.info("인증번호 " + checkNum);
	      
	      /* 이메일 보내기 */
	      String setFrom = "taeheeworld@naver.com";
	      String toMail = email;
	      String title = "회원가입 인증 이메일 입니다.";
	      String content = 
	            "홈페이지를 방문해주셔서 감사합니다. 좋은 하루 되세요 :)" +
	            "<br><br>" + 
	            "인증 번호는 " + checkNum + "입니다." + 
	            "<br>" + 
	            "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";      
	      
	      try {
	         
	         MimeMessage message = mailSender.createMimeMessage();
	         MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	         helper.setFrom(setFrom);
	         helper.setTo(toMail);
	         helper.setSubject(title);
	         helper.setText(content,true);
	         mailSender.send(message);
	      }catch(Exception e) {
	         e.printStackTrace();
	      }      
	      
	      String num = Integer.toString(checkNum);
	      return num;
	      
	   }
	   
		@RequestMapping(value = "/member_logout.do" , method = RequestMethod.GET)
		public String logout(HttpServletRequest request, HttpSession session, HttpServletResponse response) throws IOException {
			logger.info("Logout");
		    
			if(session.getAttribute("kakao_token") != null) {
				kakaoBiz k_biz = new kakaoBiz();
				k_biz.kakaoLogout();
			}
			
			session = request.getSession();
			session.invalidate();	
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			if (loginCookie != null) {
	              loginCookie.setPath("/");
	                // 쿠키는 없앨 때 유효시간을 0으로 설정
	                loginCookie.setMaxAge(0);
	                response.addCookie(loginCookie);
	                
	                Date date =new Date(System.currentTimeMillis());
	                biz.keepLogin(dto.getMember_id(), session.getId(), date);
			}

			return "main/main";
		}
	   

		// 지현추가
		// 네이버 로그인
		@RequestMapping(value= "/login_navercallback.do")
		public String naverLogin(Model model, @RequestParam String code, @RequestParam String state, HttpSession session,
				HttpServletRequest request, RedirectAttributes redirect) throws Exception {
			
			OAuth2AccessToken oauthToken;			
			oauthToken = ndto.getAccessToken(session, code, state);

			// String을 json형태로 바꿈
			String apiResult = ndto.getUserProfile(oauthToken);
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(apiResult);
			JSONObject jsonObj = (JSONObject) obj;
			
			JSONObject response_obj = (JSONObject) jsonObj.get("response");
			
			String naver_id = (String) response_obj.get("id");
			String member_name = (String) response_obj.get("name");
			String member_email = (String) response_obj.get("email");
			String member_phone = (String) response_obj.get("mobile");
			String member_socialid = "@naver@"+naver_id;
			String member_pw = UUID.randomUUID().toString();

			if(biz.socialIdCheck(member_socialid) == 0) {
				dto.setMember_socialid(member_socialid);
				dto.setMember_name(member_name);
				dto.setMember_email(member_email);
				dto.setMember_phone(member_phone);
				dto.setMember_pw(member_pw);
				model.addAttribute("dto",dto);
				return "member/member_socialjoin";
			} else {
				dto = biz.socialLogin(member_socialid);
				session.setAttribute("dto", dto);
				session.setMaxInactiveInterval(3600);
				return "redirect:/login_main.do";
			}
			
		}
		

		@RequestMapping("/login_naverJoin.do")
		public String naverJoin(MemberDto dto, HttpServletResponse response) throws IOException {
			biz.socialJoin(dto);
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('회원가입이 완료되었습니다.'); </script>");
			out.flush();
			return "main/main";
		}
		
		// 카카오 로그인
		@RequestMapping(value="/login_kakaocallback.do")
		public String kakaoLogin(Model model, @RequestParam("code") String code, HttpSession session) {
			kakaoBiz k_biz = new kakaoBiz();
			String token = k_biz.getAccessToken(code);
			String header = "Bearer " + token;
			session.setAttribute("kakao_token", token);
			
			try {
				String kakao_apiURL = "https://kapi.kakao.com/v1/user/access_token_info";
				URL url = new URL(kakao_apiURL);
				HttpURLConnection con = (HttpURLConnection)url.openConnection();
				con.setRequestMethod("GET");
				con.setRequestProperty("Authorization", header);
				int responseCode = con.getResponseCode();
				BufferedReader br;
				
				if(responseCode==200) { // 정상 호출
					br = new BufferedReader(new InputStreamReader(con.getInputStream()));
				} else {  // 에러 발생
					br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
				}
				
				String inputLine;
				StringBuffer res = new StringBuffer();
				 while ((inputLine = br.readLine()) != null) {
				res.append(inputLine);
				}
				br.close();

				JSONParser parsing = new JSONParser();
				Object obj = parsing.parse(res.toString());
				JSONObject jsonObj = (JSONObject)obj;
				long kakao_id = (long) jsonObj.get("id");
				
				String member_socialid = "@kakao@" + kakao_id;
				String member_pw = UUID.randomUUID().toString();
	
				if (biz.socialIdCheck(member_socialid) == 0) {
					dto.setMember_socialid(member_socialid);
					dto.setMember_pw(member_pw);
					model.addAttribute("dto",dto);


					return "member/member_socialjoin";
					
				} else {
					dto = biz.socialLogin(member_socialid);
					session.setAttribute("dto", dto);
					session.setMaxInactiveInterval(3600);
					return "redirect:/login_main.do";
				}
					
			} catch (Exception e) {
				e.printStackTrace();
			}	
			
			return "main/main";
		}
		
		@RequestMapping("/login_kakaoJoin.do")
		public String kakaoJoin(MemberDto dto, HttpServletResponse response) throws IOException {
			biz.socialJoin(dto);
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('회원가입이 완료되었습니다.'); </script>");
			out.flush();

			return "main/main";
		}
		
		@RequestMapping("/login_main.do")
		public String moveMain() {
			return "main/main";
		}
	
		
		//아이디 찾기 폼으로 가기
		@RequestMapping("/findId_form.do")
		public String find_id_form() {
			return "member/findId_form";
		}

		
		@RequestMapping(value = "/findIdres.do" , method = RequestMethod.POST)
		public String find_id(HttpServletResponse response , @RequestParam("member_email") String member_email , Model model) throws IOException {
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			String member_id = biz.find_id(member_email);
			
			
			model.addAttribute("member_id", biz.find_id(member_email));
			
			if (member_id ==null) {
				out.println("<script>");
				out.println("alert('가입된 아이디가 없습니다.');");
				out.println("history.go(-1);");
				out.println("</script>");
				out.close();
				return null;
			}else {
				return "member/findId";
			}
			
		}
		
		//비밀번호 찾기 폼으로 가기
		@RequestMapping("/findPw_form.do")
		public String find_pw_form() {
			return "member/findPw_form";
		}
		


		//임시비밀번호 메일 보내기 
		public void send_mail(MemberDto dto , String div) {
			// Mail Server 설정
			String charSet = "utf-8";
			String hostSMTP = "smtp.naver.com";
			String hostSMTPid = "taeheeworld@naver.com";
			String hostSMTPpwd = "asd123!!";

			// 보내는 사람 EMail, 제목, 내용
			String fromEmail = "taeheeworld@naver.com";
			String fromName = "Save earth ,save us";
			String subject = "";
			String msg = "";
			
			
			if(div.equals("find_pw")) {
				
				subject = "Save earth ,save us 임시 비밀번호 입니다.";
				msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
				msg += "<h3 style='color: blue;'>";
				msg += dto.getMember_id() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
				msg += "<p>임시 비밀번호 : ";
				msg += dto.getMember_pw() + "</p></div>";
				
			}
			
			String mail = dto.getMember_email();
			try {
				HtmlEmail email = new HtmlEmail();
				email.setDebug(true);
				email.setCharset(charSet);
				email.setSSL(true);
				email.setHostName(hostSMTP);
				email.setSmtpPort(587);

				email.setAuthentication(hostSMTPid, hostSMTPpwd);
				email.setTLS(true);
				email.addTo(mail, charSet);
				email.setFrom(fromEmail, fromName, charSet);
				email.setSubject(subject);
				email.setHtmlMsg(msg);
				email.send();
			} catch (Exception e) {
				System.out.println("메일발송 실패 : " + e);
			}

		}
		
		@RequestMapping(value = "/find_pw.do" , method = RequestMethod.POST)
		public String find_pw(HttpServletResponse response , @ModelAttribute MemberDto dto ) throws Exception {
			
			response.setContentType("text/html;charset=utf-8");
			PrintWriter out = response.getWriter();
			System.out.println(dto.getMember_id());
			
			if(dao.idCheck(dto.getMember_id()) == 0) { //가입된 아이디가 없으면,, 
				out.print("아이디가 없습니다.");
				out.close();
			}else if(!dto.getMember_email().equals(dto.getMember_email())){// 가입된 이메일이 아니면
				out.print("잘못된 이메일 입니다.");
				out.close();
			}else { //임시비밀번호 생성함
				String pw = "";
				for (int i = 0; i < 12; i++) {
					pw += (char) ((Math.random() * 26) + 97);
				}
				dto.setMember_pw(pwEncoder.encode(pw)); //비밀번호 변경
				
				dao.update_pw(dto); //비밀번호 변경 메일 발송
				dto.setMember_pw(pw);
				send_mail(dto, "find_pw");
				out.print("이메일로 임시 비밀번호를 발송하였습니다.");
				out.close();
			
			}
			
			return null;
		}
		
}

