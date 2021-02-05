package com.hoan.Controller.ajax.admin;


import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hoan.Model.DAO.ConnectSQLServer;
import com.hoan.Model.DAO.Item;
import com.hoan.Model.DAO.ItemsInfor;

@MultipartConfig(fileSizeThreshold=1024*1024*1,
maxFileSize=1024*1024*10, maxRequestSize=1024*1024*100)
public class ItemEditActions extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Item itemModel= new Item();
	private ItemsInfor itemInforModel= new ItemsInfor();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");

		String action = (String) request.getParameter("action");
		System.out.println(action);

		if (action.equals("edit")) {

			String itemID = (String) request.getParameter("itemID");
			String itemImg = (String) itemModel.getItem("itemID").get("itemImg");
			String itemDetail = (String) request.getParameter("itemDetail");
			String itemName = (String) request.getParameter("itemName");
			String itemType = (String) request.getParameter("itemType");
			String productionCompany = (String) request.getParameter("productionCompany");
			String madeIn = (String) request.getParameter("madeIn");
			String itemColor = (String) request.getParameter("itemColor");
			String dateOfMade = ((String) request.getParameter("dateOfMade"));

			Part filePart = request.getPart("file");
			if (filePart.getSubmittedFileName() != "") {
				String filename = filePart.getSubmittedFileName();
				System.out.println(filename);
				String filePath = "E:\\HOC TAP\\Lap Trinh\\JAVA\\WorkSpace\\com.spring-mvc-demo\\src\\main\\webapp\\resources\\images\\"
						+ filename;
				itemImg = "/com.spring-mvc-demo/resources/images/" + filename;
				filePart.write(filePath);
				itemModel.updateItem(itemID, itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany,
						madeIn, itemColor);

				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			} else {
				System.out.println(itemImg);
				itemModel.updateItem(itemID, itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany,
						madeIn, itemColor);

			}
			response.sendRedirect("http://localhost:8080/com.spring-mvc-demo/Admin/Items/Edit?itemID=" + itemID);

		} else if (action.equals("insert")) {

			String itemID = (String) request.getParameter("itemID");
			String itemImg = (String) itemModel.getItem("itemID").get("itemImg");
			String itemDetail = (String) request.getParameter("itemDetail");
			String itemName = (String) request.getParameter("itemName");
			String itemType = (String) request.getParameter("itemType");
			String productionCompany = (String) request.getParameter("productionCompany");
			String madeIn = (String) request.getParameter("madeIn");
			String itemColor = (String) request.getParameter("itemColor");
			String dateOfMade = ((String) request.getParameter("dateOfMade"));

			Part filePart = request.getPart("file");
			String filename = filePart.getSubmittedFileName();
			String filePath = "E:\\HOC TAP\\Lap Trinh\\JAVA\\WorkSpace\\com.spring-mvc-demo\\src\\main\\webapp\\resources\\images\\"
					+ filename;
			itemImg = "/com.spring-mvc-demo/resources/images/" + filename;

			filePart.write(filePath);

			if(itemModel.insertItem(itemID, itemDetail, itemImg, itemName, itemType, dateOfMade, productionCompany,
					madeIn, itemColor, "mới")) {
				request.setAttribute("insert", "failed");
			}

			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			response.sendRedirect("http://localhost:8080/com.spring-mvc-demo/Admin/Items");
		} else if (action.equals("updateSalePrice")) {
			String itemID = (String) request.getParameter("itemID");
			String salePriceUpdate = (String) request.getParameter("salePriceUpdate");
			String purchase_price = (String) request.getParameter("purchase_price");
			ConnectSQLServer connection = new ConnectSQLServer();

			Date today = new Date();
			String dayCreate = new Timestamp(today.getTime()).toString();
			System.out.println("insert into price values('" + itemID + "', " + purchase_price + ", " + salePriceUpdate
					+ ", '" + dayCreate + "')");
			connection.executeNotReturn("insert into price values('" + itemID + "', " + purchase_price + ", "
					+ salePriceUpdate + ", '" + dayCreate + "')");
			PrintWriter out = response.getWriter();
			JSONObject obj = new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		} else if (action.equals("deleteTag")) {

			String itemID = (String) request.getParameter("itemID");
			String tag = (String) request.getParameter("tag");

			ConnectSQLServer connection = new ConnectSQLServer();
			System.out.println("delete from tag_item where itemID='" + itemID + "' and tag=N'" + tag + "'");
			connection.executeNotReturn("delete from tag_item where itemID='" + itemID + "' and tag=N'" + tag + "'");

			JSONObject obj = new JSONObject();
			PrintWriter out = response.getWriter();
			out.print(obj.toJSONString());
			out.flush();
			out.close();
		} else if (action.equals("insertTag")) {
			String itemID = (String) request.getParameter("itemID");
			String tag = (String) request.getParameter("tag");

			ConnectSQLServer connection = new ConnectSQLServer();
			System.out.println("insert into tag_item values('" + itemID + "', N'" + tag + "')");
			connection.executeNotReturn("insert into tag_item values('" + itemID + "', N'" + tag + "')");

			JSONObject obj = new JSONObject();
			PrintWriter out = response.getWriter();
			out.print(obj.toJSONString());
			out.flush();
			out.close();
		} else if (action.equals("getTag")) {
			JSONArray data = new JSONArray();

			String itemID = request.getParameter("itemID");
			ArrayList<String> item_tags = itemInforModel.getTags(itemID);
			for (String tag : item_tags) {
				JSONObject obj = new JSONObject();
				obj.put("itemID", "'" + itemID + "'");
				obj.put("tagFunc", "'" + tag + "'");
				obj.put("tag", tag);
				data.add(obj);
				System.out.println(tag);
			}
			PrintWriter out = response.getWriter();
			out.print(data.toJSONString());
			out.flush();
			out.close();
		}
	}

}
