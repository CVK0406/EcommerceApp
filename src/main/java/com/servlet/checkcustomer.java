package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.conn.DBConnect;

import com.dao.DAO2;

import com.entity.customer;

@MultipartConfig
@WebServlet("/checkcustomer")
public class checkcustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public checkcustomer() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String Email_IdD = new String(request.getParameter("Email_Id"));
		String Email_Id = Email_IdD.trim();

		String PasswordD = new String(request.getParameter("Password"));
		String Password = PasswordD.trim();

		String Total = request.getParameter("Total");
		String CusName = request.getParameter("CusName");

		System.out.println(CusName);

		customer c = new customer();
		c.setEmail_Id(Email_Id);
		c.setPassword(Password);

		try {
			DAO2 dao = new DAO2(DBConnect.getConn());

			if (dao.checkcust(c) == true) {
				Cookie cus = new Cookie("cname", Email_Id);
				cus.setMaxAge(9999);
				response.addCookie(cus);

				// Get user's name from database
				String userName = null;
				try {
					java.sql.Connection conn = com.conn.DBConnect.getConn();
					java.sql.PreparedStatement psName = conn.prepareStatement(
						"SELECT Name FROM customer WHERE Email_Id = ?");
					psName.setString(1, Email_Id);
					java.sql.ResultSet rsName = psName.executeQuery();
					if (rsName.next()) {
						userName = rsName.getString(1);
					}
					rsName.close();
					psName.close();

					if (userName != null) {
						// First merge NULL cart items to user's cart
						java.sql.PreparedStatement psNull = conn.prepareStatement(
							"UPDATE cart SET Name = ? WHERE Name IS NULL");
						psNull.setString(1, userName);
						int updatedNull = psNull.executeUpdate();
						System.out.println("[DEBUG] NULL cart items merged: " + updatedNull);
						psNull.close();

						// Then merge any guest ID cart items
						Cookie[] cookies = request.getCookies();
						String guestId = null;
						if (cookies != null) {
							for (Cookie cookie : cookies) {
								if ("guestId".equals(cookie.getName())) {
									guestId = cookie.getValue();
									// Remove guestId cookie
									cookie.setMaxAge(0);
									response.addCookie(cookie);
									break;
								}
							}
						}
						if (guestId != null && !guestId.isEmpty()) {
							// Count guest cart items before update
							java.sql.PreparedStatement psCountGuest = conn.prepareStatement(
								"SELECT COUNT(*) FROM cart WHERE Name = ?");
							psCountGuest.setString(1, guestId);
							java.sql.ResultSet rsGuest = psCountGuest.executeQuery();
							if (rsGuest.next()) {
								System.out.println("[DEBUG] Guest cart items before merge: " + rsGuest.getInt(1));
							}
							rsGuest.close();
							psCountGuest.close();

							// Update all cart items from guestId to userName
							java.sql.PreparedStatement ps = conn.prepareStatement(
								"UPDATE cart SET Name = ? WHERE Name = ?");
							ps.setString(1, userName);
							ps.setString(2, guestId);
							int updated = ps.executeUpdate();
							System.out.println("[DEBUG] Guest ID cart items merged: " + updated);
							ps.close();
						}

						// Count user cart items after all merges
						java.sql.PreparedStatement psCountUser = conn.prepareStatement(
							"SELECT COUNT(*) FROM cart WHERE Name = ?");
						psCountUser.setString(1, userName);
						java.sql.ResultSet rsUser = psCountUser.executeQuery();
						if (rsUser.next()) {
							System.out.println("[DEBUG] User cart items after merge: " + rsUser.getInt(1));
						}
						rsUser.close();
						psCountUser.close();
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
				// --- End merge logic ---

				if (CusName.equals("empty"))
					response.sendRedirect("ShippingAddress.jsp?Total=" + Total + " &CusName= " + CusName + "");
				else
					response.sendRedirect("customerhome.jsp");
			} else {

				Cookie up = new Cookie("un", "up");
				up.setMaxAge(10);
				response.addCookie(up);
				response.sendRedirect("customerlogin.jsp?Total=" + Total + " &CusName= " + CusName + "");
			}

		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}

	}

}