<%@page import="java.util.HashMap"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	JSONArray listCustomer= new JSONArray();

	ConnectSQLServer connection = new ConnectSQLServer();
	
	ArrayList<String> allUser= connection.getAllUser();
	
	for (String u: allUser) {
		 HashMap<String, Object> account= connection.getUserInfor(u);
		 JSONObject obj= new JSONObject();
		 
		 int sumMoney= connection.getSumMoney(u);
		 
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
%>