package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.EventDao;
import com.spring.recycle.model.dto.EventDto;
import com.spring.recycle.util.EventSearchCriteria;
@Service
public class EventBizImpl implements EventBiz {

	@Autowired
	private EventDao dao;
	

	@Override
	public EventDto view(int board_no) {
		return dao.view(board_no);
	}

	@Override
	public int write(EventDto dto) {
		return dao.write(dto);
	}

	@Override
	public int modify(EventDto dto) {
		return dao.modify(dto);
	}

	@Override
	public int delete(String event_no) {
		return dao.delete(event_no);
	}

	@Override
	public List<EventDto> list(EventSearchCriteria scri) {
		// TODO Auto-generated method stub
		return dao.list(scri);
	}

	@Override
	public int listCount(EventSearchCriteria scri) {
		// TODO Auto-generated method stub
		return dao.listCount(scri);
	}

	@Override
	public List<EventDto> listAll() {
		// TODO Auto-generated method stub
		return dao.listAll();
	}

	@Override
	public int eventCount() {
		// TODO Auto-generated method stub
		return dao.eventCount();
	}

}
