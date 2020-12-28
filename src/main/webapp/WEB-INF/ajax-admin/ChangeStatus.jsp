
<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int orderID= Integer.parseInt(request.getParameter("orderID"));
	String status= request.getParameter("status");
	ConnectSQLServer connection= new ConnectSQLServer();
	connection.changeOrderStatus(orderID, status);
	
	out.print("hello");
	out.flush();
%>