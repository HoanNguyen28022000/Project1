package com.hoan.Controller.ajax.user;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hoan.Entity.Cart;
import com.hoan.Entity.CartItem;
import com.hoan.Model.Item;
import com.hoan.Model.ItemsInfor;
import com.hoan.Model.Order;
import com.hoan.Model.OrdersInfor;

public class UserActions extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Item itemModel= new Item();
	private ItemsInfor itemInforModel= new ItemsInfor();
	private Order orderModel= new Order();
	private OrdersInfor ordersInforModel= new OrdersInfor();
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String action = (String) request.getParameter("action");
		PrintWriter out = response.getWriter();
		
		if(action.equals("getItemSearch")) {
			JSONArray cart= new JSONArray();
			String itemDetail, itemImg, itemName;
			int itemPrice, stocking;
			
			String nameSearch = (String)request.getParameter("nameSearch");
			String[] tags = request.getParameterValues("Tag");
			String selectType = (String)request.getParameter("selectType");
			
			ArrayList<String> allItemIDSearch = itemInforModel.getItemSearch(nameSearch, tags, "Đang bán", selectType );
			for (String itemID : allItemIDSearch) {
				JSONObject obj = new JSONObject();
				
				HashMap<String, Object> item = itemModel.getItem(itemID);
				itemDetail = (String) item.get("itemDetail");
				itemImg = (String) item.get("itemImg");
				itemName = (String) item.get("itemName");
				stocking= itemInforModel.getSumStockItem(itemID).get(0);
				itemPrice= itemInforModel.getItemPrice(itemID).get(1);
				
				obj.put("itemID", itemID);
				obj.put("itemDetail", itemDetail);
				obj.put("itemName", itemName);
				obj.put("itemImg", itemImg);
				obj.put("stocking", stocking);
				obj.put("itemPrice", itemPrice);
				
				cart.add(obj);
			}
			out.print(cart.toJSONString());
			out.flush();
		}
		else if(action.equals("addCartItem")) {
			HttpSession session= request.getSession();
			String username = (String) session.getAttribute("user");
			Cart listItem = (Cart) session.getAttribute("cart_"+username);

			String itemID = (String) request.getParameter("itemID");
			String size = (String) request.getParameter("size");
			String quantity = (String) request.getParameter("quantity");
			if (listItem != null ) {
					int quantityCart = (int) session.getAttribute("quantityCart_"+username);
					boolean check = true;
					for (CartItem c : listItem.getCart()) {
						if (c.getItemID().equals(itemID)) {
							check = false;
							break;
						}
					}
					if (check) {
						listItem.getCart().add(new CartItem(itemID, size, Integer.parseInt(quantity)));
						quantityCart++;
					}
					session.setAttribute("quantityCart_"+username, quantityCart);
			} else {
				ArrayList<CartItem> cart = new ArrayList<CartItem>();
				cart.add(new CartItem(itemID, size, Integer.parseInt(quantity)));
				listItem = new Cart(cart, username);
				session.setAttribute("cart_"+username, listItem);
				session.setAttribute("quantityCart_"+username, 1);
			}
			JSONObject obj = new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		}
		else if(action.equals("getCart")) {
			HttpSession session= request.getSession();
			
			JSONArray cart = new JSONArray();
			String username = (String) session.getAttribute("user");
			Cart listItem = (Cart) session.getAttribute("cart_"+username);
			
			if (listItem != null) {
				if (listItem.getUsername().equals(username)) {

					for (CartItem c : listItem.getCart()) {
						JSONObject obj = new JSONObject();

						String itemID = c.getItemID();
						HashMap<String, Object> item = itemModel.getItem(itemID);
						String itemName = (String) item.get("itemName");
						String color = (String) item.get("itemColor");
						String itemImg = (String) item.get("itemImg");
						int itemPrice= itemInforModel.getItemPrice(itemID).get(1);

						String size = c.getSize();
						String quantity = String.valueOf(c.getQuantity());
						int subtotal = itemPrice * c.getQuantity();

						obj.put("itemID", "'" + itemID + "'");
						obj.put("size", size);
						obj.put("quantity", quantity);
						obj.put("color", color);
						obj.put("itemImg", itemImg);
						obj.put("itemName", itemName);
						obj.put("itemPrice", String.valueOf(itemPrice));
						obj.put("subtotal", String.valueOf(subtotal));

						cart.add(obj);
					}
				}
			}
			out.print(cart.toJSONString());
			out.flush();
		} 
		else if(action.equals("updateCart")) {
			HttpSession session= request.getSession();
			
			String username = (String)session.getAttribute("user");
			Cart cart = (Cart) session.getAttribute("cart_"+username);

			String itemID = (String) request.getParameter("itemID");
			String quantityupdate= (String)request.getParameter("quantityupdate");
			System.out.println(quantityupdate);
			System.out.println(itemID);
			
			
			ArrayList<CartItem> listItems= cart.getCart();
			for (CartItem c: listItems) {
				if(c.getItemID().equals(itemID)) {
					c.setQuantity(Integer.parseInt(quantityupdate));
					break;
				}
			}
			
			out.print(quantityupdate);
			out.flush();
		}
		else if(action.equals("deleteItemCart")) {
			HttpSession session= request.getSession();
			
			String username = (String) session.getAttribute("user");
			Cart listItem = (Cart) session.getAttribute("cart_"+username);

			String itemID = (String) request.getParameter("itemID");
			
			if(listItem.getCart().size()==1) {
				listItem.getCart().clear();
			}
			else {
				CartItem delete= null;
				for (CartItem c : listItem.getCart()) {
					if(c.getItemID().equals(itemID)) {
						delete=c;
						break;
					}
				}
				listItem.getCart().remove(delete);
			}
			int quantityCart= (int)session.getAttribute("quantityCart_"+username);
			quantityCart--;
			session.setAttribute("quantityCart_"+username, quantityCart);
			
			JSONObject obj = new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		}
		else if(action.equals("getOrderHistory")) {
			HttpSession session= request.getSession();
			
			JSONArray listItem = new JSONArray();
			String customer = (String) session.getAttribute("user");
			
			if (customer != null) {
				ArrayList<String> orderHistory = ordersInforModel.getOrderHistory(customer);

				for (String o : orderHistory) {
					ArrayList<HashMap<String, Object>> order = orderModel.getOrder(o);
					JSONObject obj = new JSONObject();
					HashMap<String, Object> orderPart = order.get(0);

					int totalMoney = 0;

					for (HashMap<String, Object> op : order) {
						totalMoney += (int) op.get("totalMoney");
					}

					String timeConfirm = (String) orderPart.get("timeConfirm");
					String receive_address = (String) orderPart.get("receive_address");
					String receive_phone = (String) orderPart.get("receive_phone");
					String order_status = (String) orderPart.get("order_status");

					obj.put("timeConfirm", timeConfirm.substring(0, 16));
					obj.put("orderID", o);
					obj.put("orderID2", "'" + o + "'");
					obj.put("receive_address", receive_address);
					obj.put("receive_phone", receive_phone);
					obj.put("totalMoney", totalMoney);
					obj.put("order_status", order_status);

					listItem.add(obj);
				}
			}

			out.print(listItem.toJSONString());
			out.flush();
		}
		else if(action.equals("confirmOrder")) {
			HttpSession session= request.getSession();
			
			JSONArray cartJSON= new JSONArray();
			String name= (String)session.getAttribute("user");
			Cart cart= (Cart)session.getAttribute("cart_"+name);
			String receive_phone= (String)request.getParameter("receive_phone");
			String receive_address= (String)request.getParameter("receive_address");
			int subtotal= Integer.parseInt(request.getParameter("subtotal"));
			
			
			ArrayList<CartItem> listItems= cart.getCart();
			
			String orderID= String.valueOf(Integer.parseInt(ordersInforModel.getNextOrderID())+1);
			
			Date today= new Date();
			String timeConfirm= new Timestamp(today.getTime()).toString() ;
			System.out.println(timeConfirm);
			
			orderModel.confirmOrder(orderID, name, receive_address, receive_phone, timeConfirm, subtotal);
			for (CartItem c: listItems) {
				orderModel.confirmItems(orderID, c.getItemID(), c.getQuantity(), c.getSize());
			}
			
			session.removeAttribute("cart_"+name);
			session.removeAttribute("quantityCart_"+name);
			
			out.print(cartJSON.toJSONString());
			out.flush();
		}
	}

}
