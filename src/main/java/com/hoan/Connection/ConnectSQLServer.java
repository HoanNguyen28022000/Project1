package com.hoan.Connection;

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

	public HashMap<String, String> getAccount() {
		HashMap<String, String> accounts = new HashMap<String, String>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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

	public int getSumMoney(String username) {
		int sumMoney = 0;
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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

	public ArrayList<String> getAllUser() {
		ArrayList<String> allUser = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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

	public void confirmOrder(String orderID, String customer, String receive_address, String receive_phone,
			String timeConfirm, int totalMoney) {
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			String q = "insert into Order_Item(orderID, itemID, itemQuantity, size) " + "values('" + orderID + "', '"
					+ itemID + "', " + String.valueOf(itemQuantity) + ", '" + size + "')";
			System.out.println(q);
			// get data from table 'student'
			stmt.execute("insert into Order_Item(orderID, itemID, itemQuantity, size) " + "values('" + orderID + "', '"
					+ itemID + "', " + String.valueOf(itemQuantity) + ", '" + size + "')");
			update_available(itemID, itemQuantity, size);
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void update_available(String itemID, int itemQuantity, String size) {
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			String q = "update ItemSize set available= available-" + String.valueOf(itemQuantity) + " where itemID = '"
					+ itemID + "' size='" + size + "'";
			System.out.println(q);
			// get data from table 'student'
			stmt.execute("update ItemSize set available= available-" + String.valueOf(itemQuantity)
					+ " where itemID = '" + itemID + "' and size='" + size + "'");
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public ArrayList<String> getOrderHistory(String customer) {
		ArrayList<String> orderID = new ArrayList<String>();
		try {

			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt
					.executeQuery("select orderID from Orders where customer=N'" + customer + "' order by timeConfirm desc");
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

	public ArrayList<String> getAllOrderID(String status) {
		ArrayList<String> orderID = new ArrayList<String>();
		try {

			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt
					.executeQuery("select distinct orderID from Orders where order_status like N'" + status + "'");
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

	public ArrayList<HashMap<String, Object>> getOrder(String orderID) {
		ArrayList<HashMap<String, Object>> order = new ArrayList<HashMap<String, Object>>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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

	public ArrayList<HashMap<String, Object>> getOrderItem(String orderID) {
		ArrayList<HashMap<String, Object>> orderItem = new ArrayList<HashMap<String, Object>>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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

	public void createAccount(String newUsername, String newPassworld) {
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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

	public void deleteItem(String itemID) {
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			clearSize(itemID);
			Statement stmt = conn.createStatement();
			stmt.execute("delete from Items where itemID='" + itemID + "'");

			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void changeOrderStatus(int orderID, String status) {
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			String q = "update Orders set order_status=N'" + status + "' where orderID=" + String.valueOf(orderID);
			System.out.println(q);

			stmt.execute("update Orders set order_status=N'" + status + "' where orderID=" + String.valueOf(orderID));

			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void setItem(String itemID, String itemDetail, String itemImg, String itemName, String itemType,
			String dateOfMade, String productionCompany, String madeIn, String itemColor, String status) {
		ArrayList<String> allItemID = getAllItemID("%");
		String q;
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// insert data into table 'user_account'
			if (!allItemID.contains(itemID)) {
				Date today = new Date();
				String dayCreate = new Timestamp(today.getTime()).toString();
				
				q = "insert into Items(itemID, itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany, madeIn, color, status) "
						+ "values('" + itemID + "', N'" + itemDetail + "', N'" + itemImg + "', N'" + itemName + "', N'"
						+ itemType + "', CAST('" + dateOfMade + "' as datetime), N'" + productionCompany + "', N'"
						+ madeIn + "', N'" + itemColor + "', N'" + status + "'); insert into price(itemID, effect_time) values('"+itemID+"', CAST('"+dayCreate+"' as datetime))";
				System.out.println(!allItemID.contains(itemID));
				System.out.println(q);
				stmt.execute(q);
			} /*
				 * else { q = "update Items set itemDetail=N'" + itemDetail + "',itemImg=N'" +
				 * itemImg + "', itemName=N'" + itemName + "', stocking=" + stocking +
				 * ", itemPrice=" + itemPrice + ", itemType=N'" + itemType + "', color=N'" +
				 * itemColor + "' where itemID='" + itemID + "'"; System.out.println(q);
				 * stmt.execute(q); }
				 */
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public ArrayList<HashMap<String, Object>> getHistoryPrice(String itemID) {
		ArrayList<HashMap<String, Object>> historyPrice = new ArrayList<HashMap<String, Object>>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();

			ResultSet rs= stmt.executeQuery("select purchase_price, sale_price, effect_time from price where itemID='"+ itemID +"' order by effect_time desc");
			while (rs.next()) {
				HashMap<String, Object> obj= new HashMap<String, Object>();
				obj.put("purchase_price", rs.getInt("purchase_price"));
				obj.put("sale_price", rs.getInt("sale_price"));
				obj.put("effect_time", rs.getString("effect_time").trim());
				historyPrice.add(obj);
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return historyPrice;
	}
	
	public ArrayList<HashMap<String, Object>> getStock(String itemID) {
		ArrayList<HashMap<String, Object>> stock = new ArrayList<HashMap<String, Object>>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();

			ResultSet rs= stmt.executeQuery("select size, available, inventory from ItemSize where itemID='"+ itemID +"'");
			while (rs.next()) {
				HashMap<String, Object> obj= new HashMap<String, Object>();
				obj.put("size", rs.getString("size").trim());
				obj.put("available", rs.getInt("available"));
				obj.put("inventory", rs.getInt("inventory"));
				stock.add(obj);
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return stock;
	}

	public void clearSize(String itemID) {
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();

			stmt.execute("delete from ItemSize where itemID='" + itemID + "'");

			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

	public void setSize(String itemID, String[] sizes) {
		for (String s : sizes) {
			System.out.println(s);
		}
		try {
			clearSize(itemID);
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();

			String querry = "insert into ItemSize(itemID, size) values";
			for (int i = 0; i < sizes.length; i++) {
				if (i == 0)
					querry += "('" + itemID + "', " + sizes[i] + ")";
				else
					querry += ",('" + itemID + "', " + sizes[i] + ")";
			}
			System.out.println(querry);
			// insert data into table 'user_account'
			stmt.execute(querry);

			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}

//	public String getImagePath(String imgName) {
//		String imgPath = null;
//		try {
//			// connnect to database 'testdb'
//			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
//			// crate statement
//			Statement stmt = conn.createStatement();
//			// insert data into table 'user_account'
//			ResultSet rs = stmt.executeQuery("select imgPath from images where imgName='" + imgName + "'");
//			while (rs.next()) {
//				imgPath = rs.getString(1);
//				System.out.println("get " + imgPath);
//			}
//			// close connection
//			conn.close();
//		} catch (Exception ex) {
//			ex.printStackTrace();
//		}
//		return imgPath;
//	}

	public String getCurrImageName() {
		String currImageName = null;
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// insert data into table 'user_account'
			ResultSet rs = stmt.executeQuery("select top 1 percent imgName from images order by imageID DESC");
			while (rs.next()) {
				currImageName = rs.getString(1);
				System.out.println("curr=" + currImageName);
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return currImageName;
	}

	public HashMap<String, Integer> getSize(String itemID) {
		HashMap<String, Integer> sizeItem = new HashMap<String, Integer>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery(
					"select size, available from ItemSize where itemID='" + itemID + "' order by size ASC;");
			// show data
			while (rs.next()) {
				sizeItem.put(rs.getString(1).trim(), rs.getInt(2));
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return sizeItem;
	}

	public HashMap<String, String> getSameItemColor(String itemName, String color) {
		HashMap<String, String> itemColor = new HashMap<String, String>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery(
					"select itemID,color from Items where itemName='" + itemName + "' and color!=N'" + color + "'");
			// show data
			while (rs.next()) {
//            	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
				itemColor.put((rs.getString(1)).trim(), (rs.getString(2)).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return itemColor;
	}

	public ArrayList<String> getItemType() {
		ArrayList<String> itemType = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select distinct itemType from Items");
			// show data
			while (rs.next()) {
//            	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
				itemType.add((String) (rs.getString(1)).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return itemType;
	}

	public ArrayList<String> getAllItemID(String status) {
		ArrayList<String> allItemID = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select itemID from Items where status like N'" + status + "'");
			// show data
			while (rs.next()) {
//            	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
				allItemID.add((String) (rs.getString(1)).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return allItemID;
	}

	public ArrayList<String> getAllItemType(String itemType, String status) {
		ArrayList<String> allItemID = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery(
					"select itemID from Items where itemType='" + itemType + "' and status like N'" + status + "'");
			// show data
			while (rs.next()) {
//            	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
				allItemID.add((String) (rs.getString(1)).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return allItemID;
	}

	public String getNextOrderID() {
		String orderID = null;
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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

	public HashMap<String, Object> getItem(String itemID) {
		HashMap<String, Object> item = new HashMap<String, Object>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select * from Items where itemID='" + itemID + "'");
			// show data
			while (rs.next()) {
//            	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
				item.put("itemDetail", (String) (rs.getString(2)).trim());
				item.put("itemImg", (String) (rs.getString(3)).trim());
				item.put("itemName", (String) (rs.getString(4)).trim());
				item.put("itemType", (String) (rs.getString(5)).trim());
				item.put("dateOfMade", (String) (rs.getString(6)).trim());
				item.put("productionCompany", (String) (rs.getString(7)).trim());
				item.put("madeIn", (String) (rs.getString(8)).trim());
				item.put("itemColor", (String) (rs.getString(9)).trim());
				item.put("status", (String) (rs.getString(10)).trim());
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return item;
	}

	public ArrayList<String> getItemSearch(String itemSearch, String[] tags, String status, String selectType) {
		ArrayList<String> allItemIDSearch = new ArrayList<String>();
		if (tags != null && itemSearch != null) {
			try {
				// connnect to database 'testdb'
				Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
				// crate statement
				Statement stmt = conn.createStatement();

				String q = "select distinct T1.itemID from tag_item as T1, Items where ";
				String listTag = "(select tag from tag_item as T2 where T2.itemID=T1.itemID)";
				for (int i = 0; i < tags.length; i++) {
					if (i == 0) {
						q += " N'" + tags[i] + "' in " + listTag;
					} else {
						q += " and N'" + tags[i] + "' in " + listTag;
					}
				}
				q += "and Items.itemID=T1.itemID and (itemName like N'%" + itemSearch + "%' or itemType like N'%"
						+ itemSearch + "%') and status like N'" + status + "' and itemType like N'" + selectType + "'";
				System.out.println(q);

				ResultSet rs = stmt.executeQuery(q);
				while (rs.next()) {
					allItemIDSearch.add(rs.getString("itemID").trim());
				}
				// close connection
				conn.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else if (tags != null) {
			try {
				String q = "select distinct T1.itemID from tag_item as T1, Items where itemType like N'" + selectType
						+ "' and status like N'" + status + "'";
				String listTag = "(select tag from tag_item as T2 where T2.itemID=T1.itemID)";
				for (int i = 0; i < tags.length; i++) {
					if (i == 0) {
						q += " N'" + tags[i] + "' in " + listTag;
					} else {
						q += " and N'" + tags[i] + "' in " + listTag;
					}
				}
				System.out.println(q);
				// connnect to database 'testdb'
				Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
				// crate statement
				Statement stmt = conn.createStatement();
				// get data from table 'student'
				ResultSet rs = stmt.executeQuery(q);
				// show data
				while (rs.next()) {
					allItemIDSearch.add((String) (rs.getString(1)).trim());
				}
				// close connection
				conn.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
		} else if (itemSearch != null) {
			try {
				Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
				// crate statement
				Statement stmt = conn.createStatement();
				String q = "select itemID from Items where (itemName like N'%" + itemSearch + "%' or itemType like N'%"
						+ itemSearch + "%') and status like N'" + status + "' and itemType like N'" + selectType + "'";
				System.out.println(q);

				ResultSet rs = stmt.executeQuery(q);
				while (rs.next()) {
					allItemIDSearch.add(rs.getString("itemID").trim());
				}
				// close connection
				conn.close();

			} catch (Exception e) {
				// TODO: handle exception
			}
		} else
			allItemIDSearch = getAllItemID(status);
		return allItemIDSearch;
	}
	////////////////////////////////////////////////////////
	public ArrayList<String> getTags() {
		ArrayList<String> tags = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select distinct tag from tag_item");
			// show data
			while (rs.next()) {
//            	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
				tags.add(rs.getString("tag"));
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return tags;
	}
	
	public ArrayList<String> getTags(String itemID) {
		ArrayList<String> item_tags = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select tag from tag_item where itemID='"+itemID+"'");
			// show data
			while (rs.next()) {
//            	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
				item_tags.add(rs.getString("tag"));
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return item_tags;
	}

	public ArrayList<Integer> getStockingItem(String itemID) {
		ArrayList<Integer> stockingItem = new ArrayList<Integer>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery(
					"select sum(available) as available, sum(inventory) as inventory  from ItemSize where itemID='"
							+ itemID + "'");
			// show data
			while (rs.next()) {
//            	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
				stockingItem.add(rs.getInt("available"));
				stockingItem.add(rs.getInt("inventory"));

			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return stockingItem;
	}

	public ArrayList<Integer> getItemPrice(String itemID) {
		ArrayList<Integer> itemPrice = new ArrayList<Integer>();
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
			// crate statement
			Statement stmt = conn.createStatement();
			// get data from table 'student'
			ResultSet rs = stmt.executeQuery("select top 1 percent purchase_price, sale_price from price where itemID='"
					+ itemID + "' order by effect_time desc");
			// show data
			while (rs.next()) {
				itemPrice.add(rs.getInt("purchase_price"));
				itemPrice.add(rs.getInt("sale_price"));
			}
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return itemPrice;
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

	public ResultSet executeReturn(String query) {
		ResultSet rs = null;
		try {
			// connnect to database 'testdb'
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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
			Connection conn = getConnection(DB_URL, USER_NAME, PASSWORD);
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

	public Connection getConnection(String dbURL, String userName, String password) {
		Connection conn = null;
		try {
			Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
			conn = DriverManager.getConnection(dbURL, userName, password);
			System.out.println("connect successfully!");
		} catch (Exception ex) {
			System.out.println("connect failure!");
			ex.printStackTrace();
		}
		return conn;
	}

}