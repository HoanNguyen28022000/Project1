package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ItemInsertTag {
	@RequestMapping(value= {"/Admin/Items/InsertTag"})
	public String itemInsertTag() {
		return "ajax-admin/ItemInsertTag";
	}

}
