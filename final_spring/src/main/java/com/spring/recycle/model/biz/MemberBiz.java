package com.spring.recycle.model.biz;

import java.util.List;

import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.MemberDto;

public interface MemberBiz {
	
	String NAMESPACE="member.";
	public MemberDto login(MemberDto dto);
	public int join(MemberDto dto); 
	public int idCheck(String member_id);
	
	   // 지현 추가 - 관리자 페이지
	   // 전체 회원 조회
	   public List<MemberDto> memberList();
	   // 회원 상세 페이지
	   public MemberDto memberDetail(int member_no);
	   // 전체 회원 수
	   public int memberCount();
	   // 회원 작성글
	   public List<BoardDto> memberwriteList(int member_no);
	   // 작성글 디테일
	   public BoardDto memberwriteDetail(int board_no);
	   // 작성글 삭제
	   public int memberwriteDelete(int board_no);
	   // 회원 정보 수정
	   public int memberUpdate(MemberDto dto);
	   // 회원 탈퇴
	   public int memberDelete(int member_no);
	   // 회원 멀티 선택 탈퇴
	   public int memberSelectDelete(String member_no);
}
