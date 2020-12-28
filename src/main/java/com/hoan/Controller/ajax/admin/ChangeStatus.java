package com.hoan.Controller.ajax.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ChangeStatus {
	@RequestMapping(value= {"/Admin/ChangeStatus"})
	public String changeStatus() {
		return "ajax-admin/ChangeStatus";
	}

}
