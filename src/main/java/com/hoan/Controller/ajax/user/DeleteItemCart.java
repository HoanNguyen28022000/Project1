package com.hoan.Controller.ajax.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DeleteItemCart {
	@RequestMapping(value= {"/Home/Cart/DeleteItemCart"})
	public String Delete() {
		return "ajax/DeleteItemCart";
	}

}
