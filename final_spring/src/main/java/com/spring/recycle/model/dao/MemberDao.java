package com.spring.recycle.model.dao;

import com.spring.recycle.model.dto.MemberDto;

public interface MemberDao {
	
	   String NAMESPACE="member.";
	   //login
	   public MemberDto login(MemberDto dto);
	   //회원가입
	   public int join(MemberDto dto);
	   //id중복검사하기 
	   public int idCheck(String member_id);
}
