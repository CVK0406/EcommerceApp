package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.entity.cart;
import com.entity.customer;
import com.entity.orders;
import com.entity.usermaster;
import com.entity.viewlist;

public class DAO2 {
	private Connection conn;
	
	public DAO2(Connection conn) {
		this.conn = conn;
	}
	
	// viewproduct
	
	public List<viewlist> getAllviewlist(){
		List<viewlist> listv = new ArrayList<viewlist>();
		
		viewlist v = null;
		
		String sql = "select * from viewlist";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next())
			{
				v = new viewlist();
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
	
	
	// check customer login
	
	public boolean checkcust(customer cust)
	{
		boolean f = false;
	
	
		try{
			String sql = "select * from customer  where Password=? and Email_Id=?";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				ps.setString(1, cust.getPassword());
				ps.setString(2, cust.getEmail_Id());
				
				try (ResultSet rs = ps.executeQuery()) {
					f = rs.next();
				}
			}
		}catch(Exception ex){
		   System.out.println(ex.getMessage());
		}
		return f;
			
	}
	
	// check admin login
	
		public boolean checkadmin(usermaster admin)
		{
			boolean f = false;
		
		
			try{
				String sql = "select * from usermaster  where Name=? and Password=?";
				try (PreparedStatement ps = conn.prepareStatement(sql)) {
					ps.setString(1, admin.getName());
					ps.setString(2, admin.getPassword());
					
					try (ResultSet rs = ps.executeQuery()) {
						f = rs.next();
					}
				}
			}catch(Exception ex){
			   System.out.println(ex.getMessage());
			}
			return f;
				
		}
		
		// customer registration
		
		public int addcustomer(customer ct) {
			int a = 0;
			try {
				String sql = "insert into customer(Name,Password,Email_Id,Contact_No) values(?,?,?,?)";
				try (PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
					ps.setString(1, ct.getName());
					ps.setString(2, ct.getPassword());
					ps.setString(3, ct.getEmail_Id());
					ps.setString(4, ct.getContact_No());
					
					a = ps.executeUpdate();
					
					if(a > 0) {
						try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
							if (generatedKeys.next()) {
								ct.setCustomer_id(generatedKeys.getInt(1));
							}
						}
						a = 1;
					}
				}
			} catch (Exception e) {
				System.out.println(e);
			}
			return a;
		}
		
