package com.spring.recycle.util;

public class FundingSearchCriteria extends FundingCriteria{

	private String funding_filter = "";
	 

	public String getFunding_filter() {
		return funding_filter;
	}
	public void setFunding_filter(String funding_filter) {
		this.funding_filter = funding_filter;
	}
	@Override
	public String toString() {
		return "SearchCriteria funding_filter=" + funding_filter + "]";
	}
}
