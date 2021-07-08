package com.spring.recycle.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.recycle.model.biz.MessageBiz;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.MessageDelDto;
import com.spring.recycle.model.dto.MessageDto;
import com.spring.recycle.paging.Criteria;
import com.spring.recycle.paging.PageMaker;



@Controller
public class MessageController {
	
	private Logger logger = LoggerFactory.getLogger(MessageController.class);
	
	@Autowired
	private MessageBiz biz;
	
	@RequestMapping("/message.do")
	public String message() {
		return "message/message";
	}
	
/*	@RequestMapping("/message_recvList.do")
	public String recvList(Model model, HttpServletRequest request) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
			logger.info("============[MessageController] recvlist member_id : " + dto.getMember_id());
		
		if (dto != null) {
			model.addAttribute("list", biz.getRecvMessage(dto.getMember_id()));
			
			return "message/message_recvlist";
		} 
			
			return "main/main"; //나중에 수정
		
	}*/
	
	@RequestMapping("/message_recvList.do")
	public String recvPageList(Model model, HttpServletRequest request, Criteria cri) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		logger.info("============[MessageController] recvlist member_id : " + dto.getMember_id());
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(biz.recvListCount(dto.getMember_id()));


		HashMap<String, Object> map = new HashMap();
		map.put("message_recvid", dto.getMember_id());
		map.put("cri", cri);
		
		List<MessageDto> list = biz.getRecvMessagelist(map);

		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		
			
		return "message/message_recvlist"; 
				
	}
	
	/*@RequestMapping("/message_sendList.do")
	public String sendList(Model model, HttpServletRequest request) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		logger.info("============[MessageController] sendlist member_id : " + dto.getMember_id());
		model.addAttribute("list", biz.getSendMessage(dto.getMember_id()));
		return "message/message_sendlist";
	}*/
	
	@RequestMapping("/message_sendList.do")
	public String sendPageList(Model model, HttpServletRequest request, Criteria cri) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		logger.info("============[MessageController] sendlist member_id : " + dto.getMember_id());
	
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(biz.sendListCount(dto.getMember_id()));


		HashMap<String, Object> map = new HashMap();
		map.put("message_sendid", dto.getMember_id());
		map.put("cri", cri);
		
		List<MessageDto> list = biz.getSendMessagelist(map);
		logger.info("=======send count : "+ biz.sendListCount(dto.getMember_id()) + "\n" + "list : " + list);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		
		return "message/message_sendlist";
	}
	
	@RequestMapping("/message_insert.do")
	public void insert(MessageDto dto, HttpServletRequest request) {
		logger.info("===========[MessageController] insert dto : " + dto);
		MemberDto mdto = (MemberDto) request.getSession().getAttribute("dto");
		String message_sendid = mdto.getMember_id();
		
		dto.setMessage_sendid(message_sendid);
		int res1 = biz.insertRecvMessage(dto);
		int res2 = biz.insertSendMessage(dto);
		
		if (res1 > 0 && res2 > 0) {
			logger.info("===============쪽지 등록 성공==============");
		}
	}

	@RequestMapping("/message_recvDetail.do")
	public String recvDetail(Model model, int message_no) {
		MessageDto mdto = biz.recvDetail(message_no);
		if (mdto.getMessage_readdate().contains("9999")) {
			biz.updateMessage(message_no);
		}
		model.addAttribute("dto", biz.recvDetail(message_no));
		return "message/message_recvdetail";
	}
	
	@RequestMapping("/message_sendDetail.do")
	public String sendDetail(Model model, int message_no) {
		model.addAttribute("dto", biz.sendDetail(message_no));
		return "message/message_senddetail";
		
	}
	
	@RequestMapping("/message_recvdel.do")
	public String recvDelete(MessageDelDto dto) {
		for (int no:dto.getMessage_noList()) {
			System.out.println("no= " + no);
		}
		int result = biz.deleteRecvMessage(dto.getMessage_noList());
		System.out.println("삭제된 레코드 수 = " +result);
		return "redirect:message_recvList.do";
	}
	
	@RequestMapping("/message_senddel.do")
	public String sendDelete(MessageDelDto dto) {
		for (int no:dto.getMessage_noList()) {
			System.out.println("no= " + no);
		}
		int result = biz.deleteSendMessage(dto.getMessage_noList());
		System.out.println("삭제된 레코드 수 = " +result);
		return "redirect:message_sendList.do";
	}
	
	@RequestMapping(value="/message_idCheck.do", method=RequestMethod.POST)
	@ResponseBody
	public int message_idCheck(String member_id) {
		logger.info(member_id);
		int res = biz.idCheck(member_id);		
		logger.info("================="+ member_id +"res =================" + res);
		return res;
	}
}
