package com.spring.recycle.model.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.MemberDto;
import com.spring.recycle.model.dto.PaymentDto;
import com.spring.recycle.paging.Criteria;
import com.spring.recycle.paging.SearchCriteria;


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
	      
	      System.out.println("dao res : " + res);
	      
	      return res;
	   }

	   @Override
	   public int idCheck(String member_id) {
	      
	      int res = sqlSession.selectOne(NAMESPACE+"idCheck",member_id);
	      return res;
	   }

	@Override
	public List<MemberDto> memberList() {
		List<MemberDto> list = new ArrayList<>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"memberList");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int memberCount() {
		int count = 0;
		
		try {
			count = sqlSession.selectOne(NAMESPACE+"memberCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public MemberDto memberDetail(int member_no) {
		MemberDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE+"memberDetail", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public List<BoardDto> memberwriteList(int member_no) {
		List<BoardDto> list = new ArrayList<>();
		
		try {
			list = sqlSession.selectList(NAMESPACE+"memberWriteList", member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int memberUpdate(MemberDto dto) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"memberUpdate", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int memberSelectDelete(String member_no) {
		int no = Integer.parseInt(member_no);
		int res = 0;
		
		
		try {
			res = sqlSession.update(NAMESPACE+"memberDelete", no);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int memberDelete(int member_no) {
		int res = 0;
		
		try {
			res = sqlSession.update(NAMESPACE+"memberDelete", member_no);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public BoardDto memberwriteDetail(int board_no) {
		BoardDto dto = null;
		
		try {
			dto = sqlSession.selectOne(NAMESPACE+"memberWriteDetail", board_no);
		} catch(Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int memberwriteDelete(int board_no) {
		int res = 0;
		
		try {
			res = sqlSession.delete(NAMESPACE+"memberWriteDelete", board_no);
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public MemberDto socialLogin(String member_id) {
		MemberDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"socialLogin", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int socialJoin(MemberDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"socialJoin", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("res :" + res);
		return res;
	}

	@Override
	public int socialIdCheck(String member_socialid) {
	      int res = 0;
	      try { 
	    	  res =sqlSession.selectOne(NAMESPACE+"socialIdCheck",member_socialid);
	      } catch (Exception e) {
	    	  e.printStackTrace();
	      }

	      return res;
	}

	@Override
	public String find_id(String member_email) {

		return sqlSession.selectOne(NAMESPACE+"find_id" , member_email);
	}

	@Transactional
	public int update_pw(MemberDto dto) {
		return sqlSession.update(NAMESPACE+"update_pw",dto);
	}

	@Override
	public List<MemberDto> memberListPage(SearchCriteria scri) {
		List<MemberDto> list = new ArrayList<>();
		try {
			list = sqlSession.selectList(NAMESPACE+"memberListPage", scri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int listCount(SearchCriteria scri) {
		int res = 0;
		try {
			res = sqlSession.selectOne(NAMESPACE+"listCount", scri);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public void keepLogin(String member_id, String sessionId, Date next) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("member_id", member_id);
		map.put("sessionId", sessionId);
		map.put("next", next);
		
		try {
			sqlSession.update(NAMESPACE+"keepLogin",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public MemberDto checkMemberWithSessionKey(String sessionId) {
		MemberDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"checkMemberWithSessionKey",sessionId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

}
