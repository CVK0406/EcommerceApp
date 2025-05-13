package com.servlet;

import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.conn.DBConnect;
import com.dao.DAO;
import com.entity.Product;
import com.utility.MyUtilities;

@WebServlet("/updateproduct")
public class UpdateProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public UpdateProductServlet() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Product p = new Product();
			String pimage = null;
			boolean hasNewImage = false;
			
			// Parse multipart form data
			List<FileItem> multiparts = new ServletFileUpload(new DiskFileItemFactory()).parseRequest(request);
			
			for (FileItem item : multiparts) {
				if (item.isFormField()) {
					// Handle regular form fields
					String fieldName = item.getFieldName();
					String fieldValue = item.getString();
					
					switch (fieldName) {
						case "pid":
							p.setPid(Integer.parseInt(fieldValue));
							break;
						case "pname":
							p.setPname(fieldValue);
							break;
						case "pprice":
							p.setPprice(Double.parseDouble(fieldValue));
							break;
						case "pquantity":
							p.setPquantity(Integer.parseInt(fieldValue));
							break;
						case "bname":
							// Convert brand name to ID
							if(fieldValue.equals("samsung")) p.setBid(1);
							else if(fieldValue.equals("sony")) p.setBid(2);
							else if(fieldValue.equals("lenovo")) p.setBid(3);
							else if(fieldValue.equals("acer")) p.setBid(4);
							else if(fieldValue.equals("onida")) p.setBid(5);
							break;
						case "cname":
							// Convert category name to ID
							if(fieldValue.equals("laptop")) p.setCid(1);
							else if(fieldValue.equals("tv")) p.setCid(2);
							else if(fieldValue.equals("mobile")) p.setCid(3);
							else if(fieldValue.equals("watch")) p.setCid(4);
							break;
					}
				} else {
					// Handle file upload
					if (item.getSize() > 0) { // Only process if a file was actually uploaded
						hasNewImage = true;
						String destinationPath = request.getSession().getServletContext().getRealPath("/images/");
						java.io.File dir = new java.io.File(destinationPath);
						if (!dir.exists()) {
							dir.mkdirs();
						}
						
						ArrayList<String> allowedExtensions = new ArrayList<String>();
						allowedExtensions.add(".jpg");
						allowedExtensions.add(".jpeg");
						allowedExtensions.add(".png");
						allowedExtensions.add(".bmp");
						allowedExtensions.add(".webp");
						
						MyUtilities util = new MyUtilities();
						pimage = util.UploadFile(item, destinationPath, allowedExtensions);
						
						if (pimage.equals("Problem with upload")) {
							throw new ServletException("Failed to upload image");
						}
					}
				}
			}
			
			// If no new image was uploaded, get the existing image from the database
			if (!hasNewImage) {
				DAO dao = new DAO(DBConnect.getConn());
				Product existingProduct = dao.getProductById(p.getPid());
				if (existingProduct != null) {
					pimage = existingProduct.getPimage();
				}
			}
			
			p.setPimage(pimage);
			
			// Update the product
			DAO dao = new DAO(DBConnect.getConn());
			boolean success = dao.updateProduct(p);
			
			HttpSession session = request.getSession();
			if (success) {
				session.setAttribute("succMsg", "Product updated successfully");
			} else {
				session.setAttribute("errorMsg", "Something went wrong while updating the product");
			}
			
			response.sendRedirect("manageproducts.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			HttpSession session = request.getSession();
			session.setAttribute("errorMsg", "Error: " + e.getMessage());
			response.sendRedirect("manageproducts.jsp");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
} 