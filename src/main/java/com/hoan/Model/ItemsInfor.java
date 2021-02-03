package com.hoan.Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class ItemsInfor {
	private ConnectSQLServer db= new ConnectSQLServer();

	////////////////////////////////////////////////////////
	public ArrayList<String> getTags() {
		ArrayList<String> tags = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
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
		Connection conn = db.getConnection();
		// crate statement
		Statement stmt = conn.createStatement();
		// get data from table 'student'
		ResultSet rs = stmt.executeQuery("select tag from tag_item where itemID='" + itemID + "'");
		// show data
		while (rs.next()) {
//        	System.out.println((rs.getString(1)).trim()+" "+(rs.getString(2)).trim());
			item_tags.add(rs.getString("tag"));
		}
		// close connection
		conn.close();
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	return item_tags;
}

	public ArrayList<String> getItemType() {
		ArrayList<String> itemType = new ArrayList<String>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
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
			Connection conn = db.getConnection();
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
			Connection conn = db.getConnection();
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
	
	public ArrayList<String> getItemSearch(String itemSearch, String[] tags, String status, String selectType) {
		ArrayList<String> allItemIDSearch = new ArrayList<String>();
		if (tags != null && itemSearch != null) {
			try {
				// connnect to database 'testdb'
				Connection conn = db.getConnection();
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
				Connection conn = db.getConnection();
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
				Connection conn = db.getConnection();
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
	
	public HashMap<String, String> getSameItemColor(String itemName, String color) {
		HashMap<String, String> itemColor = new HashMap<String, String>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
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
	
	public ArrayList<HashMap<String, Object>> getHistoryPrice(String itemID) {
		ArrayList<HashMap<String, Object>> historyPrice = new ArrayList<HashMap<String, Object>>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();

			ResultSet rs = stmt.executeQuery("select * from price where itemID='"
					+ itemID + "' order by effect_time desc");
			while (rs.next()) {
				HashMap<String, Object> obj = new HashMap<String, Object>();
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
	
	public ArrayList<Integer> getSumStockItem(String itemID) {  
		ArrayList<Integer> stockingItem = new ArrayList<Integer>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
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
	
	public ArrayList<HashMap<String, Object>> getStock(String itemID) {
		ArrayList<HashMap<String, Object>> stock = new ArrayList<HashMap<String, Object>>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();

			ResultSet rs = stmt
					.executeQuery("select size, available, inventory from ItemSize where itemID='" + itemID + "'");
			while (rs.next()) {
				HashMap<String, Object> obj = new HashMap<String, Object>();
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
	
	public HashMap<String, Integer> getSize(String itemID) {
		HashMap<String, Integer> sizeItem = new HashMap<String, Integer>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
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
	
	public void setSize(String itemID, String[] sizes) {
		for (String s : sizes) {
			System.out.println(s);
		}
		try {
			clearSize(itemID);
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
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
	
	public void clearSize(String itemID) {   
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();

			stmt.execute("delete from ItemSize where itemID='" + itemID + "'");

			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	public ArrayList<Integer> getItemPrice(String itemID) {  
		ArrayList<Integer> itemPrice = new ArrayList<Integer>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
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

}
