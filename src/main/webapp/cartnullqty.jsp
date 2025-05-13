<%@page import="com.entity.cart"%>
<%@page import="java.util.List"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
Cookie[] cookies = request.getCookies();
String owner = null;
if (cookies != null) {
    for (Cookie cookie : cookies) {
        if (cookie.getName().equals("cname")) {
            owner = cookie.getValue(); // logged-in user
            break;
        }
    }
}
if (owner == null) {
    // Not logged in, use guestId cookie
    String guestId = null;
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("guestId")) {
                guestId = cookie.getValue();
                break;
            }
        }
    }
    owner = guestId;
}
int tqty= 0;
DAO2 daocnqty = new DAO2(DBConnect.getConn());
List<cart> listq = daocnqty.getSelectedcart();
for(cart v : listq)
{
    tqty = tqty + v.getPquantity();
}
%>
</body>
</html>