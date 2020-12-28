package com.hoan.Controller.ajax.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AddCartItem {
	@RequestMapping(value= {"/Home/Item/AddCartItem"})
	public String Home() {
		return "ajax/AddCartItem";
	}

}
