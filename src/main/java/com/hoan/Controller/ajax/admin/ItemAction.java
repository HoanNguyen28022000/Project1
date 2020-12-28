package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ItemAction {
	@RequestMapping(value= {"/Admin/Items/Action"})
	public String itemAction() {
		return "ajax-admin/ItemAction";
	}

}
