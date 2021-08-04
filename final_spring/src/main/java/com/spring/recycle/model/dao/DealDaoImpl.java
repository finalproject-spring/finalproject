package com.spring.recycle.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.DealBoardDto;

@Repository
public class DealDaoImpl implements DealDao {

	@Autowired
	SqlSessionTemplate sqlsession;
	
	@Override
	public List<DealBoardDto> DealList() {
		List<DealBoardDto> list = null;
		try {
			list = sqlsession.selectList(NAMESPACE + "dealBoardList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public DealBoardDto selectDeal(int board_no) {
		DealBoardDto dto = null;
		try {
			dto = sqlsession.selectOne(NAMESPACE + "selectDealBoard", board_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public int InsertDeal(DealBoardDto dto) {
		int res = 0;
		try {
			res = sqlsession.insert(NAMESPACE + "insertDealBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int updateDeal(DealBoardDto dto) {
		int res = 0;
		try {
			res = sqlsession.update(NAMESPACE + "updateDealBoard", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int DeleteDeal(int board_no) {
		int res = 0;
		try {
			res = sqlsession.delete(NAMESPACE + "delateDealBoard", board_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}


}
