package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


import com.entity.cart;

import com.entity.laptop;
import com.entity.mobile;
import com.entity.orders;
import com.entity.order_details;
import com.entity.tv;
import com.entity.watch;




public class DAO3 {
	private Connection conn;
	
	public DAO3(Connection conn) {
		this.conn = conn;
	}
	
	
	// view tv
	
	public List<tv> getAlltv(){
		List<tv> listv = new ArrayList<tv>();
		tv v = null;
		String sql = "select * from tv";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				v = new tv();
				v.setBname(rs.getString(1));
				v.setCname(rs.getString(2));
				v.setPname(rs.getString(3));
				v.setPprice(rs.getInt(4));
				v.setPquantity(rs.getInt(5));
				v.setPimage(rs.getString(6));
				listv.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}
	
	// view laptop
	
	public List<laptop> getAlllaptop(){
		List<laptop> listv = new ArrayList<laptop>();
		laptop v = null;
		String sql = "select * from laptop";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				v = new laptop();
				v.setBname(rs.getString(1));
				v.setCname(rs.getString(2));
				v.setPname(rs.getString(3));
				v.setPprice(rs.getInt(4));
				v.setPquantity(rs.getInt(5));
				v.setPimage(rs.getString(6));
				listv.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}

	// view mobile
	
	public List<mobile> getAllmobile(){
		List<mobile> listv = new ArrayList<mobile>();
		mobile v = null;
		String sql = "select * from mobile";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				v = new mobile();
				v.setBname(rs.getString(1));
				v.setCname(rs.getString(2));
				v.setPname(rs.getString(3));
				v.setPprice(rs.getInt(4));
				v.setPquantity(rs.getInt(5));
				v.setPimage(rs.getString(6));
				listv.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}
	
	// view watch
	
	public List<watch> getAllwatch(){
		List<watch> listv = new ArrayList<watch>();
		watch v = null;
		String sql = "select * from watch";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				v = new watch();
				v.setBname(rs.getString(1));
				v.setCname(rs.getString(2));
				v.setPname(rs.getString(3));
				v.setPprice(rs.getInt(4));
				v.setPquantity(rs.getInt(5));
				v.setPimage(rs.getString(6));
				listv.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}

	//==================================
	// addtocartnull
	
	public boolean checkaddtocartnull(cart c) {
		boolean f = false;
		String sql = "select * from cart where Name =? and bname=? and cname =? and pname = ? and pprice = ? and pimage = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1,c.getName());
			ps.setString(2, c.getBname());
			ps.setString(3, c.getCname());
			ps.setString(4, c.getPname());
			ps.setInt(5, c.getPprice());
			ps.setString(6, c.getPimage());
			try (ResultSet rs = ps.executeQuery()) {
				f = rs.next();
			}
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return f;
	}
	
	// update cart	
	public int updateaddtocartnull(cart c) {
		int i = 0;
		String sql = "update cart set pquantity = (pquantity + 1) where Name =? and bname = ? and cname = ? and pname = ? and pprice = ? and pimage = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, c.getName());
			ps.setString(2, c.getBname());
			ps.setString(3, c.getCname());
			ps.setString(4, c.getPname());
			ps.setInt(5, c.getPprice());
			ps.setString(6, c.getPimage());
			i = ps.executeUpdate();
			if(i > 0) i = 1;
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return i;
	}
	
	public int addtocartnull(cart c) {
		int i = 0;
		String sql = "insert into cart (Name, bname, cname, pname, pprice, pquantity, pimage) values(?,?,?,?,?,?,?)";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, c.getName());
			ps.setString(2, c.getBname());
			ps.setString(3, c.getCname());
			ps.setString(4, c.getPname());
			ps.setInt(5, c.getPprice());
			ps.setInt(6, c.getPquantity());
			ps.setString(7, c.getPimage());
			i = ps.executeUpdate();
			if(i > 0)
				i = 1;
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return i;
	}
	
	// view orders
	
	public List<orders> getOrders(String o) {
		List<orders> listv = new ArrayList<orders>();
		orders v = null;
		String sql = "select * from orders where Customer_Name = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, o);
			try (ResultSet rs = ps.executeQuery()) {
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}
	
	//view orders by Date
	
	public List<orders> getOrdersbydate(String d) {
		List<orders> listv = new ArrayList<orders>();
		orders v = null;
		String sql = "select * from orders where Date = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, d);
			try (ResultSet rs = ps.executeQuery()) {
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listv;
	}
	
	//view order_details by date
	
	public List<order_details> getOrderdetails(String d) {
		List<order_details> listd = new ArrayList<order_details>();
		order_details v = null;
		String sql = "select * from order_details where Date = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, d);
			try (ResultSet rs = ps.executeQuery()) {
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
					listd.add(v);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listd;
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
