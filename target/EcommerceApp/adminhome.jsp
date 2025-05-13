<%@page import="com.entity.viewlist"%>
<%@page import="java.util.List"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Home</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/abc.css">
<link rel="stylesheet" href="Css/font.css">
<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
body {
  background: linear-gradient(90deg, #f8fafc 60%, #ffe5d9 100%);
  min-height: 100vh;
}
.hero-section {
  background: linear-gradient(90deg, #f8fafc 60%, #ffe5d9 100%);
  padding: 40px 0 30px 0;
  text-align: center;
  margin-bottom: 20px;
  border-radius: 0 0 16px 16px;
}
.hero-section h1 {
  font-size: 2.8rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
}
.hero-section p {
  font-size: 1.3rem;
  color: #666;
  margin-bottom: 0;
}
.slideshow-container {
  max-width: 1000px;
  position: relative;
  margin: 30px auto 0 auto;
  border-radius: 12px;
  overflow: hidden;
  box-shadow: 0 4px 24px rgba(0,0,0,0.08);
}
.mySlides img {
  border-radius: 12px;
}
.slide-caption {
  position: absolute;
  left: 0; right: 0; bottom: 30px;
  color: #fff;
  background: rgba(0,0,0,0.35);
  padding: 12px 0;
  font-size: 1.2rem;
  letter-spacing: 1px;
  text-align: center;
  border-radius: 0 0 12px 12px;
}
.scrollmenu {
  background-color: #fff;
  overflow-x: auto;
  white-space: nowrap;
  padding: 20px 0 10px 0;
  margin: 0 auto 30px auto;
  border-radius: 10px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.06);
}
.scrollmenu b {
  display: inline-block;
  margin: 0 18px 10px 0;
}
.product-card {
  background: #fff;
  border-radius: 10px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.07);
  transition: transform 0.18s, box-shadow 0.18s;
  padding: 10px 18px 18px 18px;
  min-width: 210px;
  max-width: 220px;
  margin: 0 auto;
}
.product-card:hover {
  transform: translateY(-6px) scale(1.03);
  box-shadow: 0 6px 18px rgba(0,0,0,0.13);
}
.product-card img {
  border-radius: 8px;
  margin-bottom: 10px;
}
.product-title {
  font-size: 1.08rem;
  color: #222;
  font-weight: 500;
  text-decoration: none;
}
.product-title:hover {
  color: #e67e22;
  text-decoration: underline;
}
.featured-title {
  font-size: 2rem;
  color: #222;
  font-weight: 600;
  margin-bottom: 18px;
  letter-spacing: 1px;
}
footer {
  text-align: center;
  padding: 12px 0 6px 0;
  font-size: 1.1rem;
  border-radius: 0 0 10px 10px;
  margin-top: 40px;
}
.search-container {
  max-width: 600px;
  margin: 20px auto 0;
  padding: 0 20px;
}

.search-form {
  display: flex;
  gap: 10px;
}

.search-input {
  flex: 1;
  padding: 12px 20px;
  font-size: 1rem;
  border: 2px solid #ddd;
  border-radius: 25px;
  outline: none;
  transition: border-color 0.3s;
}

.search-input:focus {
  border-color: #e67e22;
}

.search-button {
  padding: 12px 30px;
  background-color: #e67e22;
  color: white;
  border: none;
  border-radius: 25px;
  font-size: 1rem;
  cursor: pointer;
  transition: background-color 0.3s;
}

.search-button:hover {
  background-color: #d35400;
}
</style>
</head>
<body>
<%@ include file="admin_navbar.jsp" %>
<div class="hero-section">
  <h1>Welcome, Admin</h1>
  <p>Manage your store, products, and customers with ease!</p>

  <div class="search-container">
    <form action="searcha.jsp" method="get" class="search-form">
      <input type="text" name="query" class="search-input" placeholder="Search for products..." required>
      <button type="submit" class="search-button">Search</button>
    </form>
  </div>
</div>
<div class="slideshow-container">
  <div class="mySlides">
    <img src="images/hometv.jpg" style="width:100%">
    <div class="slide-caption">Latest Smart TVs</div>
  </div>
  <div class="mySlides">
    <img src="images/homelaptop.jpg" style="width:100%">
    <div class="slide-caption">Powerful Laptops</div>
  </div>
  <div class="mySlides">
    <img src="images/homemobile.jpg" style="width:100%">
    <div class="slide-caption">Trending Smartphones</div>
  </div>
  <div class="mySlides">
    <img src="images/homewatch.jpg" style="width:100%">
    <div class="slide-caption">Smart Watches & Accessories</div>
  </div>
</div>
<br>
<div style="text-align:center">
  <span class="dot"></span>
  <span class="dot"></span>
  <span class="dot"></span>
  <span class="dot"></span>
</div>
<script>
let slideIndex = 0;
showSlides();
function showSlides() {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  slideIndex++;
  if (slideIndex > slides.length) {slideIndex = 1}
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
  setTimeout(showSlides, 2000);
}
</script>
<br>
<hr>
<br>
<center><div class="featured-title">Featured Products</div></center>
<br>
<div class="scrollmenu" style="max-width: 1200px">
  <% DAO2 dao = new DAO2(DBConnect.getConn());
     List<viewlist> listv = dao.getAllviewlist();
     for(viewlist v : listv) { %>
    <b>
    <div class="product-card">
      <center>
        <table>
          <tr><th>
            <a href = 'selecteditema.jsp?Pn=<%=v.getPimage()%>'>
              <img src ='images/<%= v.getPimage() %>' height="150px" width="150px">
            </a>
          </th></tr>
          <tr><th style='text-align: center; background-color: #f8fafc; padding-top: 8px;'>
            <a class="product-title" href = 'selecteditema.jsp?Pn=<%=v.getPimage()%>'>
              <%= v.getPname()%>
            </a>
          </th></tr>
        </table>
      </center>
    </div>
    </b>
  <% } %>
</div>
<br>
<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</body>
</html>