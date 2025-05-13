<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product Categories</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">
<style>
.w3-sidebar a { font-family: "Roboto", sans-serif }
body, h1, h2, h3, h4, h5, h6, .w3-wide { font-family: "Montserrat", sans-serif; }
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
.category-card {
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
  border-radius: 14px;
  background: #fff;
  margin-bottom: 28px;
  padding: 18px 10px 10px 10px;
  transition: box-shadow 0.2s;
  height: 100%;
  display: flex;
  flex-direction: column;
  align-items: center;
}
.category-card:hover {
  box-shadow: 0 6px 24px rgba(0,0,0,0.13);
}
.category-img {
  width: 100%;
  max-width: 180px;
  height: 150px;
  object-fit: contain;
  border-radius: 8px;
  margin-bottom: 12px;
}
.category-title {
  font-size: 1.2rem;
  font-weight: 600;
  color: #333;
  margin-bottom: 6px;
  text-align: center;
}
@media (max-width: 1000px) {
  .category-img { max-width: 98vw; }
}
</style>
</head>
<body>
<%@ include file = "admin_navbar.jsp" %>
<div class="hero-section">
  <h1>Product Category</h1>
</div>
<div class="container py-4">
  <div class="row justify-content-center">
    <div class="col-xxl-3 col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-4 d-flex">
      <div class="category-card w-100">
        <a href="tva.jsp">
          <img src="images/tv.png" alt="TV" class="category-img">
        </a>
        <div class="category-title">
          <a href="tva.jsp" style="text-decoration:none; color:#333;">TV</a>
        </div>
      </div>
    </div>
    <div class="col-xxl-3 col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-4 d-flex">
      <div class="category-card w-100">
        <a href="laptopa.jsp">
          <img src="images/laptop.png" alt="Laptop" class="category-img">
        </a>
        <div class="category-title">
          <a href="laptopa.jsp" style="text-decoration:none; color:#333;">Laptop</a>
        </div>
      </div>
    </div>
    <div class="col-xxl-3 col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-4 d-flex">
      <div class="category-card w-100">
        <a href="mobilea.jsp">
          <img src="images/mobile.png" alt="Mobile" class="category-img">
        </a>
        <div class="category-title">
          <a href="mobilea.jsp" style="text-decoration:none; color:#333;">Mobile</a>
        </div>
      </div>
    </div>
    <div class="col-xxl-3 col-xl-4 col-lg-4 col-md-6 col-sm-12 mb-4 d-flex">
      <div class="category-card w-100">
        <a href="watcha.jsp">
          <img src="images/watch.png" alt="Watch" class="category-img">
        </a>
        <div class="category-title">
          <a href="watcha.jsp" style="text-decoration:none; color:#333;">Watch</a>
        </div>
      </div>
    </div>
  </div>
</div>
<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</body>
</html>