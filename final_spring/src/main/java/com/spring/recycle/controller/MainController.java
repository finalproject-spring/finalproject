package com.spring.recycle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	// 수정했어요
	
	@RequestMapping("/main.do")
	public String goMain() {
		return "main/main";
	}

}
