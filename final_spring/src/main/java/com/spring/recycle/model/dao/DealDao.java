package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.DealBoardDto;

public interface DealDao {

	String NAMESPACE = "Deal.Board.";
	
	public List<DealBoardDto> DealList();
	public int InsertDeal(DealBoardDto dto); // 거랫글 생성
	public int updateDeal(DealBoardDto dto); // 거랫글 수정
	public int DeleteDeal(int Board_no); // 거랫글 삭제
	public DealBoardDto selectDeal(int board_no);
}
