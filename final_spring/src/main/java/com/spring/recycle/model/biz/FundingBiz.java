package com.spring.recycle.model.biz;

import java.util.List;

import com.spring.recycle.model.dto.FundingDto;

public interface FundingBiz {
	
	public List<FundingDto> fundingList();
	public FundingDto fundingDetail(int funding_no);
	public int fundingInsert(FundingDto dto);
	public int fundingUpdate(FundingDto dto);
	public int fundingDelete(int funding_no);

}
