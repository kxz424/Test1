package com.kgs7276.board.aop;

import java.util.Arrays;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

@Component
@Aspect
public class SampleAdvice {
	
	private static final Logger logger = LoggerFactory.getLogger(SampleAdvice.class);
	
	@Before("execution(* com.kgs7276.board.service.MessageService*.*(..))")
	public void startLog() {
		
		logger.info("----------------------------------------");
		logger.info("--------------이것은 before--------------");
		
	}
	
	@After("execution(* com.kgs7276.board.service.MessageService*.*(..))")
	public void endLog() {
		
		logger.info("---------------이것은 after---------------");
		logger.info("-----------------------------------------");
		
	}
	
	@Around("execution(* com.kgs7276.board.service.MessageService*.*(..))")
	public Object timeLog(ProceedingJoinPoint pjp) throws Throwable {
		
		long startTime = System.currentTimeMillis();
		logger.info(Arrays.toString(pjp.getArgs()));
//		logger.info(pjp.getKind());
		
		Object result = pjp.proceed();
		
		long endTime = System.currentTimeMillis();
//		logger.info(pjp.getSignature().getName() + " : " + (endTime - startTime));
		logger.info("===========================================");
		
		return result;
		
	}

}
