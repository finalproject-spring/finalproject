package com.spring.recycle.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MainController {
	
	@RequestMapping("/main.do")
	public String goMain() {
		return "main/main";
	}
	
	@ResponseBody
	@RequestMapping(value = "/main_crawling.do")
	public List<Integer> fintDust() throws UnsupportedEncodingException {
		String url = "https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&qvt=0&query=" + URLEncoder.encode("전국미세먼지","UTF-8");
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get();
		} catch (IOException e) {
			e.printStackTrace();
		}
		Element element = doc.select("div.tb_scroll tbody").first();    
		Elements element2 = element.select("td span");
		String str = element2.toString();
		String str2 = Jsoup.parse(str).text();
		String intStr = str2.replaceAll("[^0-9]", " ");
		String intStr2 = intStr.replaceAll("       ", ",");
		String intStr3 = intStr2.replaceAll("      ", "");
		
		String count[] = intStr3.split(",");
	    List<Integer> list = new ArrayList<>();
	    for(int i=0; i < count.length; i++) {
	    	list.add(Integer.parseInt(count[i]));
	    }
	    list.remove(14);
	    list.remove(13);
	    list.remove(11);
	    list.remove(9);
	    list.remove(8);
	    list.remove(6);
	    list.remove(5);
	    list.remove(4);
	    list.remove(2);

	    return list;
	}

}
