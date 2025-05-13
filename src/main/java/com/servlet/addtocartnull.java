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
import com.entity.cart;

@MultipartConfig
@WebServlet("/addtocartnull")
public class addtocartnull extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public addtocartnull() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// out.println(N);
		String id=request.getParameter("id");
		String ie=request.getParameter("ie");
		String ig=request.getParameter("ig");
		String ihstr=request.getParameter("ih");
		int ih = Integer.parseInt(ihstr);
		String iistr =request.getParameter("ii");
		int ii = Integer.parseInt(iistr);
		String ij=request.getParameter("ij");
		// Remove 'images/' prefix if it exists
		if (ij != null && ij.startsWith("images/")) {
			ij = ij.substring(7);
		}
		// Ensure image path is not null
		if (ij == null || ij.trim().isEmpty()) {
			ij = "no-image.png";
		}

		// Get or create guestId cookie
		Cookie[] cookies = request.getCookies();
		String guestId = null;
		if (cookies != null) {
			for (Cookie cookie : cookies) {
				if ("guestId".equals(cookie.getName())) {
					guestId = cookie.getValue();
					break;
				}
			}
		}
		if (guestId == null || guestId.isEmpty()) {
			guestId = "guest-" + java.util.UUID.randomUUID().toString();
			Cookie guestCookie = new Cookie("guestId", guestId);
			guestCookie.setMaxAge(60*60*24*30); // 30 days
			response.addCookie(guestCookie);
		}
		
		cart c = new cart();
		c.setName(guestId);
		c.setBname(id);
		c.setCname(ie);
		c.setPname(ig);
		c.setPprice(ih);
		c.setPimage(ij);
		c.setPquantity(ii);
		
		
		
		
		try{
			DAO2 dao = new DAO2(DBConnect.getConn());
			
			
			if (dao.checkaddtocartnull(c) ==true)
			{
				if(dao.updateaddtocartnull(c) > 0)
				{	
					Cookie cart = new Cookie("cart","cartt");
					cart.setMaxAge(10);
					response.addCookie(cart);
					response.sendRedirect("cartnull.jsp");
				}	
				else
					response.sendRedirect("selecteditem.jsp");
			}
			else
			{
				if(dao.addtocartnull(c)>0)
				{
					Cookie cart = new Cookie("cart","cartt");
					cart.setMaxAge(10);
					response.addCookie(cart);
					response.sendRedirect("cartnull.jsp");
				}
				else
					response.sendRedirect("selecteditem.jsp");
			}
			
			}catch(Exception ex){
			   System.out.println(ex.getMessage());
			}
			
	
				
			
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		
			
		
		
	}

}