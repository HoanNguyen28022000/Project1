package com.hoan.Controller.login;

import java.io.IOException;
import java.util.HashMap;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hoan.Connection.ConnectSQLServer;

@Controller
@Scope("session")
public class LoginController {

	ConnectSQLServer connectSQLServer;

	@SuppressWarnings("deprecation")
	@RequestMapping(value= {"/LoginController"})
	public String login(HttpServletRequest request,HttpServletResponse response, Model model) throws IOException {
		HttpSession session=request.getSession();
		String usename = request.getParameter("name");
		String pass = request.getParameter("pass");

		connectSQLServer = new ConnectSQLServer();
		HashMap<String, String> accounts = connectSQLServer.getAccount();

		model.addAttribute("name", usename);
		System.out.println(usename + " " + pass);

		Set<String> usenames = accounts.keySet();
		for (String s : usenames) {
			if (usename.equals("admin") && pass.equals("123456789")) {
				System.out.println("user : "+usename);
				session.putValue("user", usename);
				String[] arr=session.getValueNames();
				for(String atrribute:arr) {
					System.out.println(atrribute);
				}
				System.out.println(session.getId()+" "+session.getValue("loginController"));
				System.out.println();
				response.sendRedirect(request.getContextPath()+"/Admin");
				return "admin/Admin";
			}
			else if (usename.equals(s) && pass.equals(accounts.get(s))) {
				System.out.println("user : "+usename);
				session.putValue("user", usename);
				String[] arr=session.getValueNames();
				for(String atrribute:arr) {
					System.out.println(atrribute);
				}
				System.out.println(session.getId()+" "+session.getValue("loginController"));
				System.out.println();
				response.sendRedirect(request.getContextPath()+"/Home");
				return "user/Home";
			}
		}
//		response.sendRedirect("views/error.jsp");
	return"views/error";
}}
