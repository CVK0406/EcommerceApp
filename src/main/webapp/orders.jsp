<%@page import="com.conn.DBConnect"%>
<%@page import="com.entity.orders"%>
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
	<%@ include file = "customer_navbar.jsp" %>



<center>
<div class="container py-4">
  <div class="card shadow border-0">
    <div class="card-header bg-primary text-white text-center" style="border-radius: 0.5rem 0.5rem 0 0;">
      <h2 class="mb-0" style="letter-spacing: 1px;">All Orders</h2>
    </div>
    <div class="table-responsive">
      <table class="table table-striped table-hover mb-0" style="background: #fff;">
        <thead class="thead-light">
          <tr>
            <th class="text-center">Order Id</th>
            <th class="text-center">Customer Name</th>
            <th class="text-center">Customer City</th>
            <th class="text-center">Date</th>
            <th class="text-center">Total Price</th>
            <th class="text-center">Status</th>
            <th class="text-center" colspan="2">Actions</th>
          </tr>
        </thead>
        <tbody>
        <% String o = N;
           DAO3 dao = new DAO3(DBConnect.getConn());
           List<orders> listv = dao.getOrders(o);
           for(orders v : listv) { %>
          <tr>
            <td class="text-center align-middle"><%=v.getOrder_Id() %></td>
            <td class="text-center align-middle"><%=v.getCustomer_Name() %></td>
            <td class="text-center align-middle"><%=v.getCustomer_City() %></td>
            <td class="text-center align-middle"><%=v.getDate() %></td>
            <td class="text-center align-middle">$ <%=v.getTotal_Price()%></td>
            <td class="text-center align-middle"><%=v.getStatus() %></td>
            <td class="text-center align-middle">
              <a href='orderdetails.jsp?id=<%=v.getDate()%>' class="btn btn-outline-info btn-sm">Order Details</a>
            </td>
            <td class="text-center align-middle">
              <a href='removeorders?id=<%=v.getOrder_Id()%>' class="btn btn-outline-danger btn-sm" title="Remove Order">
                <img src="images/delete.jpg" alt="Remove" height="22" style="vertical-align: middle;">
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
</center>
 <br>
</form>

</body>
</html>