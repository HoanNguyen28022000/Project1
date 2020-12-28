<%@page import="java.sql.Time"%>
<%@page import="java.util.Date"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="com.hoan.Connection.ConnectSQLServer"%>
<%@page import="com.hoan.Objects.CartItem"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.hoan.Objects.Cart"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	JSONArray cartJSON= new JSONArray();
	ConnectSQLServer connection= new ConnectSQLServer();
	String name= (String)session.getAttribute("user");
	Cart cart= (Cart)session.getAttribute("cart_"+name);
	String receive_phone= (String)request.getParameter("receive_phone");
	String receive_address= (String)request.getParameter("receive_address");
	int subtotal= Integer.parseInt(request.getParameter("subtotal"));
	
	
	ArrayList<CartItem> listItems= cart.getCart();
	
	String orderID= String.valueOf(Integer.parseInt(connection.getNextOrderID())+1);
	
	Date today= new Date();
	String timeConfirm= new Timestamp(today.getTime()).toString() ;
	System.out.println(timeConfirm);
	
	connection.confirmOrder(orderID, name, receive_address, receive_phone, timeConfirm, subtotal);
	for (CartItem c: listItems) {
		connection.confirmItems(orderID, c.getItemID(), c.getQuantity(), c.getSize());
	}
	
	session.removeAttribute("cart_"+name);
	session.removeAttribute("quantityCart_"+name);
	
	out.print(cartJSON.toJSONString());
	out.flush();
	
%>