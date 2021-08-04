package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.GroupDto;
import com.spring.recycle.util.GroupSearchCriteria;




public interface GroupDao {
	
	String NAMESPACE="group.";
	
	//조회
	public GroupDto view(int board_no);
	//작성
	public int write(GroupDto dto);
	//수정
	public int modify(GroupDto dto);
	//삭제
	public int delete(String board_no);
	//조회수 
	public int viewCount(int board_no);
	
	public List<GroupDto> board_filter(String board_filter);
	
	public List<GroupDto> boardList(GroupSearchCriteria scri);
	
	public int listCount(GroupSearchCriteria scri);
	
	//전체 게시물 수 
	public int boardCount();
	
}
