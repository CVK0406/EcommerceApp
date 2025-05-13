package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Cookie;
import com.dao.DAO2;
import com.entity.cart;
import com.conn.DBConnect;

@WebServlet("/removecartnull")
public class removecartnull extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public removecartnull() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cartId = request.getParameter("cartId"); // cart_id
		
		if (cartId == null || cartId.trim().isEmpty()) {
			System.out.println("[DEBUG] Invalid cartId parameter");
			response.sendRedirect("cartnull.jsp?error=invalid_parameters");
			return;
		}
		
		// Get guest ID from cookie
		String guestId = null;
		Cookie[] cookies = request.getCookies();
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("guestId".equals(cookie.getName())) {
					guestId = cookie.getValue();
					break;
				}
			}
		}
		
		if (guestId == null || guestId.isEmpty()) {
			System.out.println("[DEBUG] No guest ID found in cookies");
			response.sendRedirect("cartnull.jsp?error=no_guest_id");
			return;
		}
		
		try {
			cart c = new cart();
			c.setName(guestId);
			c.setCart_id(Integer.parseInt(cartId));
			
			System.out.println("[DEBUG] Attempting to remove cart item - cartId: " + cartId + ", guestId: " + guestId);
			
			DAO2 dao = new DAO2(DBConnect.getConn());
			int i = dao.removecartnull(c);
			
			if(i > 0) {
				System.out.println("[DEBUG] Successfully removed cart item");
				response.sendRedirect("cartnull.jsp?success=item_removed");
			} else {
				System.out.println("[DEBUG] Failed to remove cart item - no rows affected");
				response.sendRedirect("cartnull.jsp?error=removal_failed");
			}
		} catch (NumberFormatException e) {
			System.out.println("[DEBUG] Invalid cart ID format: " + cartId);
			response.sendRedirect("cartnull.jsp?error=invalid_cart_id");
		} catch (Exception e) {
			System.out.println("[DEBUG] System error while removing cart item: " + e.getMessage());
			e.printStackTrace();
			response.sendRedirect("cartnull.jsp?error=system_error");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
