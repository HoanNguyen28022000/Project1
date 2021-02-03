package com.hoan.Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

public class ConnectSQLServer {
	private static String DB_URL = "jdbc:sqlserver://localhost:1433;" + "databaseName=project;"
			+ "integratedSecurity=true";
	private static String USER_NAME = "sa";
	private static String PASSWORD = "powzxc2000@";


	public ResultSet executeReturn(String query) {
		ResultSet rs = null;
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			rs = stmt.executeQuery(query);
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return rs;
	}

	public void executeNotReturn(String query) {
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			stmt.execute(query);
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	/**
	 * create connection
	 * 
	 * @author viettuts.vn
	 * @param dbURL:    database's url
	 * @param userName: username is used to login
	 * @param password: password is used to login
	 * @return connection
	 */
	public Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(DB_URL, USER_NAME, PASSWORD);
			System.out.println("connect successfully!");
		} catch (Exception ex) {
			System.out.println("connect failure!");
			ex.printStackTrace();
		}
		return conn;
	}

}