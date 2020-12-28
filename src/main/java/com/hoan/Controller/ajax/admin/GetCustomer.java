package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetCustomer {
	@RequestMapping(value= {"/Admin/GetCustomer"})
	public String getCustomer() {
		return "ajax-admin/GetCustomer";
	}

}
