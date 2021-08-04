package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.FundingDto;
import com.spring.recycle.util.FundingCriteria;
import com.spring.recycle.util.FundingSearchCriteria;

public interface FundingDao {
	
	String NAMESPACE = "funding.";
	
	public FundingDto fundingDetail(int funding_no);
	public int fundingInsert(FundingDto dto);
	public int fundingUpdate(FundingDto dto);
	public int fundingDelete(int funding_no);
	public List<FundingDto> fundingFilter(String funding_filter);
	

	public List<FundingDto> fundingList(FundingSearchCriteria scri);
	public int listCount(FundingSearchCriteria scri);
	// funding 전체 리스트 추가
	public List<FundingDto> fundingAll();
	// funding 결제 금액 업데이트
	public int caUpdate(FundingDto dto);
	// funding 결제 취소 금액 업데이트
	public int cancelCaUpdate(FundingDto dto);
}
