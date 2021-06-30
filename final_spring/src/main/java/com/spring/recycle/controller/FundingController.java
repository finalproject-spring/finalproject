package com.spring.recycle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.spring.recycle.model.biz.FundingBiz;
import com.spring.recycle.model.dto.FundingDto;

@Controller
public class FundingController {
	
	@Autowired
	private FundingBiz biz;
	
	@RequestMapping("/funding_list.do")
	public String selectList(Model model) {
		model.addAttribute("list", biz.fundingList());
		
		return "funding/funding_list";
	}
	
	@RequestMapping("/funding_insertres.do")
	public String insertRes(FundingDto dto) {
		
		if(biz.fundingInsert(dto) > 0) {
			return "redirect:funding_list.do";
		}
		return "redirect:insertform.do";
	}

}
