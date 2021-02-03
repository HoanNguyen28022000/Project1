<%@page import="com.hoan.Model.Customers"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.hoan.Model.ConnectSQLServer"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hoan.Model.Customers"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
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
%>