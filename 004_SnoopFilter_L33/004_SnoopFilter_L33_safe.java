package com.logger.app;
import java.io.IOException;

import javax.servlet.*;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import java.util.regex.Pattern;



public class SnoopFilter implements javax.servlet.Filter  {

	// Pattern to remove line breaks and carriage returns to prevent log injection
	private static final Pattern LOG_SANITIZER = Pattern.compile("[\r\n\t]");
	
	/**
	 * Sanitizes input to prevent log injection attacks by removing line breaks
	 * and carriage returns that could be used to forge log entries
	 */
	private String sanitizeForLogging(String input) {
		if (input == null) {
			return "null";
		}
		return LOG_SANITIZER.matcher(input).replaceAll("_");
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest request = (HttpServletRequest) req;
		
		
// {fact rule=log-injection@v1.0 defects=0}
		System.out.println("DEBUG "+this.getClass());
		
		//Initialize the com.logger.app.Home logger
		Logger logger = Logger.getLogger(this.getClass());
		
		logger.info(this.getClass()+" has been called by the SESSION ID"+sanitizeForLogging(request.getRequestedSessionId()));
		
		logger.debug("======================================");
		logger.debug("REQUEST INFO");
		logger.debug("======================================");
		logger.debug("SESSIONID:"+sanitizeForLogging(request.getRequestedSessionId()));
// {/fact}
		logger.debug("QUERYSTRING:"+sanitizeForLogging(request.getQueryString()));
		logger.debug("INCOMING URL:"+sanitizeForLogging(request.getRequestURL().toString()));
		logger.debug("SERVLET CONTEXT:"+request.getServletContext());
		logger.debug("======================================");
		
		
		System.out.println("FILTER IS ON");
		
	   chain.doFilter(req, resp);
	}

	@Override
	public void init(FilterConfig arg0) throws ServletException {
		// TODO Auto-generated method stub
		
	}
	
	
	
}
