package com.spring.recycle.controller;



import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.recycle.model.biz.GroupBiz;
import com.spring.recycle.model.biz.GroupBizImpl;
import com.spring.recycle.model.biz.GroupReplyBiz;
import com.spring.recycle.model.biz.GroupReplyBizImpl;
import com.spring.recycle.model.dao.GroupDao;
import com.spring.recycle.model.dto.GroupDto;
import com.spring.recycle.model.dto.GroupReplyDto;


@Controller
public class GroupController {
	
	@Autowired
	private GroupBiz biz = new GroupBizImpl();
	
	@Autowired
	private GroupReplyBiz replybiz = new GroupReplyBizImpl();
	
	@Autowired
	private GroupDao dao;
	
	private static final Logger logger = LoggerFactory.getLogger(GroupController.class);
	
	@RequestMapping(value = "/group_list.do", method = RequestMethod.GET)
	public String selectList(Model model) {
		model.addAttribute("list", biz.list());
		
		return "group/grouplist";
	}
	
	@RequestMapping("/group_insertform.do")
	public String insertForm() {
		return "group/groupinsert";
	}
	
	@RequestMapping(value = "/group_insertres.do" , method = RequestMethod.POST)
	public String insertRes(Model model , @ModelAttribute GroupDto dto , HttpServletRequest request , HttpServletResponse response) throws IOException {
		
		int res = 0;
		res = biz.write(dto);
		
		logger.info("==========dto: " +dto+"=============================res : " + res);
		PrintWriter out = response.getWriter();
		response.setContentType("text/html; charset=UTF-8");
		
		if(res>0) {
			out.print("<script>alert('게시글이 등록되었습니다..'); location.href='group_list.do';</script>");
		}else {
			out.println("<script>alert('게시글이 등록을 실패하였습니다.');</script>");
			return "group/groupinsert";
		}
		return "redirect:group_list.do";
	}
	
	@RequestMapping("/group_view.do")
	public String selectOne(@ModelAttribute("dto") GroupDto dto, Model model , int board_no) {
		model.addAttribute("dto" , biz.view(board_no));
		
		//조회수 증가
		biz.viewCount(dto.getBoard_no());
		
		//댓글 조회
		List<GroupReplyDto> replyList  = replybiz.readReply(dto.getBoard_no());
		model.addAttribute("replylist", replyList);
		
		
		return "group/groupselect";
	}
	
	@RequestMapping("/group_updateform.do")
	public String updateForm(Model model , int board_no) {
		model.addAttribute("dto", biz.view(board_no));
		return "group/groupupdate";
	}
	
	
	@RequestMapping("/group_updateres.do")
	public String updateRes(GroupDto dto) {
		
		if(biz.modify(dto)>0) {
			return "redirect:group_view.do?board_no="+dto.getBoard_no();
		}
		return "redirect:group_updateform.do?board_no="+dto.getBoard_no();
	}
	
	@RequestMapping("/group_delete.do")
	public String delete (String board_no) {
		
		if(biz.delete(board_no)>0) {
			return "redirect:group_list.do";
		}
		return "redirect:group_view.do?board_no="+board_no;
	}
	
	@RequestMapping("/group_selectdelete.do")
	public String selectDelete(HttpServletRequest request) {
		String[] ajaxMsg = request.getParameterValues("valueArr");
		int size = ajaxMsg.length;
		for(int i=0; i<size; i++) {
			biz.delete(ajaxMsg[i]);
		}
		return "redirect:group_list.do";
	}
	
	
	
	//댓글 작성 
	@RequestMapping(value = "/group_replywrite.do" , method = RequestMethod.POST)
	public String writerReply(int board_no, String reply_content, String reply_id) {
		GroupReplyDto dto = new GroupReplyDto(board_no ,0, reply_content , reply_id,null);
		replybiz.writeReply(dto);
	
		return "redirect:group_view.do?board_no="+dto.getBoard_no();
	}

}
