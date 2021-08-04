package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.FundingDao;
import com.spring.recycle.model.dto.FundingDto;
import com.spring.recycle.util.FundingCriteria;
import com.spring.recycle.util.FundingSearchCriteria;

@Service
public class FundingBizImpl implements FundingBiz {

	@Autowired
	private FundingDao dao;

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

	@Override
	public List<FundingDto> fundingFilter(String funding_filter) {
		
		return dao.fundingFilter(funding_filter);
	}


	@Override
	public List<FundingDto> fundingList(FundingSearchCriteria scri) {
		return dao.fundingList(scri);
	}

	@Override
	public int listCount(FundingSearchCriteria scri) {
		return dao.listCount(scri);
	}

	@Override
	public List<FundingDto> fundingAll() {
		// TODO Auto-generated method stub
		return dao.fundingAll();
	}

	@Override
	public int caUpdate(FundingDto dto) {
		// TODO Auto-generated method stub
		return dao.caUpdate(dto);
	}

	@Override
	public int cancelCaUpdate(FundingDto dto) {
		// TODO Auto-generated method stub
		return dao.cancelCaUpdate(dto);
	}



}
