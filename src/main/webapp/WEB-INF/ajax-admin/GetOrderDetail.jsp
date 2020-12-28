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
	JSONArray data = new JSONArray();

	ConnectSQLServer connection = new ConnectSQLServer();
	
	String orderID= request.getParameter("orderID");
	ArrayList<HashMap<String, Object>> orderItem= connection.getOrderItem(orderID);
	

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

				obj.put("itemID", itemID);
				/* obj.put("itemID2", "'" + itemID + "'"); */
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
%>