package com.hoan.Controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminOrder {
	@RequestMapping(value= {"/Admin/Order"})
	public String adminOrder() {
		return "admin/AdminOrder";
	}

}
