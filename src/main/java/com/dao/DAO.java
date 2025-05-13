package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.entity.category;
import com.entity.customer;
import com.utility.MyUtilities;
import com.entity.brand;
import com.entity.Product;

public class DAO {
	private Connection conn;
	
	public DAO(Connection conn) {
		this.conn = conn;
	}
	
	// list all brand
	public List<brand> getAllbrand(){
		List<brand> listb = new ArrayList<brand>();
		brand b = null;
		String sql = "select * from brand";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				b = new brand();
				b.setBid(rs.getInt(1));
				b.setBname(rs.getString(2));
				listb.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listb;
	}
	
	// list all category
	public List<category> getAllcategory(){
		List<category> listc = new ArrayList<category>();
		category c = null;
		String sql = "select * from category";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				c = new category();
				c.setCid(rs.getInt(1));
				c.setCname(rs.getString(2));
				listc.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listc;
	}
	
	// add product
	public int addproduct(HttpServletRequest request) {
		int a = 0;
		try {
			String pname = "";
			int pprice = 0;
			int pquantity = 0;
			String pimage = "";
			int bid = 0;
			int cid = 0;
			String sql = "insert into product(pname,pprice,pquantity,pimage,bid,cid) values(?,?,?,?,?,?)";
			try (PreparedStatement ps = conn.prepareStatement(sql)) {
				List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
				for (FileItem item1 : multiparts) {
					if (item1.isFormField()) {
						if (item1.getFieldName().equals("pname"))
							pname = item1.getString();
						if (item1.getFieldName().equals("pprice"))
							pprice = Integer.parseInt(item1.getString());
						if (item1.getFieldName().equals("pquantity"))
							pquantity = Integer.parseInt(item1.getString());
						if (item1.getFieldName().equals("bname")) {
							if(item1.getString().equals("samsung")) bid = 1;
							if(item1.getString().equals("sony")) bid = 2;
							if(item1.getString().equals("lenovo")) bid = 3;
							if(item1.getString().equals("acer")) bid = 4;
							if(item1.getString().equals("onida")) bid = 5;
						}
						if (item1.getFieldName().equals("cname")) {
							if(item1.getString().equals("laptop")) cid = 1;
							if(item1.getString().equals("tv")) cid = 2;
							if(item1.getString().equals("mobile")) cid = 3;
							if(item1.getString().equals("watch")) cid = 4;
						}
					} else {
						com.utility.MyUtilities m1=new MyUtilities();
						String destinationpath = request.getSession().getServletContext().getRealPath("/images/");
						java.io.File dir = new java.io.File(destinationpath);
						if (!dir.exists()) {
							dir.mkdirs();
						}
						ArrayList<String> ext = new ArrayList<String>();
						ext.add(".jpg");ext.add(".bmp");ext.add(".jpeg");ext.add(".png");ext.add(".webp");
						pimage = m1.UploadFile(item1, destinationpath, ext);
					}
				}
				if(!pimage.equals("Problem with upload")) {
					ps.setString(1, pname);
					ps.setInt(2,pprice);
					ps.setInt(3,pquantity);
					ps.setString(4,pimage);
					ps.setInt(5,bid);
					ps.setInt(6,cid);
					ps.executeUpdate();
					a = 1;
				}
				System.out.println("pname: " + pname);
				System.out.println("pprice: " + pprice);
				System.out.println("pquantity: " + pquantity);
				System.out.println("pimage: " + pimage);
				System.out.println("bid: " + bid);
				System.out.println("cid: " + cid);
			}
		} catch (Exception e) {
			System.out.println(e);
		}
		return a;
	}

