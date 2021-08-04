package com.spring.recycle.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.api.client.util.ArrayMap;
import com.spring.recycle.model.biz.MyPageBiz;
import com.spring.recycle.model.dto.MemberDto;

@Controller
public class MyPageController {

	private Logger logger = LoggerFactory.getLogger(MyPageController.class);
	
	@Autowired
	MyPageBiz biz;
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@RequestMapping("/mypage.do")
	public String mypage(HttpServletRequest request, Model model) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto"); // 세션에 있는 dto 사용
		model.addAttribute("res", "null");
		if(dto != null) {
			model.addAttribute("dto", dto);
			model.addAttribute("res", "1");
		}
		return "mypage/mypage";
	}

	@RequestMapping("/updatePW.do")
	@ResponseBody
	public Map<String, String> mypageUpdate(HttpServletRequest request, MemberDto dto, String changePW) {
		MemberDto sessDto = (MemberDto) request.getSession().getAttribute("dto"); // 세션 dto
		Map<String, String> res = new ArrayMap<>();
		res.put("res", "0");
		String dbpw = biz.selectPW(sessDto.getMember_id());
		if(pwEncoder.matches(dto.getMember_pw(), dbpw)) { // 세션dto의 pw와 넘어온 dto의 pw가 동일하다면 실행
			logger.info("세션의 pw와 넘어온 pw가 동일");
			dto.setMember_pw(pwEncoder.encode(changePW));
			if(biz.updatePW(dto)) {
				res.replace("res", "1");
				return res;
			}
		} else {
			logger.error("비밀번호 변경 실패 : " + dbpw + " != " + pwEncoder.encode(dto.getMember_pw()));
		}
		return res;
	}
	
	@RequestMapping("/MyPageDelete.do")
	public String mypagedelete(HttpServletRequest request, String member_id) {
		if(biz.MyDelete(member_id)) {
			logger.info("회원탈퇴 성공");
			request.getSession().removeAttribute("dto");
			return "redirect:main.do";
		}
		logger.error("회원탈퇴 실패");
		return "redirect:mypage.do";
	}
	
	@RequestMapping("/paymentList.do")
	public String paymentList(HttpServletRequest request, Model model) {
		if(model.getAttribute("res") == null) {
			model.addAttribute("res", 2);
		}
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("paylist", biz.PayMentList(dto.getMember_id()));
		
		return "mypage/PayMentPage";
	}
	
	@RequestMapping("/paymentDelete.do")
	public String paymentDelete(HttpServletRequest request, Model model, int pay_num) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("res", 0);
		if(biz.PayMentDelete(pay_num)) {
			model.addAttribute("res", 1);
		}
		return "redirect:paymentList.do";
	}
	
	@RequestMapping("/wishList.do")
	public String wishList(HttpServletRequest request,Model model) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("wishlist", biz.WishList(dto.getMember_id()));
		return "mypage/WishPage";
	}
	
	@RequestMapping("/wishDelete.do")
	public String wishDelete() {
		return null;
	}
}
