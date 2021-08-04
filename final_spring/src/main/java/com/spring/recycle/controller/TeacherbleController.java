package com.spring.recycle.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class TeacherbleController {
	
	@RequestMapping(value = "/teacherble.do", method = RequestMethod.GET)
	public String teacherble(Model model) {
		
		return "teacherble/test";
	}
	
	@RequestMapping(value = "/upload.do", method = RequestMethod.GET)
	public String upload(Model moel) {
		return "teacherble/upload";
	}

}
