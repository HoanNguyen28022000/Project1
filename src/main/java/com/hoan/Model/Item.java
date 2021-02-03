package com.hoan.Model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.HashMap;

public class Item {
	private ConnectSQLServer db= new ConnectSQLServer();
	
	public HashMap<String, Object> getItem(String itemID) {
		HashMap<String, Object> item = new HashMap<String, Object>();
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
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
	
	public boolean insertItem(String itemID, String itemDetail, String itemImg, String itemName, String itemType,
			String dateOfMade, String productionCompany, String madeIn, String itemColor, String status) {
		boolean check = false;
		String q;
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			q = "insert into Items(itemID, itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany, madeIn, color, status) "
					+ "values('" + itemID + "', N'" + itemDetail + "', N'" + itemImg + "', N'" + itemName + "', N'"
					+ itemType + "', CAST('" + dateOfMade + "' as datetime), N'" + productionCompany + "', N'" + madeIn
					+ "', N'" + itemColor + "', N'mới');";
			System.out.println(q);
			check = stmt.execute(q);
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return check;
	}
	
	public boolean updateItem(String itemID, String itemDetail, String itemImg, String itemName, String itemType,
			String dateOfMade, String productionCompany, String madeIn, String itemColor) {   
		boolean check = false;
		String q;
		try {
			// connnect to database 'testdb'
			Connection conn = db.getConnection();
			// crate statement
			Statement stmt = conn.createStatement();
			// insert data into table 'user_account'
			q = "update Items set itemDetail=N'" + itemDetail + "',itemImg=N'" + itemImg + "', itemName=N'" + itemName
					+ "', itemType=N'" + itemType + "', dateOfMade=CAST('" + dateOfMade + "' as datetime),productionCompany=N'"
					+ productionCompany + "', madeIn=N'" + madeIn + "', color=N'" + itemColor + "' where itemID='"
					+ itemID + "'";
			System.out.println(q);
			check = stmt.execute(q);
			// close connection
			conn.close();
		} catch (Exception ex) {
			ex.printStackTrace();
		}
		return check;
	}
}
