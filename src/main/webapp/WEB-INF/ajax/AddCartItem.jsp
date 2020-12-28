<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>

<%@page import="com.hoan.Objects.Cart"%>
<%@page import="com.hoan.Objects.CartItem"%>
<%@page import="org.json.simple.JSONArray"%>
<%
	ConnectSQLServer connection = new ConnectSQLServer();
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
%>