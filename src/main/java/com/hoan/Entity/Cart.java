package com.hoan.Entity;

import java.util.ArrayList;

public class Cart {
	private ArrayList<CartItem> cart;
	private String username;
	
	public Cart(ArrayList<CartItem> cart, String username) {
		super();
		this.cart = cart;
		this.username=username;
	}
	
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}


	public ArrayList<CartItem> getCart() {
		return cart;
	}

	public void setCart(ArrayList<CartItem> cart) {
		this.cart = cart;
	}
	
	public void addCartItem(String itemID, String size, int quantity) {
		for (CartItem ci: cart) {
			if (itemID.equals(ci.getItemID())) {
				return;
			}
		}
		cart.add(new CartItem(itemID, size, quantity));
	}
	
	public void removeCartItem(String itemID) {
		for (CartItem ci: cart) {
			if (itemID.equals(ci.getItemID())) {
				cart.remove(ci);
				break;
			}
		}
	}
	
	
}
