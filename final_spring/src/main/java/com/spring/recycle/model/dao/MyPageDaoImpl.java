package com.spring.recycle.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.model.dto.WishDto;

@Repository
public class MyPageDaoImpl implements MyPageDao {

	@Autowired
	SqlSessionTemplate sqlsession;
	
	@Override
	public MemberDto MySelect(String member_id) {
		MemberDto res = null;
		try {
			res = sqlsession.selectOne(NAMESPACE + "select", member_id); // dto에 담겨있어 필요없을듯
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int updatePW(MemberDto dto) {
		int res = 0;
		try {
			res = sqlsession.update(NAMESPACE + "updatePW", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	public String selectPW(String member_id) {
		String res = null;
		try {
			res = sqlsession.selectOne(NAMESPACE + "selectPW", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	@Override
	public int MyDelete(String member_id) {
		int res = 0;
		try {
			res = sqlsession.update(NAMESPACE + "delete", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<PaymentDto> PayMentList(String member_id) {
		List<PaymentDto> res = null;
		try {
			res = sqlsession.selectList(NAMESPACE + "payMentList", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int PayMentDelete(int pay_num) {
		int res = 0;
		try {
			res = sqlsession.update(NAMESPACE + "payMentDelete", pay_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<WishDto> WishList(String member_id) {
		List<WishDto> res = null;
		try {
			res = sqlsession.selectList(NAMESPACE + "wishList", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int WishDelete(int wish_no) {
		int res = 0;
		try {
			res = sqlsession.delete(NAMESPACE + "wishDelete", wish_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

}
