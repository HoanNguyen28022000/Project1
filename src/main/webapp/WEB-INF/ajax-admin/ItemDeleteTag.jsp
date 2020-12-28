
<%@page import="org.json.simple.JSONObject"%>
<%@page import="jdk.nashorn.api.scripting.JSObject"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String itemID = (String) request.getParameter("itemID");
	String tag = (String) request.getParameter("tag");

	ConnectSQLServer connection = new ConnectSQLServer();
	connection.executeNotReturn("delete from tag_item where itemID='" + itemID + "' and tag=N'" + tag + "'");

	JSONObject obj = new JSONObject();
	out.print(obj.toJSONString());
	out.flush();
%>