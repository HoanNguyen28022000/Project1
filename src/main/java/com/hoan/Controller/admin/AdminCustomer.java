package com.hoan.Controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminCustomer {
	@RequestMapping(value= {"/Admin/AdminCustomer"})
	public String adminCustomer() {
		return "admin/AdminCustomer";
	}

}
