package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.FundingDao;
import com.spring.recycle.model.dto.FundingDto;

@Service
public class FundingBizImpl implements FundingBiz {

	@Autowired
	private FundingDao dao;
	
	@Override
	public List<FundingDto> fundingList() {

		return dao.fundingList();
	}

	@Override
	public FundingDto fundingDetail(int funding_no) {

		return dao.fundingDetail(funding_no);
	}

	@Override
	public int fundingInsert(FundingDto dto) {
		
		return dao.fundingInsert(dto);
	}

	@Override
	public int fundingUpdate(FundingDto dto) {
		
		return dao.fundingUpdate(dto);
	}

	@Override
	public int fundingDelete(int funding_no) {

		return dao.fundingDelete(funding_no);
	}

}
