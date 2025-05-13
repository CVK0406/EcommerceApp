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
<title>Manage Tables</title>
<link rel="stylesheet" href = "images/bootstrap.css">

<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">
<link rel="stylesheet" href="Css/customizebutton.css">



<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}

.a{
	margin-right: 50px ;
	
	}
    
    .b{
	margin-right: 25px;
	
	}
	
	.e{
	margin-left: 40px ;
	
	}
    
    .d{
	margin-left: 18px ;
	
	}
	


</style>
</head>

<body>
<form action = "" method = "post">

<%@ include file = "admin_navbar.jsp" %>


	<div class="container py-4">
  <div class="card shadow border-0" style="border-radius: 18px;">
    <div class="card-header bg-primary text-white text-center" style="border-radius: 0.7rem 0.7rem 0 0;">
      <h2 class="mb-0" style="letter-spacing: 1px;">Manage Tables</h2>
    </div>
    <div class="card-body">
      <div class="row justify-content-center g-4">
        <div class="col-12 col-md-6 col-lg-4 mb-3">
          <a href="table_orders.jsp" class="btn btn-outline-success btn-lg w-100 shadow-sm mb-2">
            <b>Table Orders</b>
          </a>
        </div>
        <div class="col-12 col-md-6 col-lg-4 mb-3">
          <a href="table_order_details.jsp" class="btn btn-outline-warning btn-lg w-100 shadow-sm mb-2">
            <b>Table Order Details</b>
          </a>
        </div>
      </div>
    </div>
  </div>
</div>

<footer>
  <%@ include file = "footer.jsp" %>
</footer>


</form>

</body>
</html>