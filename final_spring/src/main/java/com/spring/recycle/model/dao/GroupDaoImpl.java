
package com.spring.recycle.model.dao;

import java.util.ArrayList;
import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dto.GroupDto;


@Repository
public class GroupDaoImpl implements GroupDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	

	@Override
	public List<GroupDto> list() {
		List<GroupDto> list = new ArrayList<GroupDto>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"list");
		} catch (Exception e) {
			System.out.println("[ERROR]:SELECT LIST");
			e.printStackTrace();
		}
	
		return list;
	}

	@Override
	public GroupDto view(int board_no) {
		GroupDto dto = null;
		
		dto = sqlSession.selectOne(NAMESPACE+"view",board_no);
		return dto;
	}

	@Override
	public int write(GroupDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"write",dto);
		} catch (Exception e) {
						e.printStackTrace();
		}
		return res;
	}

	@Override
	public int modify(GroupDto dto) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"modify",dto);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
				
		return res;
	}

	@Override
	public int delete(String board_no) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"delete",board_no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int viewCount(int board_no) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"viewcount",board_no);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}


	

}
