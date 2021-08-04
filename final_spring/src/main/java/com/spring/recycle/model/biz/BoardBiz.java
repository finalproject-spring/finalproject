package com.spring.recycle.model.biz;

import java.util.List;

import com.spring.recycle.model.dto.BoardDto;
import com.spring.recycle.model.dto.GroupReplyDto;
import com.spring.recycle.paging.SearchCriteria;

public interface BoardBiz {
	
	// 목록
	public List<BoardDto> qnaList(SearchCriteria cri);
	// 게시글 개수
	public int qnaListCount(SearchCriteria scri);
	// 조회
	public BoardDto qnaDetail(int board_no);
	// 작성
	public int qnaInsert(BoardDto dto);
	// 수정
	public int qnaUpdate(BoardDto dto);
	// 삭제
	public int qnaDelete(int board_no);
	// 댓글
	public int qnaReply(GroupReplyDto dto);
	// 댓글 삭제
	public int qnaReplyDelete(int reply_no);

}
