package com.hoan.Controller.login;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hoan.Model.DAO.AccountsInfor;
import com.hoan.Model.DAO.ConnectSQLServer;

@Controller
public class CreateAccountController {
	private AccountsInfor accountInforModel= new AccountsInfor();
	
	@RequestMapping("/createAccountSuccessed")
	public String createAccountSuccessed(HttpServletRequest request) {
		String newUsername= request.getParameter("newUsername");
		String newPassworld= request.getParameter("newPassworld");
		String confirmPassword= request.getParameter("confirmPassword");
		
		if (confirmPassword.equals(newPassworld)) {
			accountInforModel.createAccount(newUsername, newPassworld);
			return "login/login";
		}
		else return "login/createAccount";
		
	}
}
