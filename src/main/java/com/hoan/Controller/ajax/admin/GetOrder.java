package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetOrder {
	@RequestMapping(value= {"/Admin/GetOrder"})
	public String getOrderConfirm() {
		return "ajax-admin/GetOrder";
	}

}
