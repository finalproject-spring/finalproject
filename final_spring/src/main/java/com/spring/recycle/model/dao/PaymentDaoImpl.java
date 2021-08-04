package com.spring.recycle.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.paging.SearchCriteria;

@Repository
public class PaymentDaoImpl implements PaymentDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public List<PaymentDto> paymentList(SearchCriteria scri) {
		List<PaymentDto> list = new ArrayList<>();
		try {
			list = sqlSession.selectList(NAMESPACE+"paymentList", scri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<PaymentDto> paymentCancelList() {
		List<PaymentDto> list = new ArrayList<>();
		try {
			list = sqlSession.selectList(NAMESPACE+"paymentCancelList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int listCount(SearchCriteria scri) {
		int res = 0;
		try {
			res = sqlSession.selectOne(NAMESPACE+"listCount", scri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int paymentCancelCount() {
		int res = 0;
		try {
			res = sqlSession.selectOne(NAMESPACE+"paymentCancelCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}
	
	@Override
	public int paymentInsert(PaymentDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"payment_insert",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<PaymentDto> paymentList() {
		List<PaymentDto> list = new ArrayList<PaymentDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"payment_list");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public PaymentDto paymentDetail(int pay_num) {
		PaymentDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"paymentDetail", pay_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int paymentCancelSuccess(int pay_num) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"paymentCancelSuccess", pay_num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public PaymentDto paymentDetail2(String merchant_uid) {
		System.out.println("dao의 " + merchant_uid);
		PaymentDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"paymentDetail2", merchant_uid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("dao의" + dto);
		return dto;
	}

}
