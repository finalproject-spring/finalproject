package com.spring.recycle.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recycle.model.dto.MessageDto;
import com.spring.recycle.paging.Criteria;

@Repository
public class MessageDaoImpl implements MessageDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int insertRecvMessage(MessageDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"insertRecvMessage", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public int insertSendMessage(MessageDto dto) {
		int res = 0;
		try {
			res = sqlSession.insert(NAMESPACE+"insertSendMessage", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public String unreadMsgCount(String message_recvid) {
		String count = null;
		try {
			count = sqlSession.selectOne(NAMESPACE+"unreadMsgCount", message_recvid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public MessageDto recvDetail(int message_no) {
		MessageDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"recvDetail", message_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public MessageDto sendDetail(int message_no) {
		MessageDto dto = null;
		try {
			dto = sqlSession.selectOne(NAMESPACE+"sendDetail", message_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int updateMessage(int message_no) {
		int res = 0;
		try {
			res = sqlSession.update(NAMESPACE+"updateMessage", message_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

	@Override
	public List<MessageDto> getRecvMessagelist(HashMap<String, Object> map) {
		List<MessageDto> list = null;
		Criteria cri = (Criteria) map.get("cri");
		map.put("rowstart", cri.getRowStart());
		map.put("rowend", cri.getRowEnd());
		
		try {
			list = sqlSession.selectList(NAMESPACE+"getRecvMessage", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public List<MessageDto> getSendMessagelist(HashMap<String, Object> map) {
		List<MessageDto> list = null;
		Criteria cri = (Criteria) map.get("cri");
		map.put("rowstart", cri.getRowStart());
		map.put("rowend", cri.getRowEnd());
		
		try {
			list = sqlSession.selectList(NAMESPACE+"getSendMessage", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int recvListCount(String message_recvid) {
		int count = 0;
		try {
			count = sqlSession.selectOne(NAMESPACE+"getRecvMessageCount", message_recvid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int sendListCount(String message_sendid) {
		int count = 0;
		try {
			count = sqlSession.selectOne(NAMESPACE+"getSendMessageCount", message_sendid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}

	@Override
	public int idCheck(String member_id) {
		int res = 0;
		try {
			res = sqlSession.selectOne(NAMESPACE + "idCheck", member_id);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int MultiDeleteRecvMessage(int[] message_noList) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"multiDeleteMessage", message_noList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int MultiDeleteSendMessage(int[] message_noList) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"multiDeleteMessage", message_noList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int deleteRecvMessage(int message_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteMessage", message_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}

	@Override
	public int deleteSendMessage(int message_no) {
		int res = 0;
		try {
			res = sqlSession.delete(NAMESPACE+"deleteMessage", message_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return res;
	}


}

