package com.spring.recycle.model.biz;

import java.util.List;

import com.spring.recycle.model.dto.DealBoardDto;

public interface DealBiz {
	
	public List<DealBoardDto> DealList();
	public DealBoardDto selectDeal(int board_no); // 거랫글 보기
	public boolean InsertDeal(DealBoardDto dto); // 거랫글 생성
	public boolean updateDeal(DealBoardDto dto); // 거랫글 수정
	public boolean DeleteDeal(int Board_no); // 거랫글 삭제
}
