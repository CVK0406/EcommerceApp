<%@page import="com.entity.order_details"%>
<%@page import="com.entity.orders"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO3"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Details</title>

<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">

<style>
    body, h1, h2, h3, h4, h5, h6, .w3-wide {
        font-family: "Montserrat", sans-serif;
    }

    .order-container {
        background-color: #f8f9fa;
        padding: 30px;
        border-radius: 10px;
        margin-top: 30px;
    }

    .order-table th, .order-table td {
        text-align: center;
        vertical-align: middle;
        border: 1px solid #dee2e6;
    }

    .order-table th {
        background-color: #ebe9eb;
    }

    .summary-table {
        width: 50%;
        margin: 20px auto;
        background-color: #ffffff;
        border-radius: 10px;
        padding: 20px;
        border: 1px solid #ccc;
    }

    .summary-table th {
        text-align: left;
        padding-right: 10px;
    }
</style>
</head>
<body>

<%@ include file="customer_navbar.jsp" %>

<div class="container order-container">
    <h1 class="text-center mb-4">Order Details</h1>

    <%
        String d = request.getParameter("id");
        DAO3 dao = new DAO3(DBConnect.getConn());
        List<orders> listv = dao.getOrdersbydate(d);
        for (orders v : listv) {
    %>

    <table class="summary-table">
        <tr><th>Customer Name:</th><td><%= v.getCustomer_Name() %></td></tr>
        <tr><th>City:</th><td><%= v.getCustomer_City() %></td></tr>
        <tr><th>Date:</th><td><%= v.getDate() %></td></tr>
        <tr><th>Total Price:</th><td>$ <%= v.getTotal_Price() %></td></tr>
        <tr><th>Status:</th><td><%= v.getStatus() %></td></tr>
    </table>
    <% } %>

    <div class="table-responsive">
        <table class="table order-table mt-4">
            <thead>
                <tr>
                    <th>Date</th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>Category</th>
                    <th>Product Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Product Image</th>
                </tr>
            </thead>
            <tbody>
            <%
                int Total = 0;
                List<order_details> listd = dao.getOrderdetails(d);
                for (order_details v : listd) {
            %>
                <tr>
                    <td><%= v.getDate() %></td>
                    <td><%= v.getName() %></td>
                    <td><%= v.getBname() %></td>
                    <td><%= v.getCname() %></td>
                    <td><%= v.getPname() %></td>
                    <td>$ <%= v.getPprice() %></td>
                    <td><%= v.getPquantity() %></td>
                    <td><img src="images/<%= v.getPimage() %>" height="100px" width="100px"></td>
                </tr>
            <%
                Total += v.getPprice() * v.getPquantity();
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="text-end mt-3">
        <h5><strong>Total Price:</strong> <span style="color: firebrick;">$ <%= Total %></span></h5>
    </div>
</div>

<footer class="footer">
    <%@ include file="footer.jsp" %>
</footer>

</body>
</html>
