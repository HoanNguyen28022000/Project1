package com.hoan.Controller.login;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CreateAccount {
	@RequestMapping(value= {"/createAccount"})
	public String createAccount() {
		return "login/createAccount";
	}

}
