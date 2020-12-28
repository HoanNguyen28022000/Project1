package com.hoan.Controller.ajax.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ConfirmOrder {
	@RequestMapping(value= {"/Home/Cart/ConfirmOrder"})
	public String Confirm() {
		return "ajax/ConfirmOrder";
	}

}
