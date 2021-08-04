package com.spring.recycle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.recycle.model.biz.InfoBiz;

@Controller
public class InfoController {
	
	@Autowired
	private InfoBiz biz;
	
	@RequestMapping(value="/board.do", method=RequestMethod.GET)
	public String infoList(Model model) {
		
		model.addAttribute("list", biz.infoList());
		
		return "board/board_list";
		
	}
	

}
