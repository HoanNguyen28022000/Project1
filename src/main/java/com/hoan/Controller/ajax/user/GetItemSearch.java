package com.hoan.Controller.ajax.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class GetItemSearch {
	@RequestMapping(value= {"/Home/GetItemSearch"})
	public String getAllItem() {
		return "ajax/GetItemSearch";
	}

}
