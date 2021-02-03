package com.hoan.Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class OrdersInfor {
	private ConnectSQLServer db = new ConnectSQLServer();

	public ArrayList<String> getAllOrderID(String status) { ///////////
		ArrayList<String> orderID = new ArrayList<String>();
		try {

			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery(
					"select orderID from Orders where order_status like N'" + status + "' order by timeConfirm desc");
			// show data
			while (rs.next()) {
				orderID.add((String) (rs.getString(1)).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return orderID;
	}

	public String getNextOrderID() {
		String orderID = null;
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select max(orderID) from Orders");
			// show data
			while (rs.next()) {
				orderID = (String) (rs.getString(1)).trim();
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return orderID;
	}

	public ArrayList<String> getOrderHistory(String customer) {
		ArrayList<String> orderID = new ArrayList<String>();
		try {

			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery(
					"select orderID from Orders where customer=N'" + customer + "' order by timeConfirm desc");
			// show data
			while (rs.next()) {
				orderID.add((String) (rs.getString(1)).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return orderID;
	}

}
