package com.spring.recycle.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.MemberDto;


@Repository
public class MemberDaoImpl implements MemberDao {
	
	
	@Autowired
	private SqlSessionTemplate sqlSessionTemplate;

	 @Autowired
	   private SqlSessionTemplate sqlSession;

	   @Override
	   public MemberDto login(MemberDto dto) {
	      
	      MemberDto res = null;
	      try {
	         res = sqlSession.selectOne(NAMESPACE+"login",dto);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      return res;
	   }

	   @Override
	   public int join(MemberDto dto) {
	      int res = 0;
	      
	      try {
	         res = sqlSession.insert(NAMESPACE+"join",dto);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	      return res;
	   }

	   @Override
	   public int idCheck(String member_id) {
	      
	      int res = sqlSession.selectOne(NAMESPACE+"idCheck",member_id);
	      return res;
	   }


	
}
