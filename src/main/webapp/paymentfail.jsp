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
<%String fail = request.getParameter("msgf"); %>


<form action = "" method = "post">
<%@ include file = "customer_navbar.jsp" %>

<center>
<div style="background-color: #ebe9eb">	
	<br>
	<h1>Message</h1>
	<br>
	</div>
	<br>
	<h2 style="color:firebrick"><%=fail %></h2>


</center>
<br><br>
</form>

<div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
  <div class="card shadow border-0 p-4" style="max-width: 420px; width: 100%; background: #fff3f3; border-radius: 18px;">
    <div class="text-center mb-3">
      <h2 class="mb-3 text-danger" style="font-weight: 700;">Payment Failed</h2>
      <img src="images/fail.png" alt="Failed" height="80" class="mb-2">
      <h4 class="mt-3" style="color:firebrick"><%=fail %></h4>
    </div>
  </div>
</div>

<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</body>
</html>