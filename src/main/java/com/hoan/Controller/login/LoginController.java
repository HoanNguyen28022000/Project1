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

import com.hoan.Model.DAO.AccountsInfor;
import com.hoan.Model.DAO.ConnectSQLServer;

@Controller
@Scope("session")
public class LoginController {

	private AccountsInfor accountsInfor= new AccountsInfor();

	@SuppressWarnings("deprecation")
	@RequestMapping(value= {"/LoginController"})
	public String login(HttpServletRequest request,HttpServletResponse response, Model model) throws IOException {
		HttpSession session=request.getSession();
		String username = request.getParameter("name");
		String pass = request.getParameter("pass");

		HashMap<String, String> accs = accountsInfor.getAccounts();

		model.addAttribute("name", username);

		Set<String> usernames = accs.keySet();
		for (String s : usernames) {
			if (username.equals("admin") && pass.equals("123456789")) {
				System.out.println("admin : "+username);
				session.putValue("admin", username);
				response.sendRedirect(request.getContextPath()+"/Admin");
				return "admin/Admin";
			}
			else if (username.equals(s) && pass.equals(accs.get(s))) {
				System.out.println("user : "+username);
				session.putValue("user", username);
				response.sendRedirect(request.getContextPath()+"/Home");
				return "user/Home";
			}
		}
		response.sendRedirect("views/error.jsp");
		return"views/error";
}}
