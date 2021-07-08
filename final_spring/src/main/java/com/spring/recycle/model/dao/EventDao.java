package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.EventDto;
import com.spring.recycle.util.EventSearchCriteria;

public interface EventDao {
	
	String NAMESPACE ="event.";
	//목록
	//public List<EventDto> list();
	public List<EventDto> list(EventSearchCriteria scri);
	//조회
	public EventDto view(int board_no);
	//작성
	public int write(EventDto dto);
	//수정
	public int modify(EventDto dto);
	//삭제
	public int delete(String event_no);
	
	public int listCount(EventSearchCriteria scri);


}
