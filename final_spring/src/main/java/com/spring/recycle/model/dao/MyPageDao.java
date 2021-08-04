package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.model.dto.WishDto;

public interface MyPageDao {
	
	String NAMESPACE = "IMyPage.";
	
	public MemberDto MySelect(String member_id);
	public int updatePW(MemberDto dto);
	public int MyDelete(String member_id);
	public String selectPW(String member_id);
	
	public List<PaymentDto> PayMentList(String member_id);
	public int PayMentDelete(int pay_num);
	
	public List<WishDto> WishList(String member_id);
	public int WishDelete(int wish_no);
}
