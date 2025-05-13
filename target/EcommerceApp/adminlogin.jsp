<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/abc.css">
<link rel="stylesheet" href="Css/font.css">
<link rel="stylesheet" href="Css/spin.css">
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
.login-card {
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
  border-radius: 14px;
  background: #fff;
  margin: 0 auto 28px auto;
  padding: 36px 32px 32px 32px;
  max-width: 420px;
  text-align: center;
}
.login-card img {
  width: 120px;
  height: 120px;
  object-fit: contain;
  border-radius: 50%;
  margin-bottom: 18px;
  box-shadow: 0 2px 8px rgba(0,0,0,0.10);
}
.login-card input[type="text"],
.login-card input[type="password"] {
  width: 100%;
  padding: 10px 12px;
  margin-bottom: 18px;
  border: 1px solid #ccc;
  border-radius: 6px;
  font-size: 1.1rem;
}
.login-card input[type="submit"] {
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
.login-card input[type="submit"]:hover {
  background: #cf711f;
}
.login-card .msg {
  color: firebrick;
  margin-bottom: 12px;
  font-size: 1.05rem;
}
</style>
</head>
<body>
<form method="post" action="checkadmin">
<%@ include file = "navbar.jsp" %>
<%
String fail = null;
String msg = null;
// RENAME THE VARIABLE HERE:
Cookie[] adminLoginCookies = request.getCookies(); // <--- RENAMED
if (adminLoginCookies != null) { // Good practice to check for null
    for(int i = 0; i < adminLoginCookies.length; i++) {
        if (adminLoginCookies[i].getName().equals("tname")) {
            adminLoginCookies[i].setMaxAge(0);
            response.addCookie(adminLoginCookies[i]);
            msg = "You are logout successfully....";
        }
        if (adminLoginCookies[i].getName().equals("un")) { // This cookie seems to indicate a failed login attempt
            adminLoginCookies[i].setMaxAge(0);
            response.addCookie(adminLoginCookies[i]);
            fail = "Username or Password is wrong.";
        }
    }
}
%>
<div class="hero-section">
  <h1>Admin Login</h1>
</div>
<div class="container d-flex justify-content-center align-items-center" style="min-height: 70vh;">
  <div class="row w-100" style="max-width: 700px;">
    <div class="col-md-5 d-flex flex-column align-items-center justify-content-center">
      <img src="images/adminimg.png" alt="Admin Login" style="width: 100%; max-width: 180px; height: 180px; object-fit: contain; border-radius: 14px; box-shadow: 0 2px 8px rgba(0,0,0,0.10); margin-bottom: 18px;">
    </div>
    <div class="col-md-7">
      <div class="login-card" style="box-shadow:none; padding:0; max-width:none; background:transparent;">
        <%if(msg != null) { %><div class="msg"><%= msg %></div><% } %>
        <%if(fail != null) { %><div class="msg"><%= fail %></div><% } %>
        <label for="x1"><b>Username:</b></label>
        <input type="text" id="x1" name="Username" required>
        <label for="x2"><b>Password:</b></label>
        <input type="password" id="x2" name="Password" required>
        <input type="submit" name="b1" value="Login">
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