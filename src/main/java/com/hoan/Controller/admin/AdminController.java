package com.hoan.Controller.admin;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import com.hoan.Model.ConnectSQLServer;

@EnableWebMvc
@Controller
public class AdminController {
	@RequestMapping(value= {"/Admin"})
	public String Admin() {
		return "admin/Admin";
	}
	
	@RequestMapping(value= {"/Admin/Items"})
	public String adminItem() {
		return "admin/AdminItem";
	}
	
	@RequestMapping(value= {"/Admin/Order"})
	public String adminOrder() {
		return "admin/AdminOrder";
	}
	
	@RequestMapping(value= {"/Admin/Items/Edit"})
	public String edititem() {
		return "admin/EditItem";
	}
	
	@RequestMapping(value= {"/Admin/Items/Insert"})
	public String insertItem() {
		return "admin/InsertItem";
	}
	
	@RequestMapping(value= {"/Admin/Revenue"})
	public String revenue() {
		return "admin/Revenue";
	}
	
	@RequestMapping(value= {"/Admin/PurchaseItems"})
	public String purchaseItems() {
		return "admin/PurchaseItems";
	}
	
	@RequestMapping(value= {"/Admin/Customers"})
	public String customers() {
		return "admin/AdminCustomer";
	}
	
	
	@RequestMapping(value= {"/Admin/PurchaseOrderHistory"})
	public String purchaseOrderHistory() {
		return "admin/PurchaseOrderHistory";
	}

}
