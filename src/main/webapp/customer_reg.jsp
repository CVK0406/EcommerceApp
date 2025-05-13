<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href = "images/bootstrap.css">

<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/abc.css">
<link rel="stylesheet" href="Css/font.css">
<link rel="stylesheet" href="Css/whitespace.css">

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
.register-card {
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
  border-radius: 14px;
  background: #fff;
  margin: 0 auto 28px auto;
  padding: 36px 32px 32px 32px;
  max-width: 420px;
  text-align: center;
}
.register-card img {
  width: 120px;
  height: 120px;
  object-fit: contain;
  border-radius: 50%;
  margin-bottom: 18px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.10);
}
.register-card input[type="text"],
.register-card input[type="password"],
.register-card input[type="email"],
.register-card input[type="number"] {
  width: 100%;
  padding: 10px 12px;
  margin-bottom: 18px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 1.1rem;
}
.register-card input[type="submit"] {
  width: 100%;
  padding: 10px 0;
  background: #e67e22;
  color: #fff;
  border: none;
  border-radius: 6px;
  font-size: 1.15rem;
  font-weight: 600;
  transition: background 0.2s;
}
.register-card input[type="submit"]:hover {
  background: #cf711f;
}
</style>
</head>


<body>
		
		<form method= "post" action = "addcustomer" enctype="multipart/form-data" >
			<%@ include file = "navbar.jsp" %>
			
			<% String Total5 = request.getParameter("Total"); %>
	
	<input type = "hidden" name = "Total" value =<%=Total5 %> >
	
	
	<% String CusName5 = request.getParameter("CusName"); %>
	
	<input type = "hidden" name = "CusName" value =<%=CusName5 %> >
	
			
			

<div class="hero-section">
  <h1>Customer Registration</h1>
</div>
<div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
  <div class="row w-100" style="max-width: 700px;">
    <div class="col-md-5 d-flex flex-column align-items-center justify-content-center">
      <img src="images/regimg.png" alt="Register" style="width: 100%; max-width: 180px; height: 180px; object-fit: contain; border-radius: 14px; box-shadow: 0 2px 8px rgba(0,0,0,0.10); margin-bottom: 18px;">
    </div>
    <div class="col-md-7">
      <div class="register-card" style="box-shadow:none; padding:0; max-width:none; background:transparent;">
        <label for="username"><b>Set Username:</b></label>
        <input type="text" id="username" name="Username" required>
        <label for="password"><b>Set Password:</b></label>
        <input type="password" id="password" name="Password" required>
        <label for="email"><b>Set Email Id:</b></label>
        <input type="email" id="email" name="Email_Id" required>
        <label for="contact"><b>Set Contact No:</b></label>
        <input type="number" id="contact" name="Contact_No" required>
        <input type="submit" name="b1" value="Register">
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