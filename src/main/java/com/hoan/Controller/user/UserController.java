package com.hoan.Controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UserController {
	@RequestMapping(value= {"/Home"})
	public String Home() {
		return "user/Home";
	}

	@RequestMapping(value= {"/Home/Item"})
	public String Item() {
		return "user/Item";
	}
	
	@RequestMapping(value= {"/Home/Cart"})
	public String Cart() {
		return "user/Cart";
	}
}
