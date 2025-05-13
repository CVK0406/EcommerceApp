<%@page import="java.util.List"%>
<%@page import="com.dao.DAO5"%>
<%@page import="com.entity.order_details"%>
<%@page import="com.entity.orders"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO3"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href = "images/bootstrap.css">

<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">

<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
</style>
</head>
<body>

<form method = "post" action = "payprocess.jsp">
	<%@ include file = "admin_navbar.jsp" %>



<center>
<div class="container py-4">
  <div class="card shadow border-0">
    <div class="card-header bg-primary text-white text-center" style="border-radius: 0.5rem 0.5rem 0 0;">
      <h2 class="mb-0" style="letter-spacing: 1px;">Orders Details</h2>
    </div>
    <div class="table-responsive">
      <table class="table table-striped table-hover mb-0" style="background: #fff;">
        <thead class="thead-light">
          <tr>
            <th class="text-center">Date</th>
            <th class="text-center">Name</th>
            <th class="text-center">Brand</th>
            <th class="text-center">Category</th>
            <th class="text-center">Product Name</th>
            <th class="text-center">Price</th>
            <th class="text-center">Quantity</th>
            <th class="text-center">Product Image</th>
            <th class="text-center" colspan="2">Actions</th>
          </tr>
        </thead>
        <tbody>
        <% DAO5 dao = new DAO5(DBConnect.getConn());
           List<order_details> listv = dao.getAllorder_details();
           for(order_details v : listv) { %>
          <tr>
            <td class="text-center align-middle"><%=v.getDate() %></td>
            <td class="text-center align-middle"><%=v.getName() %></td>
            <td class="text-center align-middle"><%=v.getBname() %></td>
            <td class="text-center align-middle"><%=v.getCname() %></td>
            <td class="text-center align-middle"><%=v.getPname() %></td>
            <td class="text-center align-middle">$ <%=v.getPprice() %></td>
            <td class="text-center align-middle"><%=v.getPquantity() %></td>
            <td class="text-center align-middle"><img src='images/<%=v.getPimage()%>' height=100 width=100 style="object-fit:cover; border-radius:8px;"></td>
            <td class="text-center align-middle">
              <a href='removetable_order_details?id=<%=v.getDate()%>&ie=<%=v.getPimage()%>' class="btn btn-outline-danger btn-sm" title="Remove Order Detail">
                <img src = "images/delete.jpg" alt="Remove" height=22 style="vertical-align: middle;">
              </a>
            </td>
          </tr>
        <% } %>
        </tbody>
      </table>
    </div>
  </div>
</div>

<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</form>

</body>
</html>