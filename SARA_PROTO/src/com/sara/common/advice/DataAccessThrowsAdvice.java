package com.sara.common.advice;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.aop.ThrowsAdvice;

import com.sara.common.exception.DataAccessException;


public class DataAccessThrowsAdvice implements ThrowsAdvice {
	protected final Log logger = LogFactory.getLog(getClass());

	public void afterThrowing(DataAccessException ex) throws Throwable {
		if (logger.isDebugEnabled()) {
			logger.debug("afterThrowing() Start!");
			logger.debug("Caught : " + ex.getClass().getName());
		}
		if (logger.isErrorEnabled()) {
			logger.error(ex.getMessage());
		}
		if (logger.isDebugEnabled()) {
			logger.debug("afterThrowing() End!");
		}
		throw ex;
	}
}
