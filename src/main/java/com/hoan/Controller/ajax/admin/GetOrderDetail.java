package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetOrderDetail {
	@RequestMapping(value= {"/Admin/Order/GetOrderDetail"})
	public String getOrderDetail() {
		return "ajax-admin/GetOrderDetail";
	}

}
