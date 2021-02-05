package com.hoan.Model.DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Statistical {
	private ConnectSQLServer db = new ConnectSQLServer();

	public int getTotalOut() {
		int totalRevenue = 0;
		try {
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select sum(Total_purchase) as totalRevenue from PurchaseOrders");
			if (rs.next()) {
				totalRevenue = rs.getInt("totalRevenue");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalRevenue;
	}

	public int getTotalOut(int year) {
		int totalRevenue = 0;
		try {
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();

			ResultSet rs = stmt.executeQuery(
					"select sum(Total_purchase) as totalRevenue from PurchaseOrders where year(Time)=" + year);
			if (rs.next()) {
				totalRevenue = rs.getInt("totalRevenue");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalRevenue;
	}

	public int getTotalOut(int year, int month) {
		int totalRevenue = 0;
		try {
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt
					.executeQuery("select sum(Total_purchase) as totalRevenue from PurchaseOrders where year(Time)="
							+ year + " and month(Time)=" + month);
			if (rs.next()) {
				totalRevenue = rs.getInt("totalRevenue");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalRevenue;
	}

	public int getTotalIn() {
		int totalIn = 0;
		try {
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select sum(totalMoney) as totalIn from Orders ");
			if (rs.next()) {
				totalIn = rs.getInt("totalIn");
			}
			System.out.println(totalIn);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalIn;
	}

	public int getTotalIn(int year) {
		int totalIn = 0;
		try {
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt
					.executeQuery("select sum(totalMoney) as totalIn from Orders where year(timeConfirm)=" + year);
			if (rs.next()) {
				totalIn = rs.getInt("totalIn");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalIn;
	}

	public int getTotalIn(int year, int month) {
		int totalIn = 0;
		try {
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery("select sum(totalMoney) as totalIn from Orders where year(timeConfirm)="
					+ year + " and month(timeConfirm)=" + month);
			if (rs.next()) {
				totalIn = rs.getInt("totalIn");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalIn;
	}
}
