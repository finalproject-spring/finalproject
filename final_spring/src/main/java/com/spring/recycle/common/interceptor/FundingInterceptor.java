package com.spring.recycle.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class FundingInterceptor implements HandlerInterceptor {
	
	private Logger logger = LoggerFactory.getLogger(FundingInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("[Interceptor] : preHandle");
		
		// spring 3.2 이상부터는 servlet=contextl.xml에서 <exclude-mapping-path>를 통해 설정 가능!
		if(request.getRequestURI().contains("/loginform.do") || // "" 이런글자를 담고있는 uri라면...
		   request.getRequestURI().contains("/ajaxlogin.do") ||
		   request.getSession().getAttribute("login") != null // 세션에 로그인 값이 널이 아니라면
		   ) {
			return true; // 이 조건이면 보내줄거야
		}
		
		return false;
	}
	
	

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("[Interceptor] : postHandle");
		
		if (modelAndView != null) {
			logger.info("Target View : " + modelAndView.getViewName());
		}
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.info("[Interceptor] : afterCompletion");
	}

}
