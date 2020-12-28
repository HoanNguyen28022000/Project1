package com.hoan.Controller.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CartController {
	@RequestMapping(value= {"/Home/Cart"})
	public String Item(HttpServletRequest req, HttpServletResponse rep, HttpSession session) {
		if((String)session.getValue("user")!=null) {
			
		}
		
		return "user/Cart";
	}
}
