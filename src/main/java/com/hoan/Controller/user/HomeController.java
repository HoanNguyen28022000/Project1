package com.hoan.Controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping(value= {"/Home"})
	public String Home() {
		return "user/Home";
	}

}
