package com.hoan.Controller.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
@Controller
public class ItemController {
	@RequestMapping(value= {"/Home/Item"})
	public String Item() {
		return "user/Item";
	}
}
