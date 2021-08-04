package com.spring.recycle.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class LogFilter implements Filter {
	
	private Logger logger = LoggerFactory.getLogger(LogFilter.class);

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		
			HttpServletRequest req = (HttpServletRequest) request;
					
				String remoteAddr = req.getRemoteAddr(); // 클라이언트 (웹서버로 정보를 요청한 웹브라우저의) 컴퓨터 id 주소
				String uri = req.getRequestURI(); //컨텍스트경로 + 서블릿경로
				// 프로토콜 이름에서 HTTP 요청의 첫 번째 줄에 있는 쿼리 문자열까지 이 요청의 URL 부분을 반환
				String url = req.getRequestURL().toString(); // 프로토콜 + 도메인 + 포트번호 + 컨텍스트 경로 + 서블릿 경로
				// 클라이언트가 요청을 만드는데 사용한 url 재구성
				String queryString = req.getQueryString();
					
				String referer = req.getHeader("referer"); // 지정된 이름의 헤더값을 문자열로 반환
				String agent = req.getHeader("User-Agent"); // 사용자 정보
				
				StringBuffer sb = new StringBuffer();
				
				sb.append("FILTER START\n")
				  .append("* remoteAddr : " + remoteAddr + "\n")
				  .append("* uri : " + uri + "\n")
				  .append("* url : " + url + "\n")
				  .append("* queryString : " + queryString + "\n")
				  .append("* referer : " + referer + "\n")
				  .append("* agent : "  + agent + "\n")
				  .append("FILTER END");
					
				logger.info("\n"+sb);
					

				chain.doFilter(request, response);

	}
	
	@Override
	public void destroy() {
	}

}
