package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.DAO2;
import com.entity.cart;
import com.conn.DBConnect;

@WebServlet("/removecart")
public class removecart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public removecart() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");    // customer name
		String cartId = request.getParameter("cartId"); // cart_id
		
		if (id == null || id.trim().isEmpty() || cartId == null || cartId.trim().isEmpty()) {
			System.out.println("[DEBUG] Invalid parameters - id: " + id + ", cartId: " + cartId);
			response.sendRedirect("cart.jsp?error=invalid_parameters");
			return;
		}
		
		try {
			cart c = new cart();
			c.setName(id);
			c.setCart_id(Integer.parseInt(cartId));
			
			System.out.println("[DEBUG] Attempting to remove cart item - cartId: " + cartId + ", customer: " + id);
			
			DAO2 dao = new DAO2(DBConnect.getConn());
			int i = dao.removecart(c);
			
			if(i > 0) {
				System.out.println("[DEBUG] Successfully removed cart item");
				response.sendRedirect("cart.jsp?success=item_removed");
			} else {
				System.out.println("[DEBUG] Failed to remove cart item - no rows affected");
				response.sendRedirect("cart.jsp?error=removal_failed");
			}
		} catch (NumberFormatException e) {
			System.out.println("[DEBUG] Invalid cart ID format: " + cartId);
			response.sendRedirect("cart.jsp?error=invalid_cart_id");
		} catch (Exception e) {
			System.out.println("[DEBUG] System error while removing cart item: " + e.getMessage());
			e.printStackTrace();
			response.sendRedirect("cart.jsp?error=system_error");
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
