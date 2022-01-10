package com.koreait.cobox.model.domain;

import org.springframework.web.multipart.MultipartFile;

public class Snack {

	private int snack_id;
	private int topcategory_id;
	private String snack_name;
	private int price;
	private int amount;
	private String detail;
	private String filename;
	private int sales_amount;
	
	public int getSales_amount() {
		return sales_amount;
	}
	public void setSales_amount(int sales_amount) {
		this.sales_amount = sales_amount;
	}
	public String getFilename() {
		return filename;
	}
	public MultipartFile getRepImg() {
		return repImg;
	}
	public void setRepImg(MultipartFile repImg) {
		this.repImg = repImg;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	private MultipartFile repImg;
	
	public int getSnack_id() {
		return snack_id;
	}
	public void setSnack_id(int snack_id) {
		this.snack_id = snack_id;
	}
	public int getTopcategory_id() {
		return topcategory_id;
	}
	public void setTopcategory_id(int topcategory_id) {
		this.topcategory_id = topcategory_id;
	}
	public String getSnack_name() {
		return snack_name;
	}
	public void setSnack_name(String snack_name) {
		this.snack_name = snack_name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
}
