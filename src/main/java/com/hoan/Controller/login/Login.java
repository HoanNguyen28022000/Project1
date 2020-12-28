package com.hoan.Controller.login;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@Scope("session")
public class Login extends HttpServlet{
	private static final long serialVersionUID = 1L;
	@SuppressWarnings("deprecation")
	@RequestMapping(value = { "/Login" })
	public String login(HttpServletRequest req, HttpServletResponse rep) throws IOException {
		HttpSession session= req.getSession();
		System.out.println("login "+session.getValue("user"));
		if((session.getValue("user"))!=null) {
			session.removeValue("user");
		}
//		rep.sendRedirect("login/login.jsp");
		return "login/login";
	}
}