<%@page import="com.conn.DBConnect"%>
<%@page import="com.entity.viewlist"%>
<%@page import="com.dao.DAO2"%>
<%@page import="java.util.Base64.Decoder"%>
<%@page import="java.sql.*,java.io.*,java.text.*,java.util.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Details</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">
<style>
body {
  background: linear-gradient(90deg, #f8fafc 60%, #ffe5d9 100%);
  font-family: 'Montserrat', sans-serif;
  min-height: 100vh;
}
.hero-section {
  background: #fff;
  border-radius: 0 0 16px 16px;
  padding: 32px 0 18px 0;
  text-align: center;
  margin-bottom: 24px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
}
.hero-section h1 {
  font-size: 2.3rem;
  font-weight: bold;
  color: #e67e22;
  margin-bottom: 0;
}
.product-card {
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 2px 16px rgba(0,0,0,0.10);
  padding: 32px 28px 28px 28px;
  margin: 0 auto 32px auto;
  max-width: 900px;
  display: flex;
  flex-wrap: wrap;
  gap: 32px;
}
.product-image {
  flex: 1 1 320px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.product-image img {
  width: 260px;
  height: 260px;
  object-fit: contain;
  border-radius: 14px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.10);
  background: #f8fafc;
}
.product-info {
  flex: 2 1 400px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
.product-info h2 {
  font-size: 2rem;
  color: #333;
  margin-bottom: 8px;
}
.product-info h3 {
  color: #e67e22;
  font-size: 1.5rem;
  margin-bottom: 18px;
}
.product-info table {
  width: 100%;
  margin-bottom: 18px;
  font-size: 1.08rem;
}
.product-info th, .product-info td {
  padding: 7px 10px;
  text-align: left;
}
.product-info th {
  color: #888;
  width: 120px;
  font-weight: 500;
}
.product-info td {
  color: #222;
}
.add-to-cart-btn {
  display: inline-block;
  background: #e67e22;
  color: #fff;
  font-weight: 600;
  border: none;
  border-radius: 6px;
  padding: 10px 32px;
  font-size: 1.15rem;
  margin-top: 10px;
  transition: background 0.2s;
  text-decoration: none;
}
.add-to-cart-btn:hover {
  background: #cf711f;
  color: #fff;
  text-decoration: none;
}
.product-description {
  background: #f8fafc;
  border-radius: 10px;
  padding: 18px 20px;
  margin-top: 18px;
  font-size: 1.08rem;
  color: #444;
}
</style>
</head>
<body>
<%@ include file = "admin_navbar.jsp" %>
<div class="hero-section">
  <h1>Product Details</h1>
</div>
<%
String st = request.getParameter("Pn");
DAO2 dao = new DAO2(DBConnect.getConn());
List<viewlist> list = dao.getSelecteditem(st);
for(viewlist l : list) {
%>
<div class="product-card">
  <div class="product-image">
    <img src='images/<%=l.getPimage() %>' alt="<%=l.getPname()%>">
  </div>
  <div class="product-info">
    <h2><%=l.getPname()%></h2>
    <h3>$ <%=l.getPprice() %></h3>
    <table>
      <tr><th>Brand:</th><td><%=l.getBname() %></td></tr>
      <tr><th>Category:</th><td><%=l.getCname() %></td></tr>
      <tr><th>Quantity:</th><td><%=l.getPquantity() %></td></tr>
    </table>
  </div>
</div>
<% } %>
<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</body>
</html>