package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.GroupReplyDto;

public interface GroupReplyDao {
	String NAMESAPCE = "groupreply.";
	
	//댓글조회
	public List<GroupReplyDto> readReply(int board_no);
	//댓글 작성
	public int writeReply(GroupReplyDto dto);
	//댓글 삭제 
	public int deleteReply(int reply_no);

}
