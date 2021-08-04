package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.PaymentDao;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.paging.SearchCriteria;

@Service
public class PaymentBizImpl implements PaymentBiz {

	@Autowired
	private PaymentDao dao;
	
	@Override
	public List<PaymentDto> paymentList(SearchCriteria scri) {
		return dao.paymentList(scri);
	}

	@Override
	public List<PaymentDto> paymentCancelList() {
		return dao.paymentCancelList();
	}

	@Override
	public int listCount(SearchCriteria scri) {
		return dao.listCount(scri);
	}

	@Override
	public int paymentCancelCount() {
		return dao.paymentCancelCount();
	}

	@Override
	public List<PaymentDto> paymentList() {
		// TODO Auto-generated method stub
		return dao.paymentList();
	}

	@Override
	public int paymentInsert(PaymentDto dto) {
		return dao.paymentInsert(dto);
	}

	@Override
	public PaymentDto paymentDetail(int pay_num) {
		// TODO Auto-generated method stub
		return dao.paymentDetail(pay_num);
	}

	@Override
	public int paymentCancelSuccess(int pay_num) {
		// TODO Auto-generated method stub
		return dao.paymentCancelSuccess(pay_num);
	}

	@Override
	public PaymentDto paymentDetail2(String merchant_uid) {
		// TODO Auto-generated method stub
		return dao.paymentDetail2(merchant_uid);
	}

}
