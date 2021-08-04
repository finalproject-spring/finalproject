package com.spring.recycle.model.biz;


import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.MemberDao;
import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.paging.Criteria;
import com.spring.recycle.paging.SearchCriteria;



@Service
public class MemberBizImpl implements MemberBiz {
	
	
	@Autowired
	private MemberDao dao;

	@Override
	public MemberDto login(MemberDto dto) {
		return dao.login(dto);
	}

	@Override
	public int join(MemberDto dto) {
		// TODO Auto-generated method stub
		return dao.join(dto);
	}

	@Override
	public int idCheck(String member_id) {
		// TODO Auto-generated method stub
		return dao.idCheck(member_id);
	}

	@Override
	public List<MemberDto> memberList() {
		return dao.memberList();
	}

	@Override
	public int memberCount() {
		return dao.memberCount();
	}

	@Override
	public MemberDto memberDetail(int member_no) {
		return dao.memberDetail(member_no);
	}

	@Override
	public List<BoardDto> memberwriteList(int member_no) {
		return dao.memberwriteList(member_no);
	}

	@Override
	public int memberUpdate(MemberDto dto) {
		return dao.memberUpdate(dto);
	}

	@Override
	public int memberSelectDelete(String member_no) {
		return dao.memberSelectDelete(member_no);
	}

	@Override
	public int memberDelete(int member_no) {
		return dao.memberDelete(member_no);
	}

	@Override
	public BoardDto memberwriteDetail(int board_no) {
		return dao.memberwriteDetail(board_no);
	}

	@Override
	public int memberwriteDelete(int board_no) {
		return dao.memberwriteDelete(board_no);
	}

	@Override
	public MemberDto socialLogin(String member_id) {
		return dao.socialLogin(member_id);
	}

	@Override
	public int socialJoin(MemberDto dto) {
		return dao.socialJoin(dto);
	}

	@Override
	public int socialIdCheck(String member_socialid) {
		return dao.socialIdCheck(member_socialid);
	}

	@Override
	public String find_id(String member_email) {
		// TODO Auto-generated method stub
		return dao.find_id(member_email);
	}

	@Override
	public int update_pw(MemberDto dto) {
		// TODO Auto-generated method stub
		return dao.update_pw(dto);
	}

	@Override
	public List<MemberDto> memberListPage(SearchCriteria scri) {
		return dao.memberListPage(scri);
	}

	@Override
	public int listCount(SearchCriteria scri) {
		return dao.listCount(scri);
	}

	@Override
	public MemberDto checkMemberWithSessionKey(String sessionId) {
		return dao.checkMemberWithSessionKey(sessionId);
	}

	@Override
	public void keepLogin(String member_id, String sessionId, Date next) {
		dao.keepLogin(member_id, sessionId, next);
	}

}
