package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.conn.DBConnect;
import com.dao.DAO;
import com.entity.Product;
import com.google.gson.Gson;

@WebServlet("/getproduct")
public class GetProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public GetProductServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		try {
			int pid = Integer.parseInt(request.getParameter("id"));
			DAO dao = new DAO(DBConnect.getConn());
			Product product = dao.getProductById(pid);
			
			if (product != null) {
				Gson gson = new Gson();
				String jsonResponse = gson.toJson(product);
				
				PrintWriter out = response.getWriter();
				out.print(jsonResponse);
				out.flush();
			} else {
				response.setStatus(HttpServletResponse.SC_NOT_FOUND);
				PrintWriter out = response.getWriter();
				out.print("{\"error\": \"Product not found\"}");
				out.flush();
			}
		} catch (Exception e) {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			PrintWriter out = response.getWriter();
			out.print("{\"error\": \"" + e.getMessage() + "\"}");
			out.flush();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
} 