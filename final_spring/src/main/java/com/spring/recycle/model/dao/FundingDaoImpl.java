package com.spring.recycle.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import com.spring.recycle.model.dto.FundingDto;
import com.spring.recycle.util.FundingCriteria;
import com.spring.recycle.util.FundingSearchCriteria;

@Repository
public class FundingDaoImpl implements FundingDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	@Override
	public FundingDto fundingDetail(int funding_no) {
		FundingDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"detail", funding_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
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
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"update", dto);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int fundingDelete(int funding_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE + "delete", funding_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<FundingDto> fundingFilter(String funding_filter) {
		List<FundingDto> list = new ArrayList<FundingDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "filter", funding_filter);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<FundingDto> fundingList(FundingSearchCriteria scri) {
		List<FundingDto> list = new ArrayList<FundingDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "selectList", scri);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int listCount(FundingSearchCriteria scri) {
		int res = 0;	
		try {
			res = sqlSession.selectOne(NAMESPACE+"listCount",scri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<FundingDto> fundingAll() {
		List<FundingDto> list = new ArrayList<FundingDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "selctAll");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int caUpdate(FundingDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE + "caUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int cancelCaUpdate(FundingDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"cancelCaUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

}
