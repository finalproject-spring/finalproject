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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.recycle.model.biz.DealBiz;
import com.spring.recycle.model.biz.PaymentBiz;
import com.spring.recycle.model.biz.RoomChatBiz;
import com.spring.recycle.model.dao.DealDao;
import com.spring.recycle.model.dto.ChatMessageDto;
import com.spring.recycle.model.dto.ChatRoomDto;
import com.spring.recycle.model.dto.DealBoardDto;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;

@Controller
public class DealController {
	
	private static final Logger logger = LoggerFactory.getLogger(DealController.class);
	@Autowired
	private RoomChatBiz roomBiz;
	@Autowired
	private DealBiz dealBiz;
	@Autowired
	private PaymentBiz pbiz;
	
	@RequestMapping("/dealList.do") // 거래방 목록
	public String DealList(Model model, HttpServletRequest request) {
		MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
		model.addAttribute("dealList", dealBiz.DealList());
		model.addAttribute("memberdto",memberdto);
		return "deal/dealList";
	}
	
	@RequestMapping(value = "/insertDealForm.do") // 거래방 작성 폼
	public String insertFrom(HttpServletRequest request, Model model) {
		if(request.getSession().getAttribute("dto") == null) {
			logger.error("로그인 필요");
			return "redirect:dealList.do";
		}
		return "deal/insertDeal";
	}
	
	@RequestMapping(value = "/insertDeal.do", method = RequestMethod.POST) // 거래방 작성 결과
	public String insertres(DealBoardDto dto, Model model, HttpServletRequest request) {
		MemberDto mDto = (MemberDto) request.getSession().getAttribute("dto");
		dto.setBoard_id(mDto.getMember_id());
		dto.setMember_no(mDto.getMember_no());
		if (dealBiz.InsertDeal(dto)) {
			logger.info("거랫글 작성 성공");
			return "redirect:dealList.do";
		}
		logger.info("거랫글 작성 실패");
		return "redirect:insertDealForm.do";
	}
	
	@RequestMapping(value = "/updateDealForm.do") // 거래방 작성 폼
	public String updateForm(int board_no, Model model) {
		model.addAttribute("dto", dealBiz.selectDeal(board_no));
		return "deal/updateDeal";
	}
	
	@RequestMapping(value = "/updateDeal.do", method = RequestMethod.POST) // 거래방 작성 결과
	public String updateres(DealBoardDto dto, Model model, HttpServletRequest request) {
		dto.setBoard_id(((MemberDto) request.getSession().getAttribute("dto")).getMember_id());
		if (dealBiz.updateDeal(dto)) {
			logger.info("거랫글 수정 성공");
			return "redirect:selectDeal.do?board_no=" + dto.getBoard_no();
		}
		logger.info("거랫글 수정 실패");
		return "redirect:updateDealForm.do?board_no=" + dto.getBoard_no();
	}

	@RequestMapping(value = "/deleteDeal.do") // 거래방 작성 결과
	public String deleteDeal(int board_no, Model model, HttpServletRequest request) {
		if (dealBiz.DeleteDeal(board_no)) {
			logger.info("거랫글 삭제 성공");
			return "redirect:dealList.do";
		}
		logger.info("거랫글 삭제 실패");
		return "redirect:selectDeal.do?board_no=" + board_no;
		
	}
	
	@RequestMapping("/selectDeal.do")
	public String selectDeal(Model model, int board_no, HttpServletRequest request, HttpServletResponse response) throws IOException {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		if(dto == null) {
			logger.error("로그인 필요");
			
			return "redirect:dealList.do";
		}
		model.addAttribute("memberdto", dto);
		model.addAttribute("id", dto.getMember_id());
		model.addAttribute("dealDto", dealBiz.selectDeal(board_no)); // 번호의 맞는 보드값
		model.addAttribute("roomChat", roomBiz.selectRoom(board_no)); // 번호에 맞는 채팅방 목록
		return "deal/selectDeal";
	}
	
