package com.spring.recycle.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.GroupReplyDto;
import com.spring.recycle.paging.Criteria;
import com.spring.recycle.paging.SearchCriteria;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	
	@Override
	public List<BoardDto> qnaList(SearchCriteria scri) {
		List<BoardDto> list = new ArrayList<>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"qnaList", scri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public BoardDto qnaDetail(int board_no) {
		BoardDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE+"qnaDetail", board_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int qnaInsert(BoardDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"qnaInsert", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int qnaUpdate(BoardDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"qnaUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int qnaDelete(int board_no) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"qnaDelete", board_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("dao : " + board_no +"\n" + res);
		return res;
	}

	@Override
	public int qnaListCount(SearchCriteria scri) {
		int res = 0;
		
		try {
			res = sqlSession.selectOne(NAMESPACE+"qnaListCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int qnaReply(GroupReplyDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESPACE+"qnaReply", dto);
		} catch (Exception  e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int qnaReplyDelete(int reply_no) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"qnaReplyDelete", reply_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

}
