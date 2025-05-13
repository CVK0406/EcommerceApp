<%@page import="java.util.Date"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shipping Address</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/abc.css">
<link rel="stylesheet" href="Css/font.css">
<link rel="stylesheet" href="Css/whitespace.css">
<style>
body, h1, h2, h3, h4, h5, h6, .w3-wide { font-family: "Montserrat", sans-serif; }
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
.shipping-card {
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 2px 16px rgba(0,0,0,0.10);
  padding: 32px 28px 28px 28px;
  margin: 0 auto 32px auto;
  max-width: 700px;
  display: flex;
  flex-wrap: wrap;
  gap: 32px;
  align-items: center;
}
.shipping-image {
  flex: 1 1 220px;
  display: flex;
  align-items: center;
  justify-content: center;
}
.shipping-image img {
  width: 180px;
  height: 180px;
  object-fit: contain;
  border-radius: 14px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.10);
  background: #f8fafc;
}
.shipping-form {
  flex: 2 1 320px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  gap: 12px;
}
.shipping-form label {
  font-weight: 500;
  color: #555;
  margin-bottom: 2px;
}
.shipping-form input[type="text"],
.shipping-form input[type="number"] {
  width: 100%;
  padding: 10px 12px;
  border-radius: 6px;
  border: 1px solid #ddd;
  font-size: 1.08rem;
  background: #f8fafc;
  margin-bottom: 8px;
}
.shipping-form input[disabled] {
  background: #f3f3f3;
  color: #888;
}
.shipping-form .btn-group {
  display: flex;
  gap: 16px;
  margin-top: 10px;
}
.shipping-form input[type="submit"] {
  background: #e67e22;
  color: #fff;
  font-weight: 600;
  border: none;
  border-radius: 6px;
  padding: 10px 32px;
  font-size: 1.08rem;
  transition: background 0.2s;
}
.shipping-form input[type="submit"]:hover {
  background: #cf711f;
  color: #fff;
}
</style>
</head>
<body>
<form method="post" action="ShippingAddress2">
<%@ include file = "customer_navbar.jsp"%>
<div class="hero-section">
  <h1>Shipping Address</h1>
</div>
<% String Total = request.getParameter("Total"); %>
<input type="hidden" name="Total" value="<%=Total %>">
<% String CusName = request.getParameter("CusName"); %>
<input type="hidden" name="CusName" value="<%=CusName %>">
<div class="shipping-card">
  <div class="shipping-image">
    <img src="images/shipimg.png" alt="Shipping">
  </div>
  <div class="shipping-form">
    <label for="customerName">Customer Name:</label>
    <input type="text" id="customerName" value="<%= N%>" disabled required>
    <input type="hidden" name="CName" value="<%= N%>">
    <label for="address">Address:</label>
    <input type="text" id="address" name="Address" required>
    <label for="city">City:</label>
    <input type="text" id="city" name="City" required>
    <label for="state">State:</label>
    <input type="text" id="state" name="State" required>
    <label for="country">Country:</label>
    <input type="text" id="country" name="Country" required>
    <label for="pincode">Pincode:</label>
    <input type="number" id="pincode" name="Pincode" required>
    <div class="btn-group">
      <input type="submit" value="Cash on Delivery" name="cash">
      <input type="submit" value="Online Payment" name="online">
    </div>
  </div>
</div>
<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</form>
</body>
</html>