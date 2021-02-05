package com.hoan.Model.Entity;

public class CartItem {
	private String itemID;
	private String size;
	private int quantity;
	
	public CartItem(String itemID, String size, int quantity) {
		super();
		this.itemID = itemID;
		this.size = size;
		this.quantity = quantity;
	}
	
	public String getItemID() {
		return itemID;
	}
	public void setItemID(String itemID) {
		this.itemID = itemID;
	}
	public String getSize() {
		return size;
	}
	public void setSize(String size) {
		this.size = size;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	
	
}
