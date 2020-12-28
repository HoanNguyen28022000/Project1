package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetItemSearchAdmin {
	@RequestMapping(value= {"/Admin/GetItemSearchAdmin"})
	public String getItemSearchAdmin() {
		return "ajax-admin/GetItemSearchAdmin";
	}

}
