<%@page import="com.dao.DAO3"%>
<%@page import="com.entity.tv"%>
<%@page import="java.util.List"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="java.sql.*,java.io.*,java.text.*,java.util.*" %> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>TV Products</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">
<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
.hero-section {
  background: linear-gradient(90deg, #f8fafc 60%, #ffe5d9 100%);
  padding: 38px 0 28px 0;
  text-align: center;
  margin-bottom: 18px;
  border-radius: 0 0 16px 16px;
}
.hero-section h1 {
  font-size: 2.5rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
}
.hero-section h2 {
  font-size: 1.6rem;
  color: #e67e22;
  margin-bottom: 0;
  font-weight: 500;
}
.product-card {
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
  border-radius: 12px;
  background: #fff;
  margin-bottom: 28px;
  padding: 18px 10px 10px 10px;
  transition: box-shadow 0.2s;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.product-card:hover {
  box-shadow: 0 6px 24px rgba(0,0,0,0.13);
}
.product-img {
  width: 100%;
  max-width: 180px;
  height: 150px;
  object-fit: contain;
  border-radius: 8px;
  margin-bottom: 12px;
}
.product-title {
  font-size: 1.1rem;
  font-weight: 600;
  color: #333;
  margin-bottom: 6px;
  text-align: center;
}
@media (max-width: 1000px) {
  .product-img { max-width: 98vw; }
}
</style>
</head>

<body>
<form action="" method="post">
<%@ include file = "admin_navbar.jsp" %>
<div class="hero-section">
  <h1>TV Products</h1>
  <h2>Find Your Next Smart TV</h2>
</div>
<div class="container">
  <div class="row">
    <% DAO3 dao = new DAO3(DBConnect.getConn());
       List<tv> listv = dao.getAlltv();
       for(tv v : listv) { %>
      <div class="col-xxl-3 col-xl-3 col-lg-4 col-md-6 col-sm-12 mb-4 d-flex">
        <div class="product-card w-100">
          <a href='selecteditema.jsp?Pn=<%=v.getPname()%>'>
            <img src='images/<%= v.getPimage() %>' alt="<%= v.getBname()%> <%= v.getPname()%>" class="product-img">
          </a>
          <div class="product-title">
            <a href='selecteditema.jsp?Pn=<%=v.getPname()%>' style="text-decoration:none; color:#333;">
              <%= v.getPname()%>
            </a>
          </div>
        </div>
      </div>
    <% } %>
  </div>
</div>
<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</form>
</body>
</html>