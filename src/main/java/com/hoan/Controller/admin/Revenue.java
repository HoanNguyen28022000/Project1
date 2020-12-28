package com.hoan.Controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class Revenue {
	@RequestMapping(value= {"/Admin/Revenue"})
	public String revenue() {
		return "admin/Revenue";
	}

}
