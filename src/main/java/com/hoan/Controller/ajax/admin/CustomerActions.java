package com.hoan.Controller.ajax.admin;

import org.springframework.web.bind.annotation.RequestMapping;

public class CustomerActions {
	@RequestMapping(value= {"/Admin/GetCustomer"})
	public String getCustomers() {
		return "ajax-admin/GetCustomer";
	}
}
