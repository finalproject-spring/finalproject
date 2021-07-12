package com.spring.recycle.model.biz;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.MemberDao;
import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.MemberDto;



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





	

}
