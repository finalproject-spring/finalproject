package com.spring.recycle.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.recycle.model.biz.BoardBiz;
import com.spring.recycle.model.biz.GroupReplyBiz;
import com.spring.recycle.model.biz.GroupReplyBizImpl;
import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.GroupReplyDto;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.paging.PageMaker;
import com.spring.recycle.paging.SearchCriteria;
import com.spring.recycle.util.ScriptUtils;

@Controller
public class BoardController {
	
	private Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	@Autowired
	private BoardBiz biz;
	
	@Autowired
	private GroupReplyBiz replybiz = new GroupReplyBizImpl();

	
	@RequestMapping(value="/qna_list.do", method = RequestMethod.GET)
	public String qna_list(Model model, HttpServletRequest request, SearchCriteria scri) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("memberdto", dto);
		model.addAttribute("list", biz.qnaList(scri));
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(biz.qnaListCount(scri));

		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("scri", scri);
		return "qna/qna_list";
	}
	
	@RequestMapping("/qna_detail.do")
	public String qna_detail(Model model, int board_no, HttpServletRequest request, SearchCriteria scri) {
		List<GroupReplyDto> replyList  = new ArrayList<GroupReplyDto>();
		replyList = replybiz.readReply(board_no);
		model.addAttribute("dto", biz.qnaDetail(board_no));
		model.addAttribute("replylist", replyList);
		MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("memberdto", memberdto);
		model.addAttribute("scri", scri);
		return "qna/qna_detail";
	}
	
	@RequestMapping("/qna_insertform.do")
	public String qna_insertform(Model model, HttpServletRequest request) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("dto", dto);
		return "qna/qna_insert";
	}
	
	@RequestMapping("/qna_insertres.do")
	public String qna_insertres(Model model, BoardDto dto) {
		int res = biz.qnaInsert(dto);
		if (res > 0) {
			return "redirect:/qna_list.do";
		}
		return "redirect:/qna_insertform.do";
	}
	
	@RequestMapping("/qna_updateform.do")
	public String qna_updateform(Model model, int board_no, SearchCriteria scri) {
		BoardDto dto = biz.qnaDetail(board_no);
		model.addAttribute("dto", dto);
		model.addAttribute("scri",scri);
		return "qna/qna_update";
	}

	@RequestMapping("/qna_updateres.do")
	public String qna_updateres(Model model, BoardDto dto, int board_no, SearchCriteria scri, RedirectAttributes rttr) {
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		int res = biz.qnaUpdate(dto);
		if(res > 0) {
			return "redirect:/qna_detail.do?board_no="+board_no;
		}
		return "redirect:/qna_updateform.do?board_no="+board_no;
	}
	
	@RequestMapping("/qna_delete.do")
	public String qna_delete(int board_no, SearchCriteria scri, RedirectAttributes rttr) {
		int res= biz.qnaDelete(board_no);
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		if(res > 0) {
			return "redirect:/qna_list.do";
		}
		
		return "redirect:/qna_detail.do?board_no="+board_no;
	}
	
	@RequestMapping(value="/qna_reply.do", method= RequestMethod.POST)
	public String qna_reply(GroupReplyDto dto, int board_no) {
		biz.qnaReply(dto);
		return "redirect:/qna_detail.do?board_no="+board_no;
	}
	
	@RequestMapping(value="/qna_replyDelete.do", method= RequestMethod.GET)
	public void qna_replyDelete(int board_no, int reply_no, HttpServletResponse response) throws IOException {
		biz.qnaReplyDelete(reply_no);
		ScriptUtils.alertAndMovePage(response,"댓글이 삭제되었습니다.", "qna_detail.do?board_no="+board_no);
	}


}
