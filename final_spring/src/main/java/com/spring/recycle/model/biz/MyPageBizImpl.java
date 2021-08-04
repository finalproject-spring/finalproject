package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.MyPageDao;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.model.dto.WishDto;

@Service
public class MyPageBizImpl implements MyPageBiz {

	@Autowired
	MyPageDao dao;
	
	@Override
	public MemberDto MySelect(String memeber_id) {
		return dao.MySelect(memeber_id);
	}

	@Override
	public Boolean updatePW(MemberDto dto) {
		if(dao.updatePW(dto) == 1) {
			return true;
		}
		return false;
	}
	
	public String selectPW(String member_id) {
		return dao.selectPW(member_id);
	}

	@Override
	public Boolean MyDelete(String member_id) {
		if(dao.MyDelete(member_id) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public List<PaymentDto> PayMentList(String member_id) {
		return dao.PayMentList(member_id);
	}

	@Override
	public Boolean PayMentDelete(int pay_num) {
		if(dao.PayMentDelete(pay_num) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public List<WishDto> WishList(String member_id) {
		return dao.WishList(member_id);
	}

	@Override
	public Boolean WishDelete(int wish_no) {
		if(dao.WishDelete(wish_no) == 1) {
			return true;
		}
		return false;
	}

}
