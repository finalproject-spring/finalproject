package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.paging.SearchCriteria;

public interface PaymentDao {
	
	String NAMESPACE = "payment.";

	public List<PaymentDto> paymentList();
	
	public int paymentInsert(PaymentDto dto);
	// 전체 회원 결제 목록
	public List<PaymentDto> paymentList(SearchCriteria scri);
	// 결제 취소 목록
	public List<PaymentDto> paymentCancelList();
	// 전체 결제 수
	public int listCount(SearchCriteria scri);
	// 결제 취소 수
	public int paymentCancelCount();
	
	public PaymentDto paymentDetail(int pay_num);
	
	// 결제 취소 완료
	public int paymentCancelSuccess(int pay_num);
	
	public PaymentDto paymentDetail2(String merchant_uid);

}
