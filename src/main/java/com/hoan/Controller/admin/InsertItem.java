package com.hoan.Controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class InsertItem {
	@RequestMapping(value= {"/Admin/Items/Insert"})
	public String insertItem() {
		return "admin/InsertItem";
	}

}
