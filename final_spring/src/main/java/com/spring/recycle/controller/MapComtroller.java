package com.spring.recycle.controller;

import java.io.FileReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.core.io.FileSystemResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MapComtroller {

	@RequestMapping("/map.do")
	public String goMap() {
		
		return "map/map";
	}
	
	@RequestMapping(value = "/data.do", method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String, String>> dataJson(HttpServletRequest request, String si, String sido) {
		String path = request.getSession().getServletContext().getRealPath("/resources/json") + "/data.json";
		JSONParser parser = new JSONParser();
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		try {
			System.out.println(path);
			JSONObject docs = (JSONObject) parser.parse(new FileReader(path));
			if (docs == null) {System.out.println("doc가 비었다!");}
			// System.out.println(docs.keySet());
			JSONArray row = (JSONArray) docs.get("data");
			if (row == null) {System.out.println("row가 비었다!");}
			//System.out.println(row.size());
			for(int i = 0 ; i < row.size(); i++) {
				JSONObject data = (JSONObject) row.get(i);
				if(si.equals(data.get("RELAX_SI_NM").toString()) && sido.equals(data.get("RELAX_SIDO_NM").toString())) {
					Map<String, String> map = new HashMap<>();
					map.put("name", data.get("RELAX_RSTRNT_NM").toString());
					map.put("addr", data.get("RELAX_ADD1").toString());
					list.add(map);
				}
			}
			System.out.println(list.size());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
