package com.spring.recycle.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.sql.SQLException;
import java.util.Random;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.spring.recycle.model.biz.MemberBiz;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.NaverLoginDto;


@Controller
public class MemberController {
	
	   
	   private Logger logger = LoggerFactory.getLogger(MemberController.class);
	   
	   @Autowired
	   private MemberBiz biz;
	   @Autowired
	   private BCryptPasswordEncoder pwEncoder;
	   @Autowired
	   private JavaMailSender mailSender;
	   // 지현 추가
	   private MemberDto dto = new MemberDto();
	   private NaverLoginDto ndto = new NaverLoginDto();
	   
	   
	   //로그인 페이지폼으로 가기 
	   @RequestMapping(value = "/login_loginform.do" , method = RequestMethod.GET)
	   public String loginForm(Model model, HttpSession session) {
	      logger.info("[Controller] loginform.do");
	      
	      // 네이버
	      NaverLoginDto dto = new NaverLoginDto();
	      String naverAuthUrl = dto.getAuthorizationUrl(session);
	      
	      model.addAttribute("naver_url",naverAuthUrl);
	      
	      return "member/memberlogin";
	   }
	   
	   
	   @RequestMapping( value = "/login.do" , method = RequestMethod.POST)
	   public String login(HttpServletRequest request , MemberDto dto , RedirectAttributes redirect) {
	      
	      logger.info("[Controller] login.do");
	      
	      HttpSession session = request.getSession();
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
	            return "main/main"; // 메인페이지로 이동
	         
	         }else {
	            redirect.addFlashAttribute("result", dto2);
	            return "member/memberjoin";
	         }
	      }else { // 일치하는 id가 존재하지 않을 경우
	         
	         redirect.addFlashAttribute("result", dto2);
	         return "member/memberlogin";
	      }
	      
	   }
	   
	   
	   @ResponseBody
	   @RequestMapping(value = "/login_VerifyRecaptcha", method = RequestMethod.POST)
	   public int VerifyRecaptcha(HttpServletRequest request) {
	      logger.info("캡챠");
	       VerifyRecaptcha.setSecretKey("6LdFpmQbAAAAAJzJo-RJ_OX12Un8pkcRPO8y7B3O");
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
	   public String Success() {
	      logger.info("회원가입 페이지 로 이동");
	      return "member/memberjoin";      
	   }
	   
	   @RequestMapping(value = "/login_memberjoinres.do" , method = RequestMethod.POST)
	   public String joinRes(MemberDto dto, HttpServletRequest request, MultipartFile uploadfile) throws IOException {
		   
		   logger.info("dto : " + dto);
		   logger.info("uploadfile :" + uploadfile);
		   logger.info("upload file name : " + uploadfile.getOriginalFilename());
		   logger.info("upload file size: " + uploadfile.getSize());
		   String contextRoot = request.getSession().getServletContext().getRealPath("/");
		   String fileRoot = contextRoot + "resources/fileupload/member_img/";
		   String originalFileName = uploadfile.getOriginalFilename();	//오리지날 파일명
		   String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		   String savedFileName = UUID.randomUUID() + extension;	//저장될 파일 명
		   File targetFile = new File(fileRoot + savedFileName);
		   InputStream fileStream;
		   fileStream = uploadfile.getInputStream();
		   FileUtils.copyInputStreamToFile(fileStream, targetFile);
		   dto.setMember_pic("resources/fileupload/member_img/"+savedFileName);

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
		public String logout(HttpServletRequest request) {
			logger.info("Logout");
		        
			HttpSession session = request.getSession();
			session.invalidate();
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

			if(biz.idCheck(member_socialid) == 0) {
				dto.setMember_socialid(member_socialid);
				dto.setMember_name(member_name);
				dto.setMember_email(member_email);
				dto.setMember_phone(member_phone);
				dto.setMember_pw(member_pw);
				model.addAttribute("dto",dto);
				return "member/member_socialsignup";
			} else {
				dto = biz.socialLogin(member_socialid);
				session.setAttribute("dto", dto);
				session.setMaxInactiveInterval(3600);
				return "main/main";
			}
			
		}
		
		@RequestMapping("/login_naverJoin.do")
		public String naverJoin(MemberDto dto) {
			biz.socialJoin(dto);
			return "main/main";
		}
}

