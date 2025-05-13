<%@page import="com.conn.DBConnect" %>
<%@page import="com.dao.DAO2" %>
<%@page import="com.entity.cart" %>
<%@page import="java.sql.*,java.io.*,java.text.*,java.util.*" %>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Cart</title>
  <link rel="stylesheet" href="images/bootstrap.css">
  <link rel="stylesheet" href="Css/w3.css">
  <link rel="stylesheet" href="Css/font.css">
  <link rel="stylesheet" href="Css/cart.css">
  <link rel="stylesheet" href="Css/whitespace.css">
  <script>
    function show() {
      alert("Add something to the cart first.");
    }
  </script>
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
      box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
    }

    .hero-section h1 {
      font-size: 2.3rem;
      font-weight: bold;
      color: #e67e22;
      margin-bottom: 0;
    }

    .cart-table {
      background: #fff;
      border-radius: 16px;
      box-shadow: 0 2px 16px rgba(0, 0, 0, 0.10);
      padding: 32px;
      margin: 0 auto 32px auto;
      max-width: 900px;
    }

    .cart-item-row {
      display: flex;
      align-items: center;
      border-bottom: 1px solid #eee;
      padding: 18px 0;
    }

    .cart-item-row:last-child {
      border-bottom: none;
    }

    .cart-item-img {
      width: 90px;
      height: 90px;
      border-radius: 10px;
      background: #f8fafc;
      box-shadow: 0 2px 8px rgba(0, 0, 0, 0.07);
      margin-right: 24px;
      position: relative;
      overflow: hidden;
    }

    .cart-item-img img {
      width: 100%;
      height: 100%;
      object-fit: contain;
    }

    .cart-item-info {
      flex: 2;
      color: #333;
      font-size: 1.08rem;
    }

    .cart-item-qty,
    .cart-item-price {
      flex: 1;
      text-align: center;
      font-size: 1.08rem;
    }

    .cart-item-remove {
      flex: 0.5;
      text-align: center;
    }

    .cart-item-remove img {
      cursor: pointer;
      transition: filter 0.2s;
    }

    .cart-item-remove img:hover {
      filter: brightness(0.7);
    }

    .cart-total {
      text-align: right;
      font-size: 1.25rem;
      color: #e67e22;
      font-weight: bold;
      margin-top: 18px;
    }

    .proceed-btn {
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

    .proceed-btn:hover {
      background: #cf711f;
      color: #fff;
      text-decoration: none;
    }

    .empty-cart {
      text-align: center;
      margin-top: 48px;
    }

    .empty-cart img {
      height: 180px;
      margin-bottom: 18px;
    }

    .empty-cart h2 {
      color: firebrick;
      font-size: 2rem;
    }
  </style>
</head>

<body>

  <%@ include file="navbar.jsp" %>

    <div class="hero-section">
      <h1>Cart</h1>
    </div>

    <% String CusName="empty" ; String msgg=null; Cookie[] cartPageCookies=request.getCookies(); if
      (cartPageCookies !=null) { for (Cookie cookie : cartPageCookies) { if ("cart".equals(cookie.getName()))
      { cookie.setMaxAge(0); response.addCookie(cookie); msgg="Product added to cart successfully...." ; } } }
      %>

      <% if (msgg !=null) { %>
        <p style="text-align:center; color: firebrick; font-weight: 600;">
          <%= msgg %>
        </p>
        <% } %>

          <div class="cart-table">
            <% int Total=0; DAO2 dao=new DAO2(DBConnect.getConn()); List<cart> listv = dao.getSelectedcart();
              if (listv.size() > 0) {
              %>
              <div style="display: flex; flex-direction: column; gap: 18px;">
                <% for(cart v : listv) { %>
                  <div class="cart-item-row">
                    <div class="cart-item-img">
                        <%
                        String imagePath = v.getPimage();
                        if (imagePath == null || imagePath.trim().isEmpty()) {
                            imagePath = "images/no-image.png";
                        } else if (!imagePath.startsWith("images/")) {
                            imagePath = "images/" + imagePath;
                        }
                        %>
                        <img src="<%=imagePath%>" 
                             alt="<%=v.getPname()%>" 
                             loading="lazy"
                             width="90"
                             height="90"
                             onerror="this.src='images/no-image.png'">
                    </div>
                    <div class="cart-item-info">
                      <div style="font-size:1.15rem; font-weight:600; color:#e67e22;">
                        <%=v.getPname() %>
                      </div>
                      <div style="color:#888; font-size:0.98rem;">Brand: <%=v.getBname() %> | Category:
                          <%=v.getCname()%>
                      </div>
                    </div>
                    <div class="cart-item-qty">
                      <span
                        style="background:#ffe5d9; padding:6px 18px; border-radius:6px; font-weight:500;">Qty:
                        <%=v.getPquantity() %></span>
                    </div>
                    <div class="cart-item-price">
                      $ <%=v.getPprice() %>
                    </div>
                    <div class="cart-item-remove">
                      <a href='removecartnull?cartId=<%=v.getCart_id()%>' title="Remove">
                        <img src="images/delete.jpg" alt="Remove" height="25px">
                      </a>
                    </div>
                    <% Total +=v.getPprice() * v.getPquantity(); %>
                  </div>
                  <% } %>
              </div>

              <div style="text-align: right; margin-top: 24px;">
                <div class="cart-total" style="margin-bottom: 10px;">Total Price: $ <%= Total %>
                </div>
                <% if (Total> 0) { %>
                  <a href='ShippingAddress.jsp?Total=<%= Total %>&CusName=<%= CusName%>'
                    class="proceed-btn">Proceed To Checkout</a>
                  <% } else { %>
                    <button onclick="show()" class="proceed-btn">Proceed To Checkout</button>
                    <% } %>
              </div>

              <% } else { %>
                <div class="empty-cart">
                  <img src="images/emptycart.png" alt="Empty Cart">
                  <h2>YOUR CART IS EMPTY</h2>
                </div>
                <% } %>
          </div>

          <footer>
            <%@ include file="footer.jsp" %>
          </footer>
</body>

</html>