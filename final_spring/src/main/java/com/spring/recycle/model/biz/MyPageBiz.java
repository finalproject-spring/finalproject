package com.spring.recycle.model.biz;

import java.util.List;

import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.model.dto.WishDto;

public interface MyPageBiz {
	
	public MemberDto MySelect(String memeber_id);
	public Boolean updatePW(MemberDto dto);
	public Boolean MyDelete(String member_id);
	public String selectPW(String member_id);
	
	public List<PaymentDto> PayMentList(String member_id);
	public Boolean PayMentDelete(int pay_num);
	
	public List<WishDto> WishList(String member_id);
	public Boolean WishDelete(int wish_no);
}
