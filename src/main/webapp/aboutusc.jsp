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
<link rel="stylesheet" href="Css/abc.css">


<style>
.w3-sidebar a {font-family: "Roboto", sans-serif}
body,h1,h2,h3,h4,h5,h6,.w3-wide {font-family: "Montserrat", sans-serif;}
.about-hero {
  background: linear-gradient(90deg, #f8fafc 60%, #ffe5d9 100%);
  padding: 38px 0 28px 0;
  text-align: center;
  margin-bottom: 18px;
  border-radius: 0 0 16px 16px;
}
.about-hero h1 {
  font-size: 2.5rem;
  font-weight: bold;
  color: #333;
  margin-bottom: 8px;
}
.about-hero h2 {
  font-size: 1.6rem;
  color: #e67e22;
  margin-bottom: 0;
  font-weight: 500;
}
.about-content {
  max-width: 900px;
  margin: 0 auto 30px auto;
  background: #fff;
  border-radius: 12px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
  padding: 32px 36px 24px 36px;
  text-align: center;
}
.about-content p {
  font-size: 1.18rem;
  color: #444;
  margin-bottom: 24px;
  line-height: 1.7;
}
.about-img-container {
  display: flex;
  justify-content: center;
  margin-bottom: 18px;
}
.about-img {
  width: 100%;
  max-width: 900px;
  height: auto;
  border-radius: 14px;
  box-shadow: 0 4px 18px rgba(0,0,0,0.10);
}
@media (max-width: 1000px) {
  .about-img { max-width: 98vw; }
  .about-content { padding: 18px 8vw 18px 8vw; }
}
</style>
</head>
<body>
<form action="" method="post">
	<%@ include file = "customer_navbar.jsp" %>

	<div class="about-hero">
		<h1>About Us</h1>
		<h2>Be Smart <b>With Smart Devices</b></h2>
	</div>

	<div class="about-content">
		<p>
			Welcome to Online Electronic Store, your trusted destination for the latest and greatest in smart devices and electronics. 
			We are passionate about bringing you top-quality products, unbeatable deals, and exceptional customer service. 
			Whether you're looking for the newest gadgets or reliable classics, our team is dedicated to making your shopping experience easy, secure, and enjoyable.
		</p>
		<div class="about-img-container">
			<img src="images/aboutus2.jpg" alt="About Us" class="about-img">
		</div>
	</div>

	<footer>
		<%@ include file = "footer.jsp" %>
	</footer>
</form>
</body>
</html>