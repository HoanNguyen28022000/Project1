<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>

<%@page import="com.hoan.Objects.Cart"%>
<%@page import="com.hoan.Objects.CartItem"%>
<%@page import="org.json.simple.JSONArray"%>
<%

	ConnectSQLServer connection = new ConnectSQLServer();
	String username = (String) session.getAttribute("user");
	Cart listItem = (Cart) session.getAttribute("cart_"+username);

	String itemID = (String) request.getParameter("itemID");
	
	if(listItem.getCart().size()==1) {
		listItem.getCart().clear();
	}
	else {
		CartItem delete= null;
		for (CartItem c : listItem.getCart()) {
			if(c.getItemID().equals(itemID)) {
				delete=c;
				break;
			}
		}
		listItem.getCart().remove(delete);
	}
	int quantityCart= (int)session.getAttribute("quantityCart_"+username);
	quantityCart--;
	session.setAttribute("quantityCart_"+username, quantityCart);
	
	JSONObject obj = new JSONObject();
	out.print(obj.toJSONString());
	out.flush();
%>