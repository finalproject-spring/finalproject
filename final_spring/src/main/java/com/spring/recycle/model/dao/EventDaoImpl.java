package com.spring.recycle.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.EventDto;
import com.spring.recycle.util.EventSearchCriteria;
@Repository
public class EventDaoImpl implements EventDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;



	@Override
	public EventDto view(int event_no) {
		EventDto dto = null;
		
		dto = sqlSession.selectOne(NAMESPACE+"event_view",event_no);		
		return dto;
	}

	@Override
	public int write(EventDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"event_write",dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int modify(EventDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"event_modify",dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int delete(String event_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"event_delete",event_no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<EventDto> list(EventSearchCriteria scri) {
		List<EventDto> list = new ArrayList<EventDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"event_list" ,scri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int listCount(EventSearchCriteria scri) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"listCount" ,scri);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public List<EventDto> listAll() {
		List<EventDto> list = new ArrayList<EventDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE + "listAll");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int eventCount() {
		int count = 0;
		
		try {
			count = sqlSession.selectOne(NAMESPACE+"event_count");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return count;
	}

}
