package com.hoan.Controller.ajax.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class OrderHistory {
	@RequestMapping(value= {"/Home/Cart/OrderHistory"})
	public String orderHistory() {
		return "ajax/OrderHistory";
	}

}
