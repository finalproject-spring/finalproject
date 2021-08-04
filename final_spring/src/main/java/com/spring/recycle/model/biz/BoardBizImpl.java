package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.BoardDao;
import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.GroupReplyDto;
import com.spring.recycle.paging.Criteria;
import com.spring.recycle.paging.SearchCriteria;
@Service
public class BoardBizImpl implements BoardBiz {

	@Autowired
	private BoardDao dao;
	
	@Override
	public List<BoardDto> qnaList(SearchCriteria scri) {
		return dao.qnaList(scri);
	}

	@Override
	public BoardDto qnaDetail(int board_no) {
		return dao.qnaDetail(board_no);
	}

	@Override
	public int qnaInsert(BoardDto dto) {
		return dao.qnaInsert(dto);
	}

	@Override
	public int qnaUpdate(BoardDto dto) {
		return dao.qnaUpdate(dto);
	}

	@Override
	public int qnaDelete(int board_no) {
		return dao.qnaDelete(board_no);
	}

	@Override
	public int qnaListCount(SearchCriteria scri) {
		return dao.qnaListCount(scri);
	}

	@Override
	public int qnaReply(GroupReplyDto dto) {
		return dao.qnaReply(dto);
	}

	@Override
	public int qnaReplyDelete(int reply_no) {
		return dao.qnaReplyDelete(reply_no);
	}

}
