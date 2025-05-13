package com.entity;

public class customer {

	private int customer_id;
	private String Name;
	private String Password;
	private String Email_Id;
	private String Contact_No;
	
	
	
	
	public customer() {
		
	}
	
	public int getCustomer_id() {
		return customer_id;
	}
	
	public void setCustomer_id(int customer_id) {
		this.customer_id = customer_id;
	}
	
	public String getName() {
		return Name;
	}
	public void setName(String name) {
		Name = name;
	}
	public String getPassword() {
		return Password;
	}
	public void setPassword(String password) {
		Password = password;
	}
	public String getEmail_Id() {
		return Email_Id;
	}
	public void setEmail_Id(String email_Id) {
		Email_Id = email_Id;
	}
	public String getContact_No() {
		return Contact_No;
	}
	public void setContact_No(String contact_No) {
		Contact_No = contact_No;
	}
	
	
	
	
}
