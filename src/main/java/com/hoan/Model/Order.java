package com.hoan.Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class Order {
	private ConnectSQLServer db= new ConnectSQLServer();
	
	public ArrayList<HashMap<String, Object>> getOrder(String orderID) {
		ArrayList<HashMap<String, Object>> order = new ArrayList<HashMap<String, Object>>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select * from Orders where orderID='" + orderID + "'");
			// show data
			while (rs.next()) {
				HashMap<String, Object> orderPart = new HashMap<String, Object>();
				orderPart.put("timeConfirm", (rs.getString("timeConfirm")).trim());
				orderPart.put("username", (rs.getString("customer")).trim());
				orderPart.put("receive_address", (rs.getString("receive_address")).trim());
				orderPart.put("receive_phone", (rs.getString("receive_phone")).trim());
				orderPart.put("totalMoney", rs.getObject("totalMoney"));
				orderPart.put("order_status", (rs.getString("order_status")).trim());
				order.add(orderPart);
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return order;
	}
	
	public void confirmOrder(String orderID, String customer, String receive_address, String receive_phone,
			String timeConfirm, int totalMoney) {
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			String q = "insert into Orders(orderID, customer, receive_address, receive_phone, order_status, timeConfirm, totalMoney) "
					+ "values('" + orderID + "', N'" + customer + "', N'" + receive_address + "', '" + receive_phone
					+ "', N'Chờ xác nhận', cast('" + timeConfirm + "' as datetime), " + String.valueOf(totalMoney)
					+ ")";
			System.out.println(q);
			stmt.execute(
					"insert into Orders(orderID, customer, receive_address, receive_phone, order_status, timeConfirm, totalMoney) "
							+ "values('" + orderID + "', N'" + customer + "', N'" + receive_address + "', '"
							+ receive_phone + "', N'Chờ xác nhận', cast('" + timeConfirm + "' as datetime), "
							+ String.valueOf(totalMoney) + ")");
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public void confirmItems(String orderID, String itemID, int itemQuantity, String size) {    
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			String q = "insert into Order_Item(orderID, itemID, itemQuantity, size) " + "values('" + orderID + "', '"
					+ itemID + "', " + String.valueOf(itemQuantity) + ", '" + size + "')";
			System.out.println(q);
			// get data from table 'student'
			stmt.execute("insert into Order_Item(orderID, itemID, itemQuantity, size) " + "values('" + orderID + "', '"
					+ itemID + "', " + String.valueOf(itemQuantity) + ", '" + size + "')");
//			update_available(itemID, itemQuantity, size);
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public ArrayList<String> getAllOrderItemID(String orderID) {
		ArrayList<String> allItemIDs= new ArrayList<String>();
		try {
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			
			ResultSet rs = stmt.executeQuery("select itemID from Order_Item where orderID= "+orderID);
			while (rs.next()) {
				allItemIDs.add(rs.getString("itemID"));
			}
			// close connection
			conn.close();
		} catch (Exception e) {
			// TODO: handle exception
		}
		return allItemIDs;
	}
	
	public ArrayList<HashMap<String, Object>> getOrderItem(String orderID) {
		ArrayList<HashMap<String, Object>> orderItem = new ArrayList<HashMap<String, Object>>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt
					.executeQuery("select Items.itemID, itemImg, itemName, size,  itemType, color, itemQuantity, "
							+ "(select top 1 percent sale_price from price where price.itemID=Items.itemID and effect_time < timeConfirm order by effect_time desc) as sale_price from Items, Order_Item, Orders "
							+ "where Items.itemID= Order_Item.itemID and Orders.orderID=Order_Item.orderID and Order_Item.orderID='"
							+ orderID + "'");
			// show data
			while (rs.next()) {
				HashMap<String, Object> item = new HashMap<String, Object>();
				item.put("itemID", (rs.getString("itemID")).trim());
				item.put("itemImg", (rs.getString("itemImg")).trim());
				item.put("itemName", (rs.getString("itemName")).trim());
				item.put("size", (rs.getString("size")).trim());
				item.put("itemType", (rs.getString("itemType")).trim());
				item.put("color", (rs.getString("color")).trim());
				item.put("itemQuantity", rs.getInt("itemQuantity"));
				item.put("price", rs.getInt("sale_price"));
				orderItem.add(item);
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return orderItem;
	}
	
	public void addOrderItem(String orderID, String itemsID, String[] size, int[] quantity) {
		try {
			Connection conn = db.getConnection();
			Statement stmt = conn.createStatement();
			
			String sqlQuery= "insert into Order_Item values('"+orderID+"', '"+itemsID+"', "+quantity[0]+", '"+size[0]+"')";
			for (int i=1; i<size.length; i++) {
				sqlQuery += ",('"+orderID+"', '"+itemsID+"', "+quantity[i]+", '"+size[i]+"')";
			}
			
			System.out.println("addOrderItems- "+sqlQuery);
			stmt.execute(sqlQuery);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}
	
	public void removeOrderItems(String orderID, String itemsID) {
		
	}
	
	public void changeStatus(String orderID, String status) {
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			String q = "update Orders set order_status=N'" + status + "' where orderID=" + orderID;
			System.out.println(q);

			stmt.execute("update Orders set order_status=N'" + status + "' where orderID=" + orderID);

			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		if (status.equals("Đang đóng gói")) {
			db.executeNotReturn("update ItemSize set ItemSize.available= ItemSize.available-Order_Item.itemQuantity "
					+ "from ItemSize inner join Order_Item on (ItemSize.itemID= Order_Item.itemID and ItemSize.size= Order_Item.size) "
					+ "where Order_Item.orderID='" + orderID + "'");
		}
		if (status.equals("Đang vận chuyển")) {
			db.executeNotReturn("update ItemSize set ItemSize.inventory= ItemSize.inventory-Order_Item.itemQuantity "
					+ "from ItemSize inner join Order_Item on (ItemSize.itemID= Order_Item.itemID and ItemSize.size= Order_Item.size) "
					+ "where Order_Item.orderID='" + orderID + "'");
		}
		if (status.equals("Bị trả lại")) {
			db.executeNotReturn("update ItemSize set ItemSize.inventory= ItemSize.inventory+Order_Item.itemQuantity, "
					+ " ItemSize.available= ItemSize.available+Order_Item.itemQuantity "
					+ "from ItemSize inner join Order_Item on (ItemSize.itemID= Order_Item.itemID and ItemSize.size= Order_Item.size) "
					+ "where Order_Item.orderID='" + orderID + "'");
		}
		if (status.equals("Bị hủy")) {
			db.executeNotReturn("update ItemSize set ItemSize.available= ItemSize.available+Order_Item.itemQuantity "
					+ "from ItemSize inner join Order_Item on (ItemSize.itemID= Order_Item.itemID and ItemSize.size= Order_Item.size) "
					+ "where Order_Item.orderID='" + orderID + "'");
		}
	}
}
