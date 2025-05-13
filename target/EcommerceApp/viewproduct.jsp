<%@page import="com.dao.DAO2" %>
  <%@page import="com.entity.viewlist" %>
    <%@page import="java.util.List" %>
      <%@page import="com.conn.DBConnect" %>
        <%@page import="java.sql.*,java.io.*,java.text.*,java.util.*" %>
          <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>

            <head>
              <meta charset="UTF-8">
              <title>All Available Products</title>
              <link rel="stylesheet" href="images/bootstrap.css">
              <link rel="stylesheet" href="Css/w3.css">
              <link rel="stylesheet" href="Css/font.css">
              <style>
                .w3-sidebar a {
                  font-family: "Roboto", sans-serif
                }

                body,
                h1,
                h2,
                h3,
                h4,
                h5,
                h6,
                .w3-wide {
                  font-family: "Montserrat", sans-serif;
                }

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

                .product-card {
                  box-shadow: 0 2px 12px rgba(0, 0, 0, 0.07);
                  border-radius: 12px;
                  background: #fff;
                  margin-bottom: 28px;
                  padding: 18px 10px 10px 10px;
                  transition: box-shadow 0.2s;
                  height: 100%;
                  display: flex;
                  flex-direction: column;
                  align-items: center;
                }

                .product-card:hover {
                  box-shadow: 0 6px 24px rgba(0, 0, 0, 0.13);
                }

                .product-img {
                  width: 100%;
                  max-width: 180px;
                  height: 150px;
                  object-fit: contain;
                  border-radius: 8px;
                  margin-bottom: 12px;
                }

                .product-title {
                  font-size: 1.1rem;
                  font-weight: 600;
                  color: #333;
                  margin-bottom: 6px;
                  text-align: center;
                }

                @media (max-width: 1000px) {
                  .product-img {
                    max-width: 98vw;
                  }
                }

                .search-container {
                  max-width: 600px;
                  margin: 28px auto 32px;
                  padding: 0 20px;
                  background: #fff7f0;
                  border-radius: 18px;
                  box-shadow: 0 2px 12px rgba(230, 126, 34, 0.08);
                }

                .search-form {
                  display: flex;
                  gap: 0;
                  border-radius: 25px;
                  overflow: hidden;
                  box-shadow: 0 1px 6px rgba(230, 126, 34, 0.07);
                  background: #fff;
                }

                .search-input {
                  flex: 1;
                  padding: 14px 24px;
                  font-size: 1.08rem;
                  border: none;
                  border-radius: 0;
                  outline: none;
                  background: #fff;
                  color: #333;
                  transition: background 0.2s;
                }

                .search-input:focus {
                  background: #fff3e6;
                }

                .search-button {
                  padding: 0 32px;
                  background: linear-gradient(90deg, #e67e22 60%, #ffb88c 100%);
                  color: #fff;
                  border: none;
                  border-radius: 0 25px 25px 0;
                  font-size: 1.08rem;
                  font-weight: 600;
                  cursor: pointer;
                  transition: background 0.2s;
                  box-shadow: none;
                }

                .search-button:hover {
                  background: linear-gradient(90deg, #d35400 60%, #ffb88c 100%);
                }

                @media (max-width: 600px) {
                  .search-container {
                    max-width: 98vw;
                    padding: 0 4vw;
                  }

                  .search-form {
                    flex-direction: column;
                    gap: 10px;
                    box-shadow: none;
                  }

                  .search-input,
                  .search-button {
                    border-radius: 25px !important;
                  }
                }
              </style>
            </head>

            <body>
              <%@ include file="navbar.jsp" %>
                <div class="hero-section">
                  <h1>All Available Products</h1>
                </div>
                <div class="search-container">
                  <form action="#" method="get" class="search-form" onsubmit="return false;">
                    <input type="text" id="productSearch" name="query" class="search-input" placeholder="Search for products..." autocomplete="off">
                    <button type="button" class="search-button" onclick="filterProducts()">Search</button>
                  </form>
                </div>
                <div class="container">
                  <div class="row" id="productList">
                    <% DAO2 dao=new DAO2(DBConnect.getConn()); List<viewlist> listv = dao.getAllviewlist();
                      for(viewlist v : listv) { %>
                      <div class="col-xxl-3 col-xl-3 col-lg-4 col-md-6 col-sm-12 mb-4 d-flex product-item" data-name="<%= v.getPname().toLowerCase() %> <%= v.getBname().toLowerCase() %>">
                        <div class="product-card w-100">
                          <a href='selecteditem.jsp?Pn=<%=v.getPname()%>'>
                            <img src='images/<%= v.getPimage() %>' alt="<%= v.getBname()%> <%= v.getPname()%>"
                              class="product-img">
                          </a>
                          <div class="product-title">
                            <a href='selecteditem.jsp?Pn=<%=v.getPname()%>' style="text-decoration:none; color:#333;">
                              <%= v.getPname()%>
                            </a>
                          </div>
                        </div>
                      </div>
                      <% } %>
                  </div>
                </div>
                <script>
                  const searchInput = document.getElementById('productSearch');
                  searchInput.addEventListener('input', filterProducts);
                  function filterProducts() {
                    const query = searchInput.value.toLowerCase();
                    const products = document.querySelectorAll('.product-item');
                    products.forEach(item => {
                      const name = item.getAttribute('data-name');
                      if (name.includes(query)) {
                        item.style.display = '';
                      } else {
                        item.style.display = 'none';
                      }
                    });
                  }
                </script>
                <footer>
                  <%@ include file="footer.jsp" %>
                </footer>
            </body>

            </html>