<%@ include file="cartnullqty.jsp" %>
<!-- Modernized Navigation Bar with Custom Styling -->
<style>
.navbar-custom {
  border-radius: 0 0 16px 16px;
  background: linear-gradient(90deg, #f8fafc 60%, #ffe5d9 100%);
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
}
.navbar-brand {
  font-size: 1.7rem !important;
  font-weight: bold;
  color: #e67e22 !important;
  letter-spacing: 1px;
}
.navbar-nav .nav-link {
  font-weight: 500;
  color: #333 !important;
  transition: color 0.2s;
}
.navbar-nav .nav-link:hover {
  color: #e67e22 !important;
}
.btn-link {
  color: #333;
  font-weight: 500;
  text-decoration: none;
  border-radius: 6px;
  transition: background 0.2s, color 0.2s;
  padding: 6px 18px;
}
.btn-link:hover, .btn-link.active {
  background: #ffe5d9;
  color: #e67e22;
  text-decoration: none;
}
.badge.bg-danger {
  font-size: 0.95rem;
  padding: 6px 10px;
  top: 2px !important;
  right: 2px !important;
}
@media (max-width: 991px) {
  .navbar-brand { font-size: 1.2rem !important; }
  .btn-link { padding: 6px 10px; font-size: 1rem; }
}
</style>
<nav class="navbar navbar-expand-lg navbar-custom mb-3">
  <div class="container-fluid">
    <a class="navbar-brand" href="index.jsp">Online Electronic Shopping</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto align-items-center">
        <li class="nav-item me-2">
          <a href="cartnull.jsp" class="nav-link position-relative">
            <img src="images/cart.png" height="32" alt="Cart">
            <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
              <%=tqty %>
            </span>
          </a>
        </li>
        <li class="nav-item"><a href="customer_reg.jsp" class="nav-link">Customer Registration</a></li>
        <li class="nav-item"><a href="customerlogin.jsp" class="nav-link">Customer Login</a></li>
        <li class="nav-item"><a href="adminlogin.jsp" class="nav-link">Admin Login</a></li>
      </ul>
    </div>
  </div>
</nav>
<div class="container-fluid px-0">
  <div class="w-100 d-flex flex-wrap justify-content-center gap-2 pb-2" style="font-weight:bold;">
    <a href="index.jsp" class="btn btn-link">Home</a>
    <a href="category.jsp" class="btn btn-link">View Category</a>
    <a href="tv.jsp" class="btn btn-link">TV</a>
    <a href="laptop.jsp" class="btn btn-link">Laptop</a>
    <a href="mobile.jsp" class="btn btn-link">Mobile</a>
    <a href="watch.jsp" class="btn btn-link">Watch</a>
    <a href="viewproduct.jsp" class="btn btn-link">View All Product</a>
    <a href="aboutus.jsp" class="btn btn-link">About Us</a>
  </div>
</div>
<hr>

