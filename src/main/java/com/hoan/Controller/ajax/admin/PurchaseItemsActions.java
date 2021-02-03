package com.hoan.Controller.ajax.admin;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.hoan.Entity.PurchaseItem;
import com.hoan.Entity.PurchaseOrder;
import com.hoan.Model.PurchaseOrderInfor;

@MultipartConfig
public class PurchaseItemsActions extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PurchaseOrderInfor POI= new PurchaseOrderInfor();
	private String from=null,to=null;
	private HashMap<String, PurchaseOrder> purchaseOrderHistory;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("utf-8");
		String action = (String) request.getParameter("action");
		String detail= (String)request.getParameter("detail");
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		PurchaseOrder purchaseOrder = (PurchaseOrder) session.getAttribute("PurchaseOrder");

		if (action.equals("getPurchaseItems")) {
			JSONArray jsarr = new JSONArray();

			if (purchaseOrder != null) {
				HashMap<String, PurchaseItem> purchaseItems = purchaseOrder.getPurchaseOrder();
				Set<String> itemIDs = purchaseItems.keySet();
				for (String i : itemIDs) {
					HashMap<String, Object> item = purchaseItems.get(i).getItem();

					JSONObject obj = new JSONObject();
					obj.put("itemID", i);
					obj.put("itemID2", "'" + i + "'");
					obj.put("itemImg", item.get("itemImg"));
					obj.put("itemName", item.get("itemName"));
					obj.put("itemType", item.get("itemType"));
					obj.put("itemColor", item.get("itemColor"));
					obj.put("purchasePrice", purchaseItems.get(i).getPurchasePrice());
					obj.put("salePrice", purchaseItems.get(i).getSalePrice());
					obj.put("totalQuantity", purchaseItems.get(i).getTotalQuantity());
					obj.put("totalPurchase", purchaseItems.get(i).getTotalPurchase());
					jsarr.add(obj);
				}
			}
			out.print(jsarr.toJSONString());
			out.flush();
		} else if (action.equals("getPurchaseItemSizes")) {
			String itemID = request.getParameter("itemID");

			JSONArray jsarr = new JSONArray();
			if (purchaseOrder != null) {
				HashMap<String, Integer> sizes = purchaseOrder.getPurchaseOrder().get(itemID).getSizes();

				Set<String> keySize = sizes.keySet();
				for (String s : keySize) {
					JSONObject obj = new JSONObject();
					obj.put("size", s);
					obj.put("size2", "'" + s + "'");
					obj.put("quantity", sizes.get(s));
					jsarr.add(obj);
				}
			}
			out.print(jsarr.toJSONString());
			out.flush();
		} else if (action.equals("addPurchaseItems")) {
			String[] itemSelected = request.getParameterValues("item_selected");

			if (purchaseOrder != null) {
				for (String itemID : itemSelected) {
					if (!purchaseOrder.getPurchaseOrder().containsKey(itemID))
						purchaseOrder.getPurchaseOrder().put(itemID, new PurchaseItem(itemID));
				}
			} else {
				HashMap<String, PurchaseItem> newPurchaseOrder = new HashMap<String, PurchaseItem>();
				for (String itemID : itemSelected) {
					newPurchaseOrder.put(itemID, new PurchaseItem(itemID));
				}
				session.setAttribute("PurchaseOrder", new PurchaseOrder(newPurchaseOrder));
			}
			JSONObject obj = new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		} else if (action.equals("removePurchaseItems")) {
			String itemID = request.getParameter("itemID");

			purchaseOrder.getPurchaseOrder().remove(itemID);
			purchaseOrder.setTotalPurchase();
			JSONObject obj = new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		} else if (action.equals("updatePurchasePrice")) {
			String itemID = request.getParameter("itemID");
			int purchasePrice = Integer.parseInt(request.getParameter("purchasePrice"));

			purchaseOrder.getPurchaseOrder().get(itemID).setPurchasePrice(purchasePrice);
			purchaseOrder.setTotalPurchase();
			JSONObject obj = new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		} else if (action.equals("updateSalePrice")) {
			String itemID = request.getParameter("itemID");
			int salePrice = Integer.parseInt(request.getParameter("salePrice"));
			System.out.println(salePrice);

			purchaseOrder.getPurchaseOrder().get(itemID).setSalePrice(salePrice);
		}

		else if (action.equals("addSizePurchase")) {
			String itemID = request.getParameter("itemID");
			String size = request.getParameter("size");
			JSONObject obj = new JSONObject();
			if (purchaseOrder.getPurchaseOrder().get(itemID).getSizes().containsKey(size)) {
				obj.put("failed", "đã tồn tại size");
			} else {
				purchaseOrder.getPurchaseOrder().get(itemID).addSize(size, 0);
			}
			purchaseOrder.setTotalPurchase();
			out.print(obj.toJSONString());
			out.flush();
		} else if (action.equals("updateSizePurchase")) {
			String itemID = request.getParameter("itemID");
			String size = request.getParameter("size");
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			purchaseOrder.getPurchaseOrder().get(itemID).updateSize(size, quantity);
			purchaseOrder.setTotalPurchase();
			JSONObject obj = new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		} else if (action.equals("removeSizePurchase")) {
			String itemID = request.getParameter("itemID");
			String size = request.getParameter("size");

			purchaseOrder.getPurchaseOrder().get(itemID).removeSize(size);
			purchaseOrder.setTotalPurchase();
			JSONObject obj = new JSONObject();
			out.print(obj.toJSONString());
			out.flush();
		} else if (action.equals("getTotalPurchase")) {

			JSONObject obj = new JSONObject();
			if (purchaseOrder != null) {
				obj.put("totalPurchase", purchaseOrder.getTotalPurchase());
			} else {
				obj.put("totalPurchase", 0);
			}
			out.print(obj.toJSONString());
			out.flush();
		} else if(action.equals("savePurchaseOrder")) {
			if (purchaseOrder != null) {
				POI.savePurchaseOrder(purchaseOrder);
				session.removeAttribute("PurchaseOrder");
				JSONObject obj = new JSONObject();
				out.print(obj.toJSONString());
			}
			out.flush();
		} else if (action.equals("getPurchaseOrderHistory")) {
			JSONArray jsarr = new JSONArray();
			String from= request.getParameter("from");
			String to= request.getParameter("to");
			System.out.println(from+"-"+to);
			if(!(from.equals(this.from) && to.equals(this.to))) {
				this.from= from;
				this.to= to;
				this.purchaseOrderHistory= POI.getPurchaseOrderHistory(from, to);
			}
			
			if(detail.equals("getPurchaseOrder")) {
				Set<String> orderIDs= this.purchaseOrderHistory.keySet();
				for (String orderID: orderIDs) {
					JSONObject obj = new JSONObject();
					obj.put("orderID", this.purchaseOrderHistory.get(orderID).getOrderID());
					obj.put("orderID2", "'"+this.purchaseOrderHistory.get(orderID).getOrderID()+"'");
					obj.put("time", this.purchaseOrderHistory.get(orderID).getTime());
					obj.put("totalPurchase", this.purchaseOrderHistory.get(orderID).getTotalPurchase());
					jsarr.add(obj);
				}
					
			} else if(detail.equals("getPurchaseItems")) {
				String orderID= request.getParameter("orderID");
				HashMap<String, PurchaseItem> purchaseItems= this.purchaseOrderHistory.get(orderID).getPurchaseOrder();
				Set<String> itemList= purchaseItems.keySet();
				for (String itemID: itemList) {
					JSONObject obj = new JSONObject();
					obj.put("itemID", itemID);
					obj.put("itemID2", "'"+itemID+"'");
					obj.put("orderID2", "'"+orderID+"'");
					obj.put("itemImg", purchaseItems.get(itemID).getItem().get("itemImg"));
					obj.put("itemName", purchaseItems.get(itemID).getItem().get("itemName"));
					obj.put("itemType", purchaseItems.get(itemID).getItem().get("itemType"));
					obj.put("itemColor", purchaseItems.get(itemID).getItem().get("itemColor"));
					obj.put("purchasePrice", purchaseItems.get(itemID).getPurchasePrice());
					obj.put("quantity", purchaseItems.get(itemID).getTotalQuantity());
					obj.put("totalPurchase", purchaseItems.get(itemID).getTotalPurchase());
					jsarr.add(obj);
				}
			}else if(detail.equals("getPurchaseItemSizes")) {
				String orderID= request.getParameter("orderID");
				String itemID= request.getParameter("itemID");
				
				HashMap<String, Integer> sizes= this.purchaseOrderHistory.get(orderID).getPurchaseOrder().get(itemID).getSizes();
				Set<String> sizeList= sizes.keySet();
				for(String s: sizeList) {
					JSONObject obj = new JSONObject();
					obj.put("size", s);
					obj.put("quantity", sizes.get(s));
					jsarr.add(obj);
				}
			}
			
			out.print(jsarr.toJSONString());
			out.flush();
		}

	}

}
