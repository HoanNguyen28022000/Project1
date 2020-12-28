<%@page import="com.sun.prism.paint.Color"%>
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
	JSONArray listItems= new JSONArray();

	ConnectSQLServer connection = new ConnectSQLServer();
	
	String itemColor, itemImg, itemName,itemType, status;
	int purchase_price, sale_price, available, inventory;
	
	String nameSearch = (String)request.getParameter("nameSearch");
	/* 	System.out.println(nameSearch); */
	String[] tags = request.getParameterValues("Tag");
	String selectType= (String)request.getParameter("selectType");
	String selectStatus= (String)request.getParameter("selectStatus");
	
	
	ArrayList<String> allItemIDSearch = connection.getItemSearch(nameSearch, tags, selectStatus, selectType);
	for (String itemID : allItemIDSearch) {
		JSONObject obj = new JSONObject();
		
		HashMap<String, Object> item = connection.getItem(itemID);
		itemColor = (String) item.get("itemColor");
		itemImg = (String) item.get("itemImg");
		itemName = (String) item.get("itemName");
		itemType = (String) item.get("itemType");
		status = (String) item.get("status");
		
		available= connection.getStockingItem(itemID).get(0);
		inventory= connection.getStockingItem(itemID).get(1);
		purchase_price= connection.getItemPrice(itemID).get(0);
		sale_price= connection.getItemPrice(itemID).get(1);
		
		obj.put("itemID", itemID);
		obj.put("itemColor", itemColor);
		obj.put("itemName", itemName);
		obj.put("itemImg", itemImg);
		obj.put("itemType", itemType);
		obj.put("available", available);
		obj.put("inventory", inventory);
		obj.put("purchase_price", purchase_price);
		obj.put("sale_price", sale_price);
		obj.put("status", status);
		
		listItems.add(obj);
	}
	
	
	out.print(listItems.toJSONString());
	out.flush();
%>