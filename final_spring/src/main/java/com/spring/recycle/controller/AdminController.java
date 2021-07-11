package com.spring.recycle.controller;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.recycle.model.biz.MemberBiz;
import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.MemberDto;

@Controller
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);
	
	@Autowired
	private MemberBiz biz;
	
	@RequestMapping("/admin_memberList.do")
	public String memberList(Model model) {
		model.addAttribute("count", biz.memberCount());
		model.addAttribute("list", biz.memberList());
		return "admin/admin_memberlist";
	}
	
	@RequestMapping("/admin_memberDetail.do")
	public String memberDetail(Model model, int member_no) {
		model.addAttribute("dto", biz.memberDetail(member_no));
		model.addAttribute("list", biz.memberwriteList(member_no));
		return "admin/admin_memberdetail";
	}
	
	@RequestMapping("/admin_memberUpdate.do")
	public String memberUpdate(MemberDto dto, int member_no) {
		int res = biz.memberUpdate(dto);
		
		if (res > 0) {
			return "redirect:/admin_memberDetail.do?member_no="+member_no;
		} else {
			return "redirect:/admin_memberDetail.do?member_no="+member_no;
		}
		
	}
	
	@RequestMapping("/admin_memberDelete.do")
	public String memberDelete(int member_no) {
		
		int res = biz.memberDelete(member_no);
		logger.info("=====================res = " + res);
		
		if (res > 0) {
			return "redirect:/admin_memberList.do";
		}
		
		return "redirect:/admin_memberDetail.do?member_no="+member_no;
	}
	
	@RequestMapping("/admin_memberSelectDelete.do")
	public void memberSelectDelete(HttpServletRequest request) {
		
		String[] del = request.getParameterValues("Arr");
		int size = del.length;
		for(int i=0; i<size; i++) {
			biz.memberSelectDelete(del[i]);
		}		
	}
	
	@RequestMapping("/admin_memberWrite.do")
	public String memberWrite(Model model, int board_no) {
		BoardDto dto = biz.memberwriteDetail(board_no);
		model.addAttribute("dto",dto);
		
		return "admin/admin_memberwrite";
	}
	
	@RequestMapping("/admin_memberWriteDelete.do")
	public String memberWriteDelete(Model model, int board_no, int member_no) {
		int res = biz.memberwriteDelete(board_no);
		if (res > 0) {
			return "redirect:/admin_memberDetail.do?member_no="+member_no;
		}
		return "redirect:/admin_memberDetail.do?member_no="+member_no;
	}

}
