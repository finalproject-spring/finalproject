package com.spring.recycle.model.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.paging.Criteria;
import com.spring.recycle.paging.SearchCriteria;

public interface MemberDao {
	
	   String NAMESPACE="member.";
	   //login
	   public MemberDto login(MemberDto dto);
	   // 자동 로그인 체크 시
	   public void keepLogin(String member_id, String sessionId, Date next);
	   // 유효기간 남은 세션 가지고 있는지 체크
	   public MemberDto checkMemberWithSessionKey(String sessionId);
	   //회원가입
	   public int join(MemberDto dto);
	   //id중복검사하기 
	   public int idCheck(String member_id);

	   // 지현 추가
	   //소셜로그인
	   public MemberDto socialLogin(String member_id);
	   // 소셜 회원가입
	   public int socialJoin(MemberDto dto);
	   // 소셜 아이디 체크 (없으면 회원가입 이동)
	   public int socialIdCheck(String member_socialid);
	   
	   /* 관리자 페이지 */
	   // 전체 회원 조회
	   public List<MemberDto> memberList();
	   // 전체 회원 조회 + 페이징
	   public List<MemberDto> memberListPage(SearchCriteria scri);
	   // 전체 회원수 + 검색
	   public int listCount(SearchCriteria scri);
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
	   //아이디 찾기
	   public String find_id (String member_email);
	   //비밀번호 임시비번으로 
	   public int update_pw(MemberDto dto);
	   



}
