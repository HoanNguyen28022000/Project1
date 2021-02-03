package com.hoan.Security;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class FilterAdmin implements Filter {

	public FilterAdmin() {
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}
	
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		HttpSession session = req.getSession();

		String servletPath = req.getServletPath();
		System.out.println(servletPath);

		if (servletPath.contains("/Admin")) {
			if (session.getAttribute("admin") != null) {
				chain.doFilter(request, response);
			} else
				res.sendRedirect("http://localhost:8080/com.spring-mvc-demo/Login");
		} else
			chain.doFilter(request, response);
	}
	
	@Override
	public void destroy() {
		
	}

}
