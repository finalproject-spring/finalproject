
package com.spring.recycle.controller;



import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.recycle.model.biz.GroupBiz;
import com.spring.recycle.model.biz.GroupBizImpl;
import com.spring.recycle.model.biz.GroupReplyBiz;
import com.spring.recycle.model.biz.GroupReplyBizImpl;
import com.spring.recycle.model.dao.GroupDao;
import com.spring.recycle.model.dto.GroupDto;
import com.spring.recycle.model.dto.GroupReplyDto;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.util.GroupPageMaker;
import com.spring.recycle.util.GroupSearchCriteria;
import com.spring.recycle.util.ScriptUtils;



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
	public String selectList(HttpServletRequest request,Model model , @ModelAttribute("scri") GroupSearchCriteria scri) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("memberdto", dto);
		if(scri.getBoard_filter().contains("전체보기")) {
			scri.setBoard_filter("");
		}
		
		model.addAttribute("list",biz.boardList(scri));
		
		GroupPageMaker pageMaker = new GroupPageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(biz.listCount(scri));
		model.addAttribute("scri" , scri);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("count", biz.boardCount());
		
		return "group/grouplist";
	}
	@ResponseBody
	@RequestMapping(value = "board_ajax.do" , method ={ RequestMethod.POST, RequestMethod.GET } )
	public List<Object> groupAjax(@RequestBody HashMap<String,Object> params){
		
		String filter = params.get("board_filter").toString();
		logger.info(filter);
		GroupSearchCriteria scri = new GroupSearchCriteria();
		scri.setBoard_filter(filter);
		
		GroupPageMaker pageMaker = new GroupPageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(biz.listCount(scri));
		
		List<Object> temp = new ArrayList<Object>(); temp.add(biz.boardList(scri));
		temp.add(pageMaker); System.out.println(temp);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", biz.boardList(scri));
		map.put("pageMaker", pageMaker);
	
		return temp;
		
	}
	
	
	@RequestMapping("/group_insertform.do")
	public String insertForm(Model model , HttpServletRequest request) {
		MemberDto dto = (MemberDto)request.getSession().getAttribute("dto");
		model.addAttribute("dto",dto );
		
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
	   public String selectOne(HttpServletRequest request,@ModelAttribute("dto") GroupDto dto, Model model , int board_no) {
	      
	      //조회수 증가
	      biz.viewCount(dto.getBoard_no());
	      
	      //댓글 조회
	      List<GroupReplyDto> replyList  = new ArrayList<GroupReplyDto>();
	      replyList = replybiz.readReply(board_no);
	      model.addAttribute("dto" , biz.view(board_no));
	      model.addAttribute("replylist", replyList);
	      MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
	      model.addAttribute("memberdto", memberdto);
	      if (memberdto != null) {
	    	  model.addAttribute("memberdto", memberdto);
	    	  model.addAttribute("id", memberdto.getMember_id());
	      }
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
	public String writerReply(int board_no,GroupReplyDto dto) {
		
		/*
		 * 
		 * int board_no, int reply_no, String reply_content, String reply_id, Date reply_date
		 */
		replybiz.writeReply(dto);
	
		return "redirect:group_view.do?board_no="+board_no;
	}
	
	@RequestMapping(value = "/group_deleteReply.do", method = RequestMethod.POST)
	public void WriterDelete(int board_no , int reply_no , HttpServletResponse response) throws IOException {
		replybiz.deleteReply(reply_no);
		ScriptUtils.alertAndMovePage(response,"댓글이 삭제되었습니다.", "qna_detail.do?board_no="+board_no);
		
	}

}
