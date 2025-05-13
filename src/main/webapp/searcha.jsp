<%@page import="com.entity.viewlist"%>
<%@page import="java.util.List"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">
<link rel="stylesheet" href="Css/abc.css">

<style>
body {
  background: linear-gradient(90deg, #f8fafc 60%, #ffe5d9 100%);
  font-family: 'Montserrat', sans-serif;
  min-height: 100vh;
  margin: 0;
  padding: 0;
}

.search-results-container {
    max-width: 1200px;
    margin: 30px auto;
    padding: 0 20px;
    min-height: calc(100vh - 300px); /* Ensure content pushes footer down */
}

.search-header {
    margin-bottom: 30px;
}

.search-header h2 {
    font-size: 1.8rem;
    color: #333;
    margin-bottom: 10px;
}

.search-header p {
    color: #666;
    font-size: 1.1rem;
}

.no-results {
    text-align: center;
    padding: 40px 20px;
    background: #f8fafc;
    border-radius: 10px;
    margin: 20px 0;
}

.no-results p {
    font-size: 1.2rem;
    color: #666;
    margin-bottom: 20px;
}

.back-button {
    display: inline-block;
    padding: 10px 20px;
    background-color: #e67e22;
    color: white;
    text-decoration: none;
    border-radius: 5px;
    transition: background-color 0.3s;
}

.back-button:hover {
    background-color: #d35400;
    color: white;
}

/* Reuse existing product card styles from index.jsp */
.scrollmenu {
    background-color: #fff;
    overflow-x: auto;
    white-space: nowrap;
    padding: 20px 0 10px 0;
    margin: 0 auto 30px auto;
    border-radius: 10px;
    box-shadow: 0 2px 12px rgba(0,0,0,0.06);
}

.product-card {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
    transition: transform 0.18s, box-shadow 0.18s;
    padding: 10px 18px 18px 18px;
    min-width: 210px;
    max-width: 220px;
    margin: 0 auto;
    display: inline-block;
}

.product-card:hover {
    transform: translateY(-6px) scale(1.03);
    box-shadow: 0 6px 18px rgba(0,0,0,0.13);
}

.product-title {
    font-size: 1.08rem;
    color: #222;
    font-weight: 500;
    text-decoration: none;
}

.product-title:hover {
    color: #e67e22;
    text-decoration: underline;
}

footer {
    text-align: center;
    padding: 12px 0 6px 0;
    font-size: 1.1rem;
    border-radius: 0 0 10px 10px;
    margin-top: 40px;
    background-color: #fff;
    box-shadow: 0 -2px 10px rgba(0,0,0,0.05);
    position: relative;
    width: 100%;
}
</style>
</head>
<body>
    <%@ include file="admin_navbar.jsp" %>

    <div class="search-results-container">
        <div class="search-header">
            <h2>Search Results</h2>
            <%
            String query = request.getParameter("query");
            if (query != null && !query.trim().isEmpty()) {
            %>
                <p>Showing results for: "<%= query %>"</p>
            <%
            } else {
            %>
                <p>Please enter a search term to find products.</p>
            <%
            }
            %>
        </div>

        <div class="scrollmenu">
            <%
            if (query != null && !query.trim().isEmpty()) {
                DAO2 dao = new DAO2(DBConnect.getConn());
                List<viewlist> searchResults = dao.searchProducts(query);
                
                if (searchResults != null && !searchResults.isEmpty()) {
                    for(viewlist v : searchResults) {
            %>
                        <div class="product-card">
                            <center>
                                <table>
                                    <tr><th>
                                        <a href='selecteditema.jsp?Pn=<%=v.getPname()%>'>
                                            <img src='images/<%= v.getPimage() %>' height="150px" width="150px">
                                        </a>
                                    </th></tr>
                                    <tr><th style='text-align: center; background-color: #f8fafc; padding-top: 8px;'>
                                        <a class="product-title" href='selecteditema.jsp?Pn=<%=v.getPname()%>'>
                                            <%= v.getPname()%>
                                        </a>
                                    </th></tr>
                                </table>
                            </center>
                        </div>
            <%
                    }
                } else {
            %>
                    <div class="no-results">
                        <p>No products found matching your search criteria.</p>
                        <a href="adminhome.jsp" class="back-button">Back to Home</a>
                    </div>
            <%
                }
            } else {
            %>
                <div class="no-results">
                    <p>Please enter a search term in the search box to find products.</p>
                    <a href="adminhome.jsp" class="back-button">Back to Home</a>
                </div>
            <%
            }
            %>
        </div>
    </div>

    <footer>
        <%@ include file="footer.jsp" %>
    </footer>
</body>
</html> 