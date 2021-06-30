package com.spring.recycle.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.spring.recycle.model.dto.FundingDto;

@Repository
public class FundingDaoImpl implements FundingDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<FundingDto> fundingList() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public FundingDto fundingDetail(int funding_no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int fundingInsert(FundingDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE + "insert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int fundingUpdate(FundingDto dto) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int fundingDelete(int funding_no) {
		// TODO Auto-generated method stub
		return 0;
	}

}
