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
	
	String itemID= request.getParameter("itemID");
	ArrayList<String> item_tags= connection.getTags(itemID);
	
	for (String tag: item_tags) {
		JSONObject obj = new JSONObject();
		obj.put("itemID", "'" + itemID + "'");
		obj.put("tagFunc", "'" + tag + "'");
		obj.put("tag", tag );
		data.add(obj);
	}
	
	out.print(data.toJSONString());
	out.flush();
%>