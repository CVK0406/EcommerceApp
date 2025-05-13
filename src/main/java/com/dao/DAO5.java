package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.cart;
import com.entity.contactus;
import com.entity.order_details;
import com.entity.orders;

public class DAO5 {
	private Connection conn;
	
	public DAO5(Connection conn) {
		this.conn = conn;
	}
	
	
	// view all cart
	
	public List<cart> getAllcart(){
		List<cart> listv = new ArrayList<cart>();
		cart v = null;
		String sql = "select * from cart";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				v = new cart();
				v.setCart_id(rs.getInt("cart_id"));
				v.setName(rs.getString("Name"));
				v.setBname(rs.getString("bname"));
				v.setCname(rs.getString("cname"));
				v.setPname(rs.getString("pname"));
				v.setPprice(rs.getInt("pprice"));
				v.setPquantity(rs.getInt("pquantity"));
				v.setPimage(rs.getString("pimage"));
				listv.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}
	
	
	// view all orders
	
	public List<orders> getAllorders(){
		List<orders> listv = new ArrayList<orders>();
		orders v = null;
		String sql = "select * from orders";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				v = new orders();
				v.setOrder_Id(rs.getInt("Order_Id"));
				v.setCustomer_Name(rs.getString("Customer_Name"));
				v.setCustomer_City(rs.getString("Customer_City"));
				v.setDate(rs.getString("Date"));
				v.setTotal_Price(rs.getInt("Total_Price"));
				v.setStatus(rs.getString("Status"));
				listv.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}
	
	
	// view all order_details
	
	
	public List<order_details> getAllorder_details(){
		List<order_details> listv = new ArrayList<order_details>();
		order_details v = null;
		String sql = "select * from order_details";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				v = new order_details();
				v.setDetail_id(rs.getInt("detail_id"));
				v.setOrder_Id(rs.getInt("Order_Id"));
				v.setDate(rs.getString("Date"));
				v.setName(rs.getString("Name"));
				v.setBname(rs.getString("bname"));
				v.setCname(rs.getString("cname"));
				v.setPname(rs.getString("pname"));
				v.setPprice(rs.getInt("pprice"));
				v.setPquantity(rs.getInt("pquantity"));
				v.setPimage(rs.getString("pimage"));
				listv.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}
	
	
	//remove order_details
	
	
	public int removeorder_details(order_details c) {
		int j = 0;
		String sql = "delete from order_details where detail_id = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, c.getDetail_id());
			j = ps.executeUpdate();
			if(j > 0) j = 1;
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return j;
	}
	
	
	// add to contact us
	
	public int addContactus(contactus c) {
		int i = 0;
		String sql = "insert into contactus(Name,Email_Id,Contact_No,Message) values(?,?,?,?)";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, c.getName());
			ps.setString(2, c.getEmail_Id());
			ps.setInt(3, c.getContact_No());
			ps.setString(4, c.getMessage());
			i = ps.executeUpdate();
			if(i > 0) i = 1;
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return i;
	}
	
	
	// view table contactus
	
	public List<contactus> getcontactus(){
		List<contactus> listv = new ArrayList<contactus>();
		contactus v = null;
		String sql = "select * from contactus";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				v = new contactus();
				v.setId(rs.getInt("id"));
				v.setName(rs.getString("Name"));
				v.setEmail_Id(rs.getString("Email_Id"));
				v.setContact_No(rs.getInt("Contact_No"));
				v.setMessage(rs.getString("Message"));
				listv.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}
	
	
	//remove from contactus
	
	
	public int removecont(contactus c) {
		int j = 0;
		String sql = "delete from contactus where id = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, c.getId());
			j = ps.executeUpdate();
			if(j > 0) j = 1;
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return j;
	}
	
	// Add a close method to properly close the connection
	public void close() {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
