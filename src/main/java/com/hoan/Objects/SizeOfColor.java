package com.hoan.Objects;

import java.util.ArrayList;

public class SizeOfColor {
	private String color;
	private ArrayList<String> sizes;
	
	public SizeOfColor(String color, ArrayList<String> sizes) {
		super();
		this.color = color;
		this.sizes = sizes;
	}
	
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
	public boolean addSize(String color, String size) {
		if(this.color.equals(color)) {
			for (String s:sizes) {
				if (s.equals(size)) return false;
			}
			this.sizes.add(size);
			return true;
		}
		return false;
	}
	
	public boolean removeSize(String color, String size) {
		if(this.color.equals(color)) {
			return this.sizes.remove(size);
		}
		return false;
	}
	
	public ArrayList<String> getSizes() {
		return sizes;
	}
	public void setSize(ArrayList<String> sizes) {
		this.sizes = sizes;
	}
	
}
