
package com.spring.recycle.util;
public class GroupSearchCriteria  extends GroupCriteria{
	
	private String board_filter="";

	public String getBoard_filter() {
		return board_filter;
	}

	public void setBoard_filter(String board_filter) {
		this.board_filter = board_filter;
	}

	@Override
	public String toString() {
		return "SearchCriteria board_filter=" + board_filter + "]";
	}
	
	
	
	
	
	
}
