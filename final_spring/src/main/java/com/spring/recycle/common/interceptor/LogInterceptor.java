package com.spring.recycle.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class LogInterceptor implements HandlerInterceptor {
	
	private Logger logger = LoggerFactory.getLogger(LogInterceptor.class);
	
	// controller로 보내기 전 이벤트 작동
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		logger.info("[Interceptor] : preHandle");
		logger.info(" Class       \t:  " + handler.getClass());
		logger.info(" Request URI \t:  " + request.getRequestURI());
		logger.info(" Servlet URI \t:  " + request.getServletPath());
		
		
		if(request.getRequestURI().contains("/message") ||
			request.getRequestURI().contains("/login") ||
			request.getSession().getAttribute("dto") != null
			
				) {
			
			return true; 
		}
		
/*	if (request.getSession().getAttribute("dto") == null
			) {
			response.sendRedirect("login_loginform.do");
		}*/
		return true;
	}

	// comtroller 처리 이후 이벤트 작동
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		logger.info("[Interceptor] : postHandle");
		
		if (modelAndView != null) {
			logger.info("Target View : " + modelAndView.getViewName());
		}
		
	}

	// view 처리 이후 이벤트 작동
	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		logger.info("[Interceptor] : afterCompletion");
	}

}
