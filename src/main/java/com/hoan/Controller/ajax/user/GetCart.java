package com.hoan.Controller.ajax.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetCart {
	@RequestMapping(value= {"/Home/Cart/GetCart"})
	public String getCart() {
		return "ajax/GetCart";
	}

}
