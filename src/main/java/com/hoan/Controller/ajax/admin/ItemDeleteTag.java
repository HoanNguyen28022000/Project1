package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ItemDeleteTag {
	@RequestMapping(value= {"/Admin/Items/DeleteTag"})
	public String itemDeleteTag() {
		return "ajax-admin/ItemDeleteTag";
	}

}
