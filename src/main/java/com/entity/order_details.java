package com.entity;

public class order_details {
	
	private int detail_id;
	private int Order_Id;
	private String Date;
	private String Name;
	private String bname;
	private String cname;
	private String pname;
	private int pprice;
	private int pquantity;
	private String pimage;
	
	
	public order_details() {
		
	}


	public int getDetail_id() {
		return detail_id;
	}


	public void setDetail_id(int detail_id) {
		this.detail_id = detail_id;
	}


	public int getOrder_Id() {
		return Order_Id;
	}


	public void setOrder_Id(int order_Id) {
		Order_Id = order_Id;
	}


	public String getDate() {
		return Date;
	}


	public void setDate(String date) {
		Date = date;
	}


	public String getName() {
		return Name;
	}


	public void setName(String name) {
		Name = name;
	}


	public String getBname() {
		return bname;
	}


	public void setBname(String bname) {
		this.bname = bname;
	}


	public String getCname() {
		return cname;
	}


	public void setCname(String cname) {
		this.cname = cname;
	}


	public String getPname() {
		return pname;
	}


	public void setPname(String pname) {
		this.pname = pname;
	}


	public int getPprice() {
		return pprice;
	}


	public void setPprice(int pprice) {
		this.pprice = pprice;
	}


	public int getPquantity() {
		return pquantity;
	}


	public void setPquantity(int pquantity) {
		this.pquantity = pquantity;
	}


	public String getPimage() {
		return pimage;
	}


	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	
	
	
	

}
