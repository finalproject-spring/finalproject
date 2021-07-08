package com.spring.recycle.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.recycle.model.biz.EventBiz;
import com.spring.recycle.model.dao.EventDao;
import com.spring.recycle.model.dto.EventDto;
import com.spring.recycle.util.EventSearchCriteria;
import com.spring.recycle.util.EventPageMaker;

@Controller
public class EventController {
	@Autowired
	private EventBiz biz;
	
	@Autowired
	private EventDao dao;
	private static final Logger logger = LoggerFactory.getLogger(EventController.class);
	
	@RequestMapping(value = "/event_list.do" , method = RequestMethod.GET)
	public String selectList(Model model, @ModelAttribute("scri") EventSearchCriteria scri) {
		logger.info("==========scri" + scri);
		model.addAttribute("list", biz.list(scri));
		logger.info("==========list" + biz.list(scri));
		EventPageMaker pageMaker = new EventPageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(biz.listCount(scri));
		
		
		model.addAttribute("pageMaker", pageMaker);
		return "event/eventlist";
	}
	@RequestMapping("/event_view.do")
	public String selectOne(Model model , EventDto dto , int event_no) {
		model.addAttribute("dto", biz.view(event_no));
		return "event/eventselect";
		
	}
	
	@RequestMapping("/event_insertform.do")
	public String insertForm() {
		return "event/eventinsert";
	}
	

	
	@RequestMapping(value = "/event_insertres.do" , method = RequestMethod.POST)
	public String insertRes(Model model, @ModelAttribute EventDto dto , HttpServletRequest request ,HttpServletResponse response  ) throws IOException {
		int res = 0;
		res = biz.write(dto);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		if(res > 0) {
			out.print("<script>alert('게시글이 등록되었습니다..'); location.href='event_list.do';</script>");
		}else {
			out.println("<script>alert('게시글이 등록을 실패하였습니다.');</script>");
			return "event/eventinsert";
		}
		return "redirect:event_list.do";
	}
	
	@RequestMapping("/event_updateform.do")
	public String updateForm(Model model , int event_no) {
		model.addAttribute("dto" , biz.view(event_no));
		return "event/eventupdate";
	}
	@RequestMapping("/event_updateres.do")
	public String updateRes(EventDto dto) {
		logger.info("==========dto: " +dto);
		if(biz.modify(dto)>0) {
			return "redirect:event_view.do?event_no="+dto.getEvent_no();
		}
		return "redirect:event_updateform.do?event_no="+dto.getEvent_no();
	}
	
	
	@RequestMapping("/event_delete.do")
	public String delete(String event_no) {
		if(biz.delete(event_no)>0) {
			return "redirect:event_list.do";
		}
		return "redirect:event_view.do?event_no="+event_no;
	}
	
	@RequestMapping("/event_selectdelete.do")
	public String selectDelete(HttpServletRequest request) {
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for(int i=0; i<size; i++) {
			biz.delete(ajaxMsg[i]);
		}
		return "redirect:event_list.do";
		
	}
}
