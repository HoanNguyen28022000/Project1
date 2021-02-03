package com.hoan.Entity;

import java.util.HashMap;
import java.util.Set;

import com.hoan.Model.Item;
import com.hoan.Model.ItemsInfor;

public class PurchaseItem {
	private Item itemModel= new Item();
	private ItemsInfor itemInforModel= new ItemsInfor();
	
	String itemID;
	HashMap<String, Object> item;
	int purchasePrice;
	int salePrice;
	HashMap<String, Integer> sizes;
	int totalQuantity;
	int totalPurchase;
	
	public PurchaseItem(String itemID) {
		super();
		this.itemID = itemID;
		this.purchasePrice = itemInforModel.getItemPrice(itemID).get(0);
		this.salePrice= itemInforModel.getItemPrice(itemID).get(1);
		this.sizes = new HashMap<String, Integer>();
		this.item=itemModel.getItem(itemID);
		this.totalQuantity= 0;
		this.totalPurchase= 0;
	}
	
	public PurchaseItem(String itemID, int purchasePrice, HashMap<String, Integer> sizes) {
		super();
		this.itemID = itemID;
		this.purchasePrice = purchasePrice;
		this.sizes = sizes;
		this.item=itemModel.getItem(itemID);
		setTotalQuantity();
		setTotalPurchase();
	}
	
	public HashMap<String, Object> getItem() {
		return item;
	}

	public void setItem(HashMap<String, Object> item) {
		this.item = item;
	}

	public int getPurchasePrice() {
		return purchasePrice;
	}
	public void setPurchasePrice(int purchasePrice) {
		this.purchasePrice = purchasePrice;
		setTotalPurchase();
	}

	public int getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(int sale_price) {
		this.salePrice = sale_price;
	}

	public HashMap<String, Integer> getSizes() {
		return sizes;
	}

	public void setSizes(HashMap<String, Integer> sizes) {
		this.sizes = sizes;
		setTotalQuantity();
		setTotalPurchase();
	}
	
	public void addSize(String size, int quantity) {
		this.sizes.put(size, quantity);
		setTotalQuantity();
		setTotalPurchase();
	}
	
	public void updateSize(String size, int quantity) {
		this.sizes.put(size, quantity);
		setTotalQuantity();
		setTotalPurchase();
	}
	
	public void removeSize(String size) {
		this.sizes.remove(size);
		setTotalQuantity();
		setTotalPurchase();
	}
	
	public int getTotalPurchase() {
		return this.totalPurchase;
	}
	
	public void setTotalPurchase() {
		this.totalPurchase= this.totalQuantity*this.purchasePrice;
	}

	public int getTotalQuantity() {
		return totalQuantity;
	}

	public void setTotalQuantity() {
		int sum=0;
		Set<String> keySize= this.sizes.keySet();
		for(String s: keySize) {
			sum+= (int)this.sizes.get(s);
		}
		this.totalQuantity = sum;
	}
	
}
