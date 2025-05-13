<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href = "images/bootstrap.css">

<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">

<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
</style>
</head>
<body>

<%@ include file = "admin_navbar.jsp" %>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
  <div class="card shadow border-0 p-4" style="max-width: 420px; width: 100%; background: #f8f9fa; border-radius: 18px;">
    <div class="text-center mb-3">
      <h2 class="mb-3 text-success" style="font-weight: 700;">Product added successfully.</h2>
      <img src="images/success.png" alt="Success" height="80" class="mb-2">
    </div>
  </div>
</div>

<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</body>
</html>