package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DeleteItem {
	@RequestMapping(value= {"/Admin/DeleteItem"})
	public String deleteItem() {
		return "ajax-admin/DeleteItem";
	}

}
