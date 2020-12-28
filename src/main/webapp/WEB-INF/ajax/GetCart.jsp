<%@page import="java.util.HashMap"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.hoan.Objects.Cart"%>
<%@page import="com.hoan.Objects.CartItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	JSONArray cart = new JSONArray();

	ConnectSQLServer connection = new ConnectSQLServer();
	String username = (String) session.getAttribute("user");
	Cart listItem = (Cart) session.getAttribute("cart_"+username);
	if (listItem != null) {
		if (listItem.getUsername().equals(username)) {

			for (CartItem c : listItem.getCart()) {
				JSONObject obj = new JSONObject();

				String itemID = c.getItemID();
				HashMap<String, Object> item = connection.getItem(itemID);
				String itemName = (String) item.get("itemName");
				String color = (String) item.get("itemColor");
				String itemImg = (String) item.get("itemImg");
				int itemPrice= connection.getItemPrice(itemID).get(1);

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
%>