package com.hoan.Controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AdminItem {
	@RequestMapping(value= {"/Admin/Items"})
	public String adminItem() {
		return "admin/AdminItem";
	}

}