	// display all customers
	public List<customer> getAllCustomer() {
		List<customer> list = new ArrayList<customer>();
		customer c = null;
		String sql = "select * from customer";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				c = new customer();
				c.setCustomer_id(rs.getInt("customer_id"));
				c.setName(rs.getString("Name"));
				c.setPassword(rs.getString("Password"));
				c.setEmail_Id(rs.getString("Email_Id"));
				c.setContact_No(rs.getString("Contact_No"));
				list.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Delete Customer
	public boolean deleteCustomer(customer c) {
		boolean f = false;
		String sql = "delete from customer where customer_id = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, c.getCustomer_id());
			int i = ps.executeUpdate();
			if(i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}

	// display selected customer
	public List<customer> getCustomer(String eid) {
		List<customer> list = new ArrayList<customer>();
		customer c = null;
		String sql = "select * from customer where Email_Id=?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, eid);
			try (ResultSet rs = ps.executeQuery()) {
				while(rs.next()) {
					c = new customer();
					c.setCustomer_id(rs.getInt("customer_id"));
					c.setName(rs.getString("Name"));
					c.setPassword(rs.getString("Password"));
					c.setEmail_Id(rs.getString("Email_Id"));
					c.setContact_No(rs.getString("Contact_No"));
					list.add(c);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
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

	// Update a product
	public boolean updateProduct(com.entity.Product p) {
		String sql = "UPDATE product SET pname=?, pprice=?, pquantity=?, pimage=?, bid=?, cid=? WHERE pid=?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setString(1, p.getPname());
			ps.setDouble(2, p.getPprice());
			ps.setInt(3, p.getPquantity());
			ps.setString(4, p.getPimage());
			ps.setInt(5, p.getBid());
			ps.setInt(6, p.getCid());
			ps.setInt(7, p.getPid());
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Delete a product
	public boolean deleteProduct(int pid) {
		String sql = "DELETE FROM product WHERE pid=?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, pid);
			return ps.executeUpdate() > 0;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	// Get all products
	public List<Product> getAllProducts() {
		List<Product> list = new ArrayList<Product>();
		String sql = "SELECT * FROM product ORDER BY pid DESC";
		try (PreparedStatement ps = conn.prepareStatement(sql);
			 ResultSet rs = ps.executeQuery()) {
			while(rs.next()) {
				Product p = new Product();
				p.setPid(rs.getInt("pid"));
				p.setPname(rs.getString("pname"));
				p.setPprice(rs.getDouble("pprice"));
				p.setPquantity(rs.getInt("pquantity"));
				p.setPimage(rs.getString("pimage"));
				p.setBid(rs.getInt("bid"));
				p.setCid(rs.getInt("cid"));
				list.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	// Get brand name by ID
	public String getBrandName(int bid) {
		String sql = "SELECT bname FROM brand WHERE bid = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, bid);
			try (ResultSet rs = ps.executeQuery()) {
				if(rs.next()) {
					return rs.getString("bname");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	// Get category name by ID
	public String getCategoryName(int cid) {
		String sql = "SELECT cname FROM category WHERE cid = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, cid);
			try (ResultSet rs = ps.executeQuery()) {
				if(rs.next()) {
					return rs.getString("cname");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}

	// Get single product by ID
	public Product getProductById(int pid) {
		Product p = null;
		String sql = "SELECT p.*, b.bname, c.cname FROM product p " +
					"JOIN brand b ON p.bid = b.bid " +
					"JOIN category c ON p.cid = c.cid " +
					"WHERE p.pid = ?";
		try (PreparedStatement ps = conn.prepareStatement(sql)) {
			ps.setInt(1, pid);
			try (ResultSet rs = ps.executeQuery()) {
				if(rs.next()) {
					p = new Product();
					p.setPid(rs.getInt("pid"));
					p.setPname(rs.getString("pname"));
					p.setPprice(rs.getDouble("pprice"));
					p.setPquantity(rs.getInt("pquantity"));
					p.setPimage(rs.getString("pimage"));
					p.setBid(rs.getInt("bid"));
					p.setCid(rs.getInt("cid"));
					// Additional fields for the edit form
					p.setBname(rs.getString("bname"));
					p.setCname(rs.getString("cname"));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return p;
	}
}