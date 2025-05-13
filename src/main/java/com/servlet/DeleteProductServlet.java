package com.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.conn.DBConnect;
import com.dao.DAO;

@WebServlet("/deleteproduct")
public class DeleteProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public DeleteProductServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int pid = Integer.parseInt(request.getParameter("id"));
			DAO dao = new DAO(DBConnect.getConn());
			boolean f = dao.deleteProduct(pid);
			
			HttpSession session = request.getSession();
			if(f) {
				session.setAttribute("succMsg", "Product deleted successfully");
			} else {
				session.setAttribute("errorMsg", "Something went wrong");
			}
			response.sendRedirect("manageproducts.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
} 