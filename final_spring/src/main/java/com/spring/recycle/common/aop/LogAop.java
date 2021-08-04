package com.spring.recycle.common.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class LogAop {
	
	private static final Logger logger = LoggerFactory.getLogger(LogAop.class);

	@Around("execution(public * com.spring.recycle.controller.*Controller*.*(..))"
			+"execution(public * com.spring.recycle.model.dao.*Dao*.*(..))"
			+"execution(public * com.spring.recycle.model.biz.*Biz*.*(..))")
	public Object logPrint(ProceedingJoinPoint proceedingJoinPoint) throws Throwable {
		
		long start = System.currentTimeMillis();
		
		Object result = proceedingJoinPoint.proceed();
		
		String type = proceedingJoinPoint.getSignature().getDeclaringTypeName();
		String name = "";
		
		if (type.contains("Controller")) {
			name = "Controller : ";
		} else if (type.contains("Biz")) {
			name = "Biz : ";
		} else if (type.contains("Dao")) {
			name = "Dao : ";
		}
		
		long end = System.currentTimeMillis();
		logger.info("--------------------AOP START--------------------");
		logger.info(name + type  + "." + proceedingJoinPoint.getSignature().getName() + "()");
		logger.info("Argument/Parameter : " + Arrays.toString(proceedingJoinPoint.getArgs()));
		logger.info("Running Time : " + (end-start));
		logger.info("--------------------AOP END--------------------");
		
		return result;
	}

}
