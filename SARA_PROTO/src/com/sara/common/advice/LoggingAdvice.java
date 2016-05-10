package com.sara.common.advice;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.aopalliance.intercept.MethodInterceptor;
import org.aopalliance.intercept.MethodInvocation;

public class LoggingAdvice implements MethodInterceptor {
	protected final Log logger = LogFactory.getLog(getClass());

	@Override
	public Object invoke(MethodInvocation invocation) throws Throwable {

		String className = invocation.getThis().getClass().getName();

		if (logger.isDebugEnabled()) {
			logger.debug(className + "." + invocation.getMethod().getName()
					+ "()" + " Start!");
			Object[] args = invocation.getArguments();
			if ((args != null) && (args.length > 0)) {
				for (int i = 0; i < args.length; i++) {
					logger.debug("Argument[" + i + "] : " + args[i]);
				}
			}
		}

		Object retVal = invocation.proceed();

		if (logger.isDebugEnabled()) {
			logger.debug(className + "." + invocation.getMethod().getName()
					+ "()" + " End!");
		}

		return retVal;
	}

}