//===================================================================================================================
		//view selected item
		
		// viewproduct
		
		public List<viewlist> getSelecteditem(String st){
			List<viewlist> listv = new ArrayList<viewlist>();
			viewlist v = null;
			long startTime = 0;
			long endTime = 0;

			try {
				String sql = "select * from viewlist where pname = ?";
				
				startTime = System.currentTimeMillis(); // CAPTURE START TIME
				
				PreparedStatement ps = conn.prepareStatement(sql);
				ps.setString(1, st);
				ResultSet rs = ps.executeQuery();

				while(rs.next()) {
					v = new viewlist();
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
			} finally {
				endTime = System.currentTimeMillis(); // CAPTURE END TIME
				long duration = endTime - startTime;
				System.out.println("getSelecteditem query (pname: " + st + ") took: " + duration + " ms. Start: " + startTime + ", End: " + endTime); // LOG DURATION
			}
			return listv;
		}
			
		
		
// addtocartnull
		
		public boolean checkaddtocartnull(cart c)
		{
			boolean f = false;
		
		
			try{
				String sql = "select * from cart  where Name is NULL and bname=? and cname =? and pname = ? and pprice = ? and pimage = ?";
				PreparedStatement ps = conn.prepareStatement(sql);
			
			
			ps.setString(1, c.getBname());
			ps.setString(2, c.getCname());
			ps.setString(3, c.getPname());
			ps.setInt(4, c.getPprice());
			ps.setString(5, c.getPimage());
			
			ResultSet rs=ps.executeQuery();
			if (rs.next()==true)
				f = true;
			else
				f = false;
			
			}catch(Exception ex){
			   System.out.println(ex.getMessage());
			}
			return f;
				
		}
		
	// update cart	
		public int updateaddtocartnull(cart c) {
			
			int i = 0;
			try{
				String sql = "update cart set pquantity = (pquantity + 1) where Name is NULL and bname = ? and cname = ? and pname = ? and pprice = ? and pimage = ?" ;
				PreparedStatement ps = conn.prepareStatement(sql);
			
			
			ps.setString(1, c.getBname());
			ps.setString(2, c.getCname());
			ps.setString(3, c.getPname());
			ps.setInt(4, c.getPprice());
			ps.setString(5, c.getPimage());
			
			i = ps.executeUpdate();
			if(i > 0)
				i = 1;
			
			
			}catch(Exception ex){
			   System.out.println(ex.getMessage());
			}
			return i;
			
			
			
		}
		
		//
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
	
//===================================================================

// view cart


// 

public List<cart> getSelectedcart(){
	List<cart> listv = new ArrayList<cart>();
	cart c = null;
	try {
		String sql = "select * from cart where Name is NULL OR Name LIKE 'guest-%'";
		PreparedStatement ps = conn.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			c = new cart();
			c.setCart_id(rs.getInt("cart_id"));
			c.setName(rs.getString("Name"));
			c.setBname(rs.getString("bname"));
			c.setCname(rs.getString("cname"));
			c.setPname(rs.getString("pname"));
			c.setPprice(rs.getInt("pprice"));
			c.setPquantity(rs.getInt("pquantity"));
			c.setPimage(rs.getString("pimage"));
			listv.add(c);
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	return listv;
}
	
//
// view cart of specific customer

public List<cart> getcart(String ct){
	List<cart> listv = new ArrayList<cart>();
	cart c = null;
	try {
		String sql = "select * from cart where Name = ?";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, ct);
		ResultSet rs = ps.executeQuery();
		while(rs.next())
		{
			c = new cart();
			c.setCart_id(rs.getInt("cart_id"));
			c.setName(rs.getString("Name"));
			c.setBname(rs.getString("bname"));
			c.setCname(rs.getString("cname"));
			c.setPname(rs.getString("pname"));
			c.setPprice(rs.getInt("pprice"));
			c.setPquantity(rs.getInt("pquantity"));
			c.setPimage(rs.getString("pimage"));
			listv.add(c);
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	return listv;
}

// removecartnull

public int removecartnull(cart c)
{
    int i = 0;
    try {
        String sql = "delete from cart where cart_id = ? and (Name is NULL OR Name LIKE 'guest-%')";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setInt(1, c.getCart_id());
        i = ps.executeUpdate();
        if(i > 0)
            i = 1;
    } catch(Exception ex) {
        System.out.println(ex.getMessage());
    }
    return i;
}


// removecart

	public int removecart(cart c) {
		int j = 0;
		try {
			String sql = "delete from cart where cart_id = ? and Name = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, c.getCart_id());
			ps.setString(2, c.getName());
			j = ps.executeUpdate();
			if(j > 0)
				j = 1;
		} catch(Exception ex) {
			System.out.println(ex.getMessage());
		}
		return j;
	}
	
	
	
	// check existing customer login name for new registration
	
	// check customer login
	
		public boolean checkcust2(customer cus)
		{
			boolean f = false;
		
		
			try{
				String sql = "select * from customer  where Name=? or Email_Id=?";
				PreparedStatement ps = conn.prepareStatement(sql);
			
			
			ps.setString(1, cus.getName());
			ps.setString(2, cus.getEmail_Id());
			
			ResultSet rs=ps.executeQuery();
			if (rs.next()==true)
				f = true;
			else
				f = false;
			
			}catch(Exception ex){
			   System.out.println(ex.getMessage());
			}
			return f;
				
		}
		
		
// remove orders
		
public int removeorders(orders o) {
			
			int j = 0;
			try{
				String sql = "delete from orders where Order_Id= ?";
				PreparedStatement ps = conn.prepareStatement(sql);
			
			ps.setInt(1, o.getOrder_Id());
			

			
			j = ps.executeUpdate();
			if(j > 0)
				j = 1;
			
			
			}catch(Exception ex){
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

	public List<viewlist> searchProducts(String query) {
		List<viewlist> listv = new ArrayList<viewlist>();
		viewlist v = null;
		
		try {
			String sql = "SELECT * FROM viewlist WHERE LOWER(pname) LIKE LOWER(?) OR LOWER(bname) LIKE LOWER(?) OR LOWER(cname) LIKE LOWER(?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			
			String searchPattern = "%" + query + "%";
			ps.setString(1, searchPattern);
			ps.setString(2, searchPattern);
			ps.setString(3, searchPattern);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				v = new viewlist();
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
}