package com.hoan.Model.Entity;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Set;

public class PurchaseOrder {
	private String orderID;
	private String time;
	private HashMap<String, PurchaseItem> purchaseOrder;
	private int totalPurchase;

	public PurchaseOrder(HashMap<String, PurchaseItem> purchaseOrder) {
		super();
		this.purchaseOrder = purchaseOrder;
		setTotalPurchase();
	}
	
	public PurchaseOrder(String orderID, String time, HashMap<String, PurchaseItem> purchaseOrder, int totalPurchase) {
		super();
		this.orderID=orderID;
		this.time=time;
		this.purchaseOrder = purchaseOrder;
		this.totalPurchase=totalPurchase;
	}
	
	public String getOrderID() {
		return orderID;
	}


	public void setOrderID(String orderID) {
		this.orderID = orderID;
	}


	public String getTime() {
		return time;
	}


	public void setTime(String time) {
		this.time = time;
	}

	public HashMap<String, PurchaseItem> getPurchaseOrder() {
		return purchaseOrder;
	}

	public void setPurchaseOrder(HashMap<String, PurchaseItem> purchaseOrder) {
		this.purchaseOrder = purchaseOrder;
	}


	public int getTotalPurchase() {
		return totalPurchase;
	}


	public void setTotalPurchase() {
		int total=0;
		Set<String> itemIDs= this.purchaseOrder.keySet();
		for (String i: itemIDs) {
			total+= this.purchaseOrder.get(i).getTotalPurchase();
		}
		this.totalPurchase= total;
	}

}
