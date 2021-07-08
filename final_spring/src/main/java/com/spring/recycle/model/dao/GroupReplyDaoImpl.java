package com.spring.recycle.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.GroupReplyDto;


@Repository
public class GroupReplyDaoImpl implements GroupReplyDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<GroupReplyDto> readReply(int board_no) {
		List<GroupReplyDto> list = new ArrayList<GroupReplyDto>();
		
		try {
			list = sqlSession.selectList(NAMESAPCE+"group_readReply",board_no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int writeReply(GroupReplyDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.insert(NAMESAPCE+"group_writeReply",dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int deleteReply(int reply_no) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESAPCE+"group_deleteReply",reply_no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}

}
