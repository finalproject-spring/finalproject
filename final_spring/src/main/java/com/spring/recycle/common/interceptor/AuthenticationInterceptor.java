package com.spring.recycle.common.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.spring.recycle.model.biz.MemberBiz;
import com.spring.recycle.model.dto.MemberDto;

public class AuthenticationInterceptor implements HandlerInterceptor {

	private Logger logger = LoggerFactory.getLogger(AuthenticationInterceptor.class);  
	
	@Autowired
    private MemberBiz biz;
     
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
    	
    	logger.info("[Interceptor] preHandle");
         
        HttpSession session = request.getSession();
        Object obj = session.getAttribute("dto");
         
        if ( obj ==null ){// 로그인된 세션이 없는 경우
            // 우리가 만들어 논 쿠키를 꺼내온다.
            Cookie loginCookie = WebUtils.getCookie(request,"loginCookie");
            if ( loginCookie !=null ){// 쿠키가 존재하는 경우
                // loginCookie의 값(저장해논 세션Id) 꺼내오기
                String sessionId = loginCookie.getValue();

                MemberDto dto = biz.checkMemberWithSessionKey(sessionId);
                if ( dto != null ){
                    session.setAttribute("dto", dto);
                }
            }
             
            return true;
        }

        return true;
    }
 
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView)throws Exception {
    }

}
