package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.entity.order_details;
import com.entity.orders;

public class DAO4 {
	private Connection conn;
	
	public DAO4(Connection conn) {
		this.conn = conn;
	}
	
	
	//check cart by null
	
	public boolean checkcart() {
	    boolean f = false;
	    String sql = "select * from cart where Name is NULL";
	    try (PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        f = rs.next();
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return f;
	}
	
	//check cart by name
	
	public boolean checkcart2(String nm) {
	    boolean f = false;
	    String sql = "select * from cart where Name = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, nm);
	        try (ResultSet rs = ps.executeQuery()) {
	            f = rs.next();
	        }
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return f;
	}
	
	// add to orders
	
	public int addOrders(orders o) {
	    int i = 0;
	    String sql = "insert into orders(Customer_Name,Customer_City,Date,Total_Price,Status) values(?,?,?,?,?)";
	    try (PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
	        ps.setString(1, o.getCustomer_Name());
	        ps.setString(2, o.getCustomer_City());
	        ps.setString(3, o.getDate());
	        ps.setInt(4, o.getTotal_Price());
	        ps.setString(5, o.getStatus());
	        i = ps.executeUpdate();
	        
	        if(i > 0) {
	            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
	                if (generatedKeys.next()) {
	                    o.setOrder_Id(generatedKeys.getInt(1));
	                }
	            }
	            i = 1;
	        }
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return i;
	}
	
	// add to order_details for guest users
	
	public int addOrder_details(int orderId, String date) {
	    int j = 0;
	    String sql = "INSERT INTO order_details (Order_Id, Date, Name, bname, cname, pname, pprice, pquantity, pimage) " +
	                 "SELECT ?, ?, Name, bname, cname, pname, pprice, pquantity, pimage FROM cart WHERE Name IS NULL";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, orderId);
	        ps.setString(2, date);
	        j = ps.executeUpdate();
	        if(j > 0) j = 1;
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return j;
	}
		
	//add to order_details for registered users
	
	public int addOrder_details2(int orderId, String date, String name) {
	    int j = 0;
	    String sql = "INSERT INTO order_details (Order_Id, Date, Name, bname, cname, pname, pprice, pquantity, pimage) " +
	                 "SELECT ?, ?, Name, bname, cname, pname, pprice, pquantity, pimage FROM cart WHERE Name = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, orderId);
	        ps.setString(2, date);
	        ps.setString(3, name);
	        j = ps.executeUpdate();
	        if(j > 0) j = 1;
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return j;
	}
			
	//delete cart for guest users
		
	public int deletecart() {
	    int k = 0;
	    String sql = "delete from cart where Name is NULL";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        k = ps.executeUpdate();
	        if(k > 0) k = 1;
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return k;
	}
		
	//delete cart for registered users
		
	public int deletecart2(String st) {
	    int k = 0;
	    String sql = "delete from cart where Name = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, st);
	        k = ps.executeUpdate();
	        if(k > 0) k = 1;
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return k;
	}
		
	//update order_details for guest users
		
	public int updateOrder_details(order_details od) {
	    int l = 0;
	    String sql = "update order_details set Date = ?, Name = ? where Date is NULL and Order_Id = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, od.getDate());
	        ps.setString(2, od.getName());
	        ps.setInt(3, od.getOrder_Id());
	        l = ps.executeUpdate();
	        if(l > 0) l = 1;
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return l;
	}

	//update order_details for registered users

	public int updateOrder_details2(order_details od) {
	    int l = 0;
	    String sql = "update order_details set Date = ? where Date is NULL and Order_Id = ?";
	    try (PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, od.getDate());
	        ps.setInt(2, od.getOrder_Id());
	        l = ps.executeUpdate();
	        if(l > 0) l = 1;
	    } catch(Exception ex) {
	        System.out.println(ex.getMessage());
	    }
	    return l;
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
