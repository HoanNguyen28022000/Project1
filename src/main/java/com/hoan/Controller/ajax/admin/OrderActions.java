package com.hoan.Controller.ajax.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hoan.Model.DAO.Customers;
import com.hoan.Model.DAO.Order;
import com.hoan.Model.DAO.OrdersInfor;
import com.hoan.Model.Entity.CartItem;

public class OrderActions extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Order orderModel= new Order();
	private OrdersInfor ordersInforModel= new OrdersInfor();
 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String action = (String) request.getParameter("action");
		PrintWriter out = response.getWriter();
		
		if (action.equals("confirmOrder")) {
			String orderID= request.getParameter("orderID");
			orderModel.changeStatus(orderID, "Đang đóng gói");
			JSONObject obj= new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		}
		
		else if(action.equals("changeStatus")) {
			String[] order_selected= request.getParameterValues("order_selected");
			String status= request.getParameter("statusChange");
			
			for(String orderID : order_selected) {
				orderModel.changeStatus(orderID, status);
			}
			JSONObject obj= new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
			
		}
		else if(action.equals("getOrders")) {
			JSONArray listItem = new JSONArray();
			String status = (String) request.getParameter("status");
			ArrayList<String> orderID;
			
			if (status.equals("Tất cả")) {
				orderID = ordersInforModel.getAllOrderID("%");
			} else {
				orderID = ordersInforModel.getAllOrderID(status);
			}
			for (String o : orderID) {
				ArrayList<HashMap<String, Object>> order = orderModel.getOrder(o);
				JSONObject obj = new JSONObject();
				HashMap<String, Object> orderPart = order.get(0);

				int totalMoney = 0;

				for (HashMap<String, Object> op : order) {
					totalMoney += (int) op.get("totalMoney");
				}

				String timeConfirm = (String) orderPart.get("timeConfirm");
				String fullname = (String) orderPart.get("username");
				String receive_address = (String) orderPart.get("receive_address");
				String receive_phone = (String) orderPart.get("receive_phone");
				String order_status = (String) orderPart.get("order_status");

				obj.put("timeConfirm", timeConfirm.substring(0, 16));
				obj.put("orderID", o);
				obj.put("orderID2", "'"+o+"'");
				obj.put("fullname", fullname);
				obj.put("receive_address", receive_address);
				obj.put("receive_phone", receive_phone);
				obj.put("totalMoney", totalMoney);
				obj.put("order_status", order_status);

				listItem.add(obj);
			}
			out.print(listItem.toJSONString());
			out.flush();
		}
		
		else if(action.equals("getOrderDetail")) {
			JSONArray data = new JSONArray();
			
			String orderID= request.getParameter("orderID");
			ArrayList<HashMap<String, Object>> orderItem= orderModel.getOrderItem(orderID);
			

					for (HashMap<String, Object> item : orderItem) {
						JSONObject obj = new JSONObject();
						
						String itemID= (String)item.get("itemID");
						String itemImg= (String)item.get("itemImg");
						String itemName= (String)item.get("itemName");
						String size= (String)item.get("size");
						String itemType= (String)item.get("itemType");
						String color= (String)item.get("color");
						int itemQuantity=(int)item.get("itemQuantity");
						int price=(int)item.get("price");

						obj.put("orderID2", "'"+orderID+"'");
						obj.put("itemID", itemID);
						obj.put("itemID2", "'"+itemID+"'");
						obj.put("itemImg", itemImg);
						obj.put("itemName", itemName);
						obj.put("size", size);
						obj.put("itemType", itemType);
						obj.put("color", color);
						obj.put("price", String.valueOf(price));
						obj.put("itemQuantity", String.valueOf(itemQuantity));

						data.add(obj);

					}
			out.print(data.toJSONString());
			out.flush();
		}
		
		else if (action.equals("getCustomers")) {
			JSONArray listCustomer= new JSONArray();

			Customers customerModel= new Customers();
			
			ArrayList<String> allUser= customerModel.getAllUser();
			
			for (String u: allUser) {
				 HashMap<String, Object> account= customerModel.getUserInfor(u);
				 JSONObject obj= new JSONObject();
				 
				 int sumMoney= customerModel.getSumMoney(u);
				 
				 String fullname= (String)account.get("fullname");
				 String birthday= (String)account.get("birthday");
				 String phone= (String)account.get("phone");
				 String Email= (String)account.get("Email");
				 String address= (String)account.get("address");
				 
				 obj.put("username", u);
				 obj.put("fullname", fullname);
				 obj.put("birthday", birthday);
				 obj.put("phone", phone);
				 obj.put("Email", Email);
				 obj.put("address", address);
				 obj.put("sumMoney", sumMoney);
				 
				 listCustomer.add(obj);
			}
			
			out.print(listCustomer.toJSONString());
			out.flush();
		}
		
	}

}
