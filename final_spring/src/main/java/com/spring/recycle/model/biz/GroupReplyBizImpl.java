
package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.GroupReplyDao;
import com.spring.recycle.model.dto.GroupReplyDto;

@Service
public class GroupReplyBizImpl implements GroupReplyBiz {
	
	@Autowired
	private GroupReplyDao dao;

	@Override
	public List<GroupReplyDto> readReply(int board_no) {
		// TODO Auto-generated method stub
		return dao.readReply(board_no);
	}

	@Override
	public int writeReply(GroupReplyDto dto) {
		// TODO Auto-generated method stub
		return dao.writeReply(dto);
	}

	@Override
	public int deleteReply(int reply_no) {
		// TODO Auto-generated method stub
		return dao.deleteReply(reply_no);
	}

}
