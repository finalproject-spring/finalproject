package com.spring.recycle.model.biz;

import java.util.List;

import com.spring.recycle.model.dto.GroupDto;


public interface GroupBiz {

	String NAMESPACE="group.";
	
	//목록
	public List<GroupDto> list();
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
}
