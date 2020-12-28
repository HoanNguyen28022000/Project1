package com.hoan.Controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminController {
	@RequestMapping(value= {"/Admin"})
	public String Admin() {
		return "admin/Admin";
	}

}