	@RequestMapping("/roomList.do")
	public String ChatRoomList(Model model, HttpServletRequest request) {
		// 할일 db 연결 후 룸 목록 출력하기
		// jsp 페이지에서 출력하기, 방 생성하기 버튼
		model.addAttribute("roomList", roomBiz.roomlist());
		
		return "deal/ChatRoomList";
	}
	
	@RequestMapping(value = "/createRoom.do", method = RequestMethod.POST)
	public String createRoom(String room, int board_no, HttpServletRequest request) {
		System.out.println("생성 시작");
		if (room == null || room == "" || room == " ") {
			logger.error("방 이름이 비어있어 실패");
			return "redirect:selectDeal.do?board_no=" + board_no;
		}
		ChatRoomDto dto = new ChatRoomDto();
		dto.setCreator_id(((MemberDto) request.getSession().getAttribute("dto")).getMember_id());
		dto.setRoom_name(room);
		dto.setBoard_no(board_no);
		if(!roomBiz.insertRoom(dto)) {
			logger.error(room + "방 생성 실패");
		}
		
		return "redirect:selectDeal.do?board_no=" + board_no;
	}
	
	@RequestMapping(value="/deleteRoom.do")
	public String deleteRoom(@RequestParam String room, int board_no, HttpServletRequest request) {
		ChatRoomDto dto = new ChatRoomDto(0, room, null, null, ((MemberDto) request.getSession().getAttribute("dto")).getMember_id(), 0);
		if(!roomBiz.deleteRoom(dto)) {
			logger.error(room + "방 삭제 실패");
		}
		return "redirect:selectDeal.do?board_no=" + board_no;
		
	}
	
	@RequestMapping(value = "/JoinRoom.do")
	public String RoomJoin(@RequestParam String room, HttpServletRequest request, Model model) {
		MemberDto dto = (MemberDto) request.getSession().getAttribute("dto");
		String id = dto.getMember_id();
		if(room == "" || room == null) {
			logger.error(id + "의 [" + room + "] 접속 실패");
			return "redirect:dealList.do";
		} else {
			logger.info(id + "의 [" + room + "] 접속 성공");
			model.addAttribute("room", room);
			model.addAttribute("id", id);
			return "deal/liveChat";
		}
	}
	
	@RequestMapping(value = "/insertChat.do",  method = RequestMethod.POST)
	@ResponseBody
	public void insertMessage(String room, String sender, String message) {
		if(roomBiz.insertChat(new ChatMessageDto(0, 0, sender, message, null), room)) {
			logger.info(room + "방에 [" + sender + "] 의 메세지 [" + message + "] 기록 성공");
		} else {
			logger.error(room + "방에 [" + sender + "] 의 메세지 [" + message + "] 기록 실패");
		}
	}
	
	@RequestMapping(value = "/getChat.do", method = RequestMethod.POST)
	@ResponseBody
	public List<ChatMessageDto> getChat(String room) {
		List<ChatMessageDto> list = roomBiz.selectMessage(room);
		return list;
	}

	
	@RequestMapping("/deal_paySuccess.do")
	 public String deal_Success(HttpServletRequest request , Model model , int board_no,PaymentDto dto) {
		MemberDto memberdto = (MemberDto) request.getSession().getAttribute("dto");
		DealBoardDto dealDto = new DealBoardDto();
		model.addAttribute("dealDto", dealBiz.selectDeal(board_no));
		model.addAttribute("memberdto", memberdto);
		model.addAttribute("paymentdto", dto);
	
		 return "deal/deal_paySuccess";
		 
	 }
	
	@RequestMapping("/deal_payFail.do")
	public String funding_fail(int board_no,Model model) {
		DealBoardDto dealDto = new DealBoardDto();
		model.addAttribute("dealDto", dealBiz.selectDeal(board_no));
		return "deal/deal_payFail";
	}
	
	
	
	
}