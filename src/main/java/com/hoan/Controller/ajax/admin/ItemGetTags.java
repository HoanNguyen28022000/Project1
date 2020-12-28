package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ItemGetTags {
	@RequestMapping(value= {"/Admin/Items/GetTags"})
	public String itemGetTags() {
		return "ajax-admin/ItemGetTags";
	}

}
