package com.spring.recycle.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.recycle.model.biz.EventBiz;
import com.spring.recycle.model.biz.FundingBiz;
import com.spring.recycle.util.EventSearchCriteria;
import com.spring.recycle.util.FundingSearchCriteria;

@Controller
public class CalendarController {

	@Autowired
	private EventBiz eBiz;
	
	@Autowired
	private FundingBiz fBiz;
	
	@RequestMapping(value = "/calendar.do", method = RequestMethod.GET)
	public String calendar(Model model, @ModelAttribute("event") EventSearchCriteria event) {
		
		// fund, event의 list 가져와서 calendar로 보냄
		model.addAttribute("event", eBiz.listAll());
		model.addAttribute("fund", fBiz.fundingAll());
		
		return "calendar/calendar";
	}
	
}
