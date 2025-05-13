<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<form method = "post" action = "payprocess">
	<%@ include file = "customer_navbar.jsp" %>

<%
String CName = request.getParameter("CName");
String CusName = request.getParameter("CusName");
String City = request.getParameter("City");
String Total = request.getParameter("Total"); 
String N2 = N;
%>
<input type = "hidden" name = "CName" value ="<%=CName %>" >
<input type = "hidden" name = "City" value ="<%=City %>" >
<input type = "hidden" name = "Total" value =<%=Total %> >
<input type = "hidden" name = "CusName" value =<%=CusName %> >
<input type = "hidden" name = "N2" value ="<%=N2 %>" >

<div class="container d-flex justify-content-center align-items-center" style="min-height: 80vh;">
  <div class="card shadow border-0 p-4" style="max-width: 420px; width: 100%; background: #f8f9fa; border-radius: 18px;">
    <div class="text-center mb-4">
      <h2 class="mb-2 font-weight-bold" style="color: #2d2d2d; letter-spacing: 1px;">Confirm Payment</h2>
      <img src="images/paymethod.png" alt="Payment Methods" height="40" width="180" class="mb-3">
      <p class="text-muted mb-0">Please confirm your payment to proceed</p>
    </div>
    <div class="mb-4 text-center">
      <span class="font-weight-bold" style="font-size: 1.1rem;">Amount to Pay:</span>
      <span class="h4 ml-2 text-success">$ <%=Total %></span>
    </div>
    <div class="d-grid gap-2 mb-3">
      <input type="submit" value="Confirm Payment" class="btn btn-success btn-lg font-weight-bold shadow-sm">
    </div>
    <div class="text-center mb-2">
      <span class="text-muted">or</span>
    </div>
    <div class="d-grid gap-2">
      <a href="customerhome.jsp" class="btn btn-outline-danger">Cancel Payment</a>
    </div>
  </div>
</div>

<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</form>
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
</body>
</html>