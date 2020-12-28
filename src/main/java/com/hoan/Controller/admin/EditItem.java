package com.hoan.Controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EditItem {
	@RequestMapping(value= {"/Admin/Items/Edit"})
	public String edititem() {
		return "admin/EditItem";
	}

}
