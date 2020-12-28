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
	JSONArray cart= new JSONArray();

	ConnectSQLServer connection = new ConnectSQLServer();
	
	String itemDetail, itemImg, itemName;
	int itemPrice, stocking;
	
	String nameSearch = (String)request.getParameter("nameSearch");
/* 	System.out.println(nameSearch); */
	String[] tags = request.getParameterValues("Tag");
	String selectType = (String)request.getParameter("selectType");
	
	ArrayList<String> allItemIDSearch = connection.getItemSearch(nameSearch, tags, "Đang bán", selectType );
	for (String itemID : allItemIDSearch) {
		JSONObject obj = new JSONObject();
		
		HashMap<String, Object> item = connection.getItem(itemID);
		itemDetail = (String) item.get("itemDetail");
		itemImg = (String) item.get("itemImg");
		itemName = (String) item.get("itemName");
		stocking= connection.getStockingItem(itemID).get(0);
		itemPrice= connection.getItemPrice(itemID).get(1);
		
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
%>