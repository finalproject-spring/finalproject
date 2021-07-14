package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.DealDao;
import com.spring.recycle.model.dto.DealBoardDto;

@Service
public class DealBizImpl implements DealBiz {

	@Autowired
	private DealDao dao;
	
	@Override
	public List<DealBoardDto> DealList() {
		return dao.DealList();
	}

	@Override
	public DealBoardDto selectDeal(int board_no) {
		return dao.selectDeal(board_no);
	}
	
	@Override
	public boolean InsertDeal(DealBoardDto dto) {
		if(dao.InsertDeal(dto) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public boolean updateDeal(DealBoardDto dto) {
		if(dao.updateDeal(dto) == 1) {
			return true;
		}
		return false;
	}

	@Override
	public boolean DeleteDeal(int Board_no) {
		if(dao.DeleteDeal(Board_no) == 1) {
			return true;
		}
		return false;
	}


}
