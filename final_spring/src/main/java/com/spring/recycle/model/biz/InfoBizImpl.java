package com.spring.recycle.model.biz;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.recycle.model.dao.InfoDao;
import com.spring.recycle.model.dao.InfoDaoImpl;
import com.spring.recycle.model.dto.InfoDto;

@Service
public class InfoBizImpl implements InfoBiz {
	
	@Autowired
	private InfoDao dao;

	@Override
	public List<InfoDto> infoList() {
		return dao.infoList();
	}

}
