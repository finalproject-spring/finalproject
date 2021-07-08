package com.spring.recycle.model.biz;

import com.spring.recycle.model.dto.MemberDto;

public interface MemberBiz {
	
	String NAMESPACE="member.";
	public MemberDto login(MemberDto dto);
	public int join(MemberDto dto); 
	public int idCheck(String member_id);
}
