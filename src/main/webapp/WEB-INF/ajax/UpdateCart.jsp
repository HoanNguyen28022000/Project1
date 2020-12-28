<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@page import="com.hoan.Objects.Cart"%>
<%@page import="com.hoan.Objects.CartItem"%>
<%@page import="org.json.simple.JSONArray"%>
<%

	ConnectSQLServer connection = new ConnectSQLServer();
	String username = (String)session.getAttribute("user");
	Cart cart = (Cart) session.getAttribute("cart_"+username);

	String itemID = (String) request.getParameter("itemID");
	String quantityupdate= (String)request.getParameter("quantityupdate");
	System.out.println(quantityupdate);
	System.out.println(itemID);
	
	
	ArrayList<CartItem> listItems= cart.getCart();
	for (CartItem c: listItems) {
		if(c.getItemID().equals(itemID)) {
			c.setQuantity(Integer.parseInt(quantityupdate));
			break;
		}
	}
	
	out.print(quantityupdate);
	out.flush();
%>
