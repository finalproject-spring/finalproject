package com.spring.recycle.model.biz;

import java.util.List;

import javax.inject.Inject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.GroupDao;
import com.spring.recycle.model.dto.GroupDto;
import com.spring.recycle.util.GroupSearchCriteria;




@Service
public class GroupBizImpl implements GroupBiz {

	@Autowired
	GroupDao dao;
	
	

	@Override
	public GroupDto view(int board_no) {
		// TODO Auto-generated method stub
		return dao.view(board_no);
	}

	@Override
	public int write(GroupDto dto) {
		// TODO Auto-generated method stub
		return dao.write(dto);
	}

	@Override
	public int modify(GroupDto dto) {
		// TODO Auto-generated method stub
		return dao.modify(dto);
	}

	@Override
	public int delete(String board_no) {
		// TODO Auto-generated method stub
		return dao.delete(board_no);
	}

	@Override
	public int viewCount(int board_no) {
		// TODO Auto-generated method stub
		return dao.viewCount(board_no);
	}

	

	@Override
	public List<GroupDto> board_filter(String board_filter) {
		// TODO Auto-generated method stub
		return dao.board_filter(board_filter);
	}

	@Override
	public List<GroupDto> boardList(GroupSearchCriteria scri) {
		// TODO Auto-generated method stub
		return dao.boardList(scri);
	}

	@Override
	public int listCount(GroupSearchCriteria scri) {
		// TODO Auto-generated method stub
		return dao.listCount(scri);
	}

	@Override
	public int boardCount() {
		// TODO Auto-generated method stub
		return dao.boardCount();
	}


	


}
