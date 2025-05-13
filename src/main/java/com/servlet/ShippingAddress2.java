package com.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
@WebServlet("/ShippingAddress2")
public class ShippingAddress2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
    public ShippingAddress2() {
        super();
     
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		
		

		String CName = request.getParameter("CName");
		String City = request.getParameter("City");
		String Total = request.getParameter("Total"); 
		String CusName = request.getParameter("CusName");


		 if(request.getParameter("cash") != null)
		 {
			 response.sendRedirect("confirmpayment.jsp?CName= "+CName+" &City="+City+" &Total="+Total+" &CusName="+CusName+"");
			// response.sendRedirect("orders.jsp?Name= "+Name+" &City="+City+" &Total="+Total+"");
		 }
		 
		 if(request.getParameter("online") != null)
		 {
			 response.sendRedirect("confirmonline.jsp?CName= "+CName+" &City="+City+" &Total="+Total+" &CusName="+CusName+"");
			// response.sendRedirect("orders.jsp?CName= "+CName+"  &City="+City+" &Total="+Total+"");
		 }
		 
		 
		 
		 
		 
			
		
		
	}

}
