<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Payment Details</title>
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
.payment-card {
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 2px 16px rgba(0,0,0,0.10);
  padding: 32px 28px 28px 28px;
  margin: 0 auto 32px auto;
  max-width: 600px;
  display: flex;
  flex-direction: column;
  gap: 18px;
}
.payment-card label {
  font-weight: 500;
  color: #555;
  margin-bottom: 2px;
}
.payment-card input[type="text"],
.payment-card input[type="number"],
.payment-card select {
  width: 100%;
  padding: 10px 12px;
  border-radius: 6px;
  border: 1px solid #ddd;
  font-size: 1.08rem;
  background: #f8fafc;
  margin-bottom: 8px;
}
.payment-card input[type="submit"], .payment-card .cancel-btn {
  background: #e67e22;
  color: #fff;
  font-weight: 600;
  border: none;
  border-radius: 6px;
  padding: 10px 32px;
  font-size: 1.08rem;
  margin-top: 10px;
  transition: background 0.2s;
  text-decoration: none;
  display: inline-block;
}
.payment-card input[type="submit"]:hover, .payment-card .cancel-btn:hover {
  background: #cf711f;
  color: #fff;
  text-decoration: none;
}
.payment-card .btn-group {
  display: flex;
  gap: 16px;
  margin-top: 10px;
}
.payment-card .pay-image {
  display: flex;
  justify-content: center;
  margin-bottom: 18px;
}
</style>
</head>
<body>
<form method="post" action="confirmpayment.jsp">
<%@ include file = "customer_navbar.jsp" %>
<div class="hero-section">
  <h1>Payment Details</h1>
</div>
<% String CName = request.getParameter("CName");
   String CusName = request.getParameter("CusName");
   String City = request.getParameter("City");
   String Total = request.getParameter("Total"); %>
<input type="hidden" name="CName" value="<%=CName %>">
<input type="hidden" name="City" value="<%=City %>">
<input type="hidden" name="Total" value="<%=Total %>">
<input type="hidden" name="CusName" value="<%=CusName %>">
<div class="container d-flex justify-content-center align-items-center" style="min-height: 90vh;">
  <div class="card shadow-lg p-4" style="max-width: 500px; width: 100%; background: #fff; border-radius: 18px;">
    <div class="text-center mb-4">
      <h2 class="mb-2" style="font-weight: 700; color: #333;">Payment Details</h2>
      <img src="images/payimg.jpg" alt="Payment" height="120" class="mb-2 rounded">
      <div><img src="images/paymethod.png" height="40" width="180" class="mb-2"></div>
      <p class="text-muted mb-0">Fill below details to proceed</p>
    </div>
    <div class="mb-3">
      <label class="form-label ws" for="ccname"><b>Name on Credit Card</b></label>
      <input type="text" id="ccname" name="ccname" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label ws" for="ccnumber"><b>Credit Card Number</b></label>
      <input type="number" id="ccnumber" name="ccnumber" class="form-control" required>
    </div>
    <div class="mb-3">
      <label class="form-label ws" for="cardtype"><b>Select Card</b></label>
      <select name="Credit Card Type" id="cardtype" class="form-select" required>
        <option value="" disabled selected>Select Card</option>
        <option>Master Card</option>
        <option>Visa Card</option>
        <option>Discover</option>
        <option>Maestro</option>
        <option>American Express</option>
      </select>
    </div>
    <div class="mb-3">
      <label class="form-label ws"><b>Expiry Date</b></label>
      <div class="row g-2">
        <div class="col-6">
          <select name="Month" class="form-select" required>
            <option value="" disabled selected>Month</option>
            <option>January</option>
            <option>February</option>
            <option>March</option>
            <option>April</option>
            <option>May</option>
            <option>June</option>
            <option>July</option>
            <option>August</option>
            <option>September</option>
            <option>October</option>
            <option>November</option>
            <option>December</option>
          </select>
        </div>
        <div class="col-6">
          <select name="Year" class="form-select" required>
            <option value="" disabled selected>Year</option>
            <% for(int i = 2015; i <= 2035; i++) { %>
              <option><%= i %></option>
            <% } %>
          </select>
        </div>
      </div>
    </div>
    <div class="mb-3">
      <label class="form-label ws" for="cvvno"><b>CVV No.</b></label>
      <input type="number" id="cvvno" name="cvvno" class="form-control" required>
    </div>
    <div class="mb-4">
      <label class="form-label ws"><b>Amount Paid</b></label>
      <input type="text" value="$ <%=Total %>" class="form-control bg-light" disabled required>
    </div>
    <div class="d-flex justify-content-between align-items-center">
      <a href="customerhome.jsp" class="btn btn-outline-secondary">Cancel Payment</a>
      <input type="submit" value="Proceed" name="online" class="btn btn-primary px-4">
    </div>
  </div>
</div>
<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</form>
</body>
</html>