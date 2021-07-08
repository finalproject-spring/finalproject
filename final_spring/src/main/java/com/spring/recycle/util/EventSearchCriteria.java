package com.spring.recycle.util;

public class EventSearchCriteria extends EventCriteria {
	
	
	private String searchType = "";
	private String keyword = "";


	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	@Override
	public String toString() {
		return "EventSearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}

	
	
}