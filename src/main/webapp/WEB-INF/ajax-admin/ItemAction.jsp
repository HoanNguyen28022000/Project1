
<%@page import="org.json.simple.JSONObject"%>
<%@page import="jdk.nashorn.api.scripting.JSObject"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String action = (String)request.getParameter("action");
	System.out.println(action);

	ConnectSQLServer connection = new ConnectSQLServer();

	String[] item_selected = request.getParameterValues("item_selected");
	if (item_selected != null) {
		String itemIDs = "(";
		for (int i = 0; i < item_selected.length; i++) {
			if (i==0) itemIDs += "'" + item_selected[i] + "'";
			else itemIDs += ", '" + item_selected[i] + "'";
		}
		itemIDs += ")";
		System.out.println("update Items set status=N'" + action + "' where itemID in " + itemIDs);
		connection.executeNotReturn("update Items set status=N'" + action + "' where itemID in " + itemIDs);
		
		JSONObject obj= new JSONObject();
		out.print(obj.toJSONString());
		out.flush();
	} 

%>