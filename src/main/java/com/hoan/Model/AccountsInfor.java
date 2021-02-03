package com.hoan.Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

public class AccountsInfor {
	
	private ConnectSQLServer db= new ConnectSQLServer();
	
	public HashMap<String, String> getAccounts() {
		HashMap<String, String> accounts = new HashMap<String, String>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select * from user_account");
			// show data
			while (rs.next()) {
				System.out.println((rs.getString(1)).trim() + " " + (rs.getString(2)).trim());
				accounts.put((rs.getString(1)).trim(), (rs.getString(2)).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return accounts;
	}
	
	public void createAccount(String newUsername, String newPassworld) {
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// insert data into table 'user_account'
			stmt.execute("insert into user_account values('" + newUsername + "','" + newPassworld + "')");

			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
}
