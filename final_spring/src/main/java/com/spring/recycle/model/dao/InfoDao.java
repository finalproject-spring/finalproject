package com.spring.recycle.model.dao;

import java.util.List;

import com.spring.recycle.model.dto.InfoDto;

public interface InfoDao {
	
	String NAMESPACE = "info.";
	
	public List<InfoDto> infoList();

}
