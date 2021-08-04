package com.spring.recycle.model.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.InfoDto;

@Repository
public class InfoDaoImpl implements InfoDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public List<InfoDto> infoList() {
		List<InfoDto> list = new ArrayList<InfoDto>();
		try {
			list = sqlSession.selectList(NAMESPACE+"infoList");
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
