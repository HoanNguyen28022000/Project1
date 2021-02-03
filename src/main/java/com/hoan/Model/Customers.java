package com.hoan.Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class Customers {
	private ConnectSQLServer db= new ConnectSQLServer();
	
	public ArrayList<String> getAllUser() {       ///////////////
		ArrayList<String> allUser = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select name from user_account where name != N'admin'");
			// show data
			while (rs.next()) {
				allUser.add(rs.getString(1).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return allUser;
	}

	public HashMap<String, Object> getUserInfor(String username) {
		HashMap<String, Object> userinfor = new HashMap<String, Object>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select * from user_account where name=N'" + username + "'");
			// show data
			while (rs.next()) {
				System.out.println("checkout=" + (rs.getString(1)).trim());
				userinfor.put("fullname", rs.getString(3).trim() + " " + rs.getString(4).trim());
				userinfor.put("birthday", (String) (rs.getString(5).trim()));
				userinfor.put("phone", rs.getString(6).trim());
				userinfor.put("Email", rs.getString(7).trim());
				userinfor.put("address", rs.getString(8).trim());

			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return userinfor;
	}
	
	public int getSumMoney(String username) { // Tổng số tiền khách đã giao dịch
		int sumMoney = 0;
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select sum(totalMoney) from Orders where customer=N'" + username
					+ "' and order_status=N'Thành công'");
			// show data
			while (rs.next()) {
				sumMoney = rs.getInt(1);
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return sumMoney;
	}
}
