package com.hoan.Model.DAO;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Set;

import com.hoan.Model.Entity.PurchaseItem;
import com.hoan.Model.Entity.PurchaseOrder;

public class PurchaseOrderInfor {
	private ConnectSQLServer db = new ConnectSQLServer();

	public boolean savePurchaseOrder(PurchaseOrder purchaseOrder) {
		Date today = new Date();
		String time = new Timestamp(today.getTime()).toString();
		String orderID = getNextOrderID();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			stmt.execute("insert into PurchaseOrders values('" + orderID + "', " + purchaseOrder.getTotalPurchase()
					+ ", '" + time + "')");
			Set<String> itemIDs = purchaseOrder.getPurchaseOrder().keySet();
			for (String i : itemIDs) {
				PurchaseItem purchaseItem = purchaseOrder.getPurchaseOrder().get(i);

				stmt.execute("insert into PurchaseItems values('" + orderID + "', '" + i + "', "
						+ purchaseItem.getPurchasePrice() + ", " + purchaseItem.getTotalQuantity() + ")");

				stmt.execute("if not exists (select purchase_price, sale_price from price where itemID='" + i
						+ "' and purchase_price=" + purchaseItem.getPurchasePrice() + " and sale_price= "
						+ purchaseItem.getSalePrice() + ") " + "insert into price values ('" + i + "', "
						+ purchaseItem.getPurchasePrice() + ", " + purchaseItem.getSalePrice() + ", '" + time + "')");

				Set<String> sizes = purchaseItem.getSizes().keySet();
				for (String s : sizes) {
					int quantity = purchaseItem.getSizes().get(s);

					stmt.execute("insert into PurchaseItemSizes values('" + orderID + "', '" + i + "', '" + s + "', "
							+ quantity + ")");

					stmt.execute("if '" + s + "' in (select size from ItemSize where itemID='" + i + "') "
							+ "	update ItemSize set inventory= inventory+ " + quantity + ", available= available+"
							+ quantity + " where itemID='" + i + "' and size='" + s + "' " + "else"
							+ "	insert into ItemSize values('" + i + "', '" + s + "', " + quantity + ", " + quantity
							+ ")");
				}
			}
			// close connection
			conn.close();
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();

		}
		return false;
	}

	public String getNextOrderID() {
		String orderID = null;
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select top 1 OrderID from PurchaseOrders order by OrderID DESC");
			while (rs.next()) {
				orderID = rs.getString("OrderID");
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		if (orderID != null) {
			int nextOrderID = Integer.parseInt(orderID) + 1;
			return String.valueOf(nextOrderID);
		} else
			return "100";
	}

	public HashMap<String, PurchaseOrder> getPurchaseOrderHistory(String from, String to) {
		HashMap<String, PurchaseOrder> purchaseOrderHistory = new HashMap<String, PurchaseOrder>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs1 = stmt
					.executeQuery("select * from PurchaseOrders where Time>'" + from + "' and Time<'" + to + "'");
			System.out.println("select * from PurchaseOrders where Time>'" + from + "' and Time<'" + to + "'");
			while (rs1.next()) {
				String orderID= rs1.getString("OrderID");
				String time= rs1.getString("Time");
				int totalPurchase= rs1.getInt("Total_purchase");
				HashMap<String, PurchaseItem> purchaseItems = new HashMap<String, PurchaseItem>();
				Statement stmt2 = conn.createStatement();
				ResultSet rs2 = stmt2
						.executeQuery("select itemID, purchasePrice, quantity from PurchaseItems where OrderID='"
								+ orderID + "'");
				System.out.println("select itemID, purchasePrice, quantity from PurchaseItems where OrderID='"
								+ orderID + "'");
				while (rs2.next()) {
					String itemID= rs2.getString("itemID");
					int purchasePrice= rs2.getInt("purchasePrice");
					Statement stmt3 = conn.createStatement();
					ResultSet rs3 = stmt3.executeQuery("select size, quantity from PurchaseItemSizes where OrderID= '"
							+ orderID + "' and itemID= '" + itemID + "'");
					System.out.println("select size, quantity from PurchaseItemSizes where OrderID= '"
							+ orderID + "' and itemID= '" + itemID + "'");
					HashMap<String, Integer> sizes = new HashMap<String, Integer>();
					while (rs3.next()) {
						sizes.put(rs3.getString("size"), rs3.getInt("quantity"));
					}
					PurchaseItem purchaseItem = new PurchaseItem(itemID, purchasePrice, sizes);
					purchaseItems.put(itemID, purchaseItem);
				}
				PurchaseOrder purchaseOrder = new PurchaseOrder(orderID, time,
						purchaseItems, totalPurchase);
				purchaseOrderHistory.put(orderID, purchaseOrder);
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return purchaseOrderHistory;
	}

}
