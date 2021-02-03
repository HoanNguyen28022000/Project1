package com.hoan.Controller.ajax.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hoan.Model.ConnectSQLServer;
import com.hoan.Model.Item;
import com.hoan.Model.ItemsInfor;

@MultipartConfig
public class ItemActions extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Item itemModel= new Item();
	private ItemsInfor itemInforModel= new ItemsInfor();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		String action = (String) request.getParameter("action");

		if (action.equals("changeStatus")) {
			String status = (String) request.getParameter("status");
			
			ConnectSQLServer connection = new ConnectSQLServer();

			String[] item_selected = request.getParameterValues("item_selected");
			if (item_selected != null) {
				String itemIDs = "(";
				for (int i = 0; i < item_selected.length; i++) {
					if (i == 0)
						itemIDs += "'" + item_selected[i] + "'";
					else
						itemIDs += ", '" + item_selected[i] + "'";
				}
				itemIDs += ")";
//				System.out.println("update Items set status=N'" + status + "' where itemID in " + itemIDs);
				connection.executeNotReturn("update Items set status=N'" + status + "' where itemID in " + itemIDs);
				JSONObject obj = new JSONObject();
				out.print(obj.toJSONString());
				out.flush();
			}
		}

		else if (action.equals("search")) {

			JSONArray listItems = new JSONArray();

			String itemColor, itemImg, itemName, itemType, status;
			int purchase_price, sale_price, available, inventory;

			String nameSearch = (String) request.getParameter("nameSearch");
			/* System.out.println(nameSearch); */
			String[] tags = request.getParameterValues("Tag");
			String selectType = (String) request.getParameter("selectType");
			String selectStatus = (String) request.getParameter("selectStatus");

			ArrayList<String> allItemIDSearch = itemInforModel.getItemSearch(nameSearch, tags, selectStatus, selectType);
			for (String itemID : allItemIDSearch) {
				JSONObject obj = new JSONObject();

				HashMap<String, Object> item = itemModel.getItem(itemID);
				itemColor = (String) item.get("itemColor");
				itemImg = (String) item.get("itemImg");
				itemName = (String) item.get("itemName");
				itemType = (String) item.get("itemType");
				status = (String) item.get("status");

				available = itemInforModel.getSumStockItem(itemID).get(0);
				inventory = itemInforModel.getSumStockItem(itemID).get(1);
				purchase_price = itemInforModel.getItemPrice(itemID).get(0);
				sale_price = itemInforModel.getItemPrice(itemID).get(1);

				obj.put("itemID", itemID);
				obj.put("itemColor", itemColor);
				obj.put("itemName", itemName);
				obj.put("itemImg", itemImg);
				obj.put("itemType", itemType);
				obj.put("available", available);
				obj.put("inventory", inventory);
				obj.put("purchase_price", purchase_price);
				obj.put("sale_price", sale_price);
				obj.put("status", status);

				listItems.add(obj);
			}
			out.print(listItems.toJSONString());
			out.flush();

		}

	}
}
