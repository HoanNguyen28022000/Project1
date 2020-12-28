package com.hoan.Controller.ajax.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UpdateCart {
	@RequestMapping(value= {"/Home/Cart/UpdateCart"})
	public String Update() {
		return "ajax/UpdateCart";
	}

}
