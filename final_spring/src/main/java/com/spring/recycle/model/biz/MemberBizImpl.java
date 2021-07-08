package com.spring.recycle.model.biz;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.MemberDao;
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





	

}
