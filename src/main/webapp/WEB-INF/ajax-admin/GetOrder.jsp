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
	JSONArray listItem = new JSONArray();

	ConnectSQLServer connection = new ConnectSQLServer();

	String status = (String) request.getParameter("status");
	
	ArrayList<String> orderID;
	if (status.equals("Tất cả")) {
		orderID = connection.getAllOrderID("%");
	} else {
		orderID = connection.getAllOrderID(status);
	}
	for (String o : orderID) {
		ArrayList<HashMap<String, Object>> order = connection.getOrder(o);
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
%>