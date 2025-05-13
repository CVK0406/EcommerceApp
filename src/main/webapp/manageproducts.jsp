<%@page import="com.entity.category"%>
<%@page import="com.entity.brand"%>
<%@page import="com.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="com.conn.DBConnect"%>
<%@page import="com.dao.DAO"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Products</title>
<link rel="stylesheet" href="images/bootstrap.css">
<link rel="stylesheet" href="Css/w3.css">
<link rel="stylesheet" href="Css/font.css">
<link rel="stylesheet" href="Css/abc.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
<style>
body, h1, h2, h3, h4, h5, h6, .w3-wide { font-family: "Montserrat", sans-serif; }
.hero-section {
  background: #fff;
  border-radius: 0 0 16px 16px;
  padding: 24px 0;
  text-align: center;
  margin-bottom: 24px;
  box-shadow: 0 2px 12px rgba(0,0,0,0.07);
}
.hero-section h1 {
  font-size: 2.3rem;
  font-weight: bold;
  color: #e67e22;
  margin-bottom: 16px;
}
.products-table {
  background: #fff;
  border-radius: 16px;
  box-shadow: 0 2px 16px rgba(0,0,0,0.10);
  padding: 24px;
  margin: 0 auto 32px auto;
  width: 95%;
  max-width: 1200px;
}
.products-table table {
  width: 100%;
  border-collapse: collapse;
  margin-top: 16px;
}
.products-table th {
  background: #f8f9fa;
  padding: 12px;
  text-align: left;
  font-weight: 600;
  color: #495057;
  border-bottom: 2px solid #dee2e6;
}
.products-table td {
  padding: 12px;
  border-bottom: 1px solid #dee2e6;
  vertical-align: middle;
}
.products-table tr:hover {
  background: #f8f9fa;
}
.product-image {
  width: 80px;
  height: 80px;
  object-fit: cover;
  border-radius: 8px;
}
.btn-action {
  padding: 6px 12px;
  border-radius: 4px;
  border: none;
  cursor: pointer;
  margin-right: 8px;
  transition: all 0.2s;
}
.btn-edit {
  background: #28a745;
  color: white;
}
.btn-delete {
  background: #dc3545;
  color: white;
}
.btn-add {
  background: #e67e22;
  color: white;
  padding: 10px 20px;
  border-radius: 6px;
  border: none;
  font-weight: 600;
  margin-bottom: 20px;
  cursor: pointer;
  transition: background 0.2s;
}
.btn-add:hover {
  background: #cf711f;
}
.modal {
  display: none;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background: rgba(0,0,0,0.5);
  z-index: 1000;
}
.modal-content {
  background: white;
  width: 90%;
  max-width: 600px;
  margin: 50px auto;
  padding: 24px;
  border-radius: 16px;
  box-shadow: 0 4px 20px rgba(0,0,0,0.15);
}
.modal-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}
.modal-header h2 {
  margin: 0;
  color: #e67e22;
}
.close-modal {
  background: none;
  border: none;
  font-size: 24px;
  cursor: pointer;
  color: #666;
}
.form-group {
  margin-bottom: 16px;
}
.form-group label {
  display: block;
  margin-bottom: 8px;
  font-weight: 500;
  color: #555;
}
.form-group input,
.form-group select {
  width: 100%;
  padding: 10px 12px;
  border-radius: 6px;
  border: 1px solid #ddd;
  font-size: 1rem;
  background: #f8fafc;
}
.form-group input[type="file"] {
  padding: 8px 0;
}
.modal-footer {
  margin-top: 24px;
  text-align: right;
}
.modal-footer button {
  padding: 10px 24px;
  border-radius: 6px;
  border: none;
  font-weight: 600;
  cursor: pointer;
  transition: background 0.2s;
}
.btn-save {
  background: #e67e22;
  color: white;
}
.btn-cancel {
  background: #6c757d;
  color: white;
  margin-left: 12px;
}

.search-container {
  max-width: 600px;
  margin: 0 auto;
  padding: 0 20px;
}

.search-form {
  display: flex;
  gap: 10px;
}

.search-input {
  flex: 1;
  padding: 12px 20px;
  font-size: 1rem;
  border: 2px solid #ddd;
  border-radius: 25px;
  outline: none;
  transition: border-color 0.3s;
  background: #f8fafc;
}

.search-input:focus {
  border-color: #e67e22;
}

.search-input::placeholder {
  color: #999;
}
</style>
</head>
<body>
<%@ include file = "admin_navbar.jsp" %>

<div class="hero-section">
  <h1>Manage Products</h1>
  <div class="search-container">
    <div class="search-form">
      <input type="text" id="searchInput" class="search-input" placeholder="Search products by name, brand, or category..." onkeyup="filterProducts()">
    </div>
  </div>
</div>

<div class="products-table">
  <button class="btn-add" onclick="openAddModal()">
    <i class="fas fa-plus"></i> Add New Product
  </button>
  
  <table>
    <thead>
      <tr>
        <th>Image</th>
        <th>Name</th>
        <th>Brand</th>
        <th>Category</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <% 
      DAO dao = new DAO(DBConnect.getConn());
      List<Product> products = dao.getAllProducts();
      for(Product p : products) { 
      %>
        <tr>
          <td><img src="images/<%= p.getPimage() %>" class="product-image" alt="<%= p.getPname() %>"></td>
          <td><%= p.getPname() %></td>
          <td><%= dao.getBrandName(p.getBid()) %></td>
          <td><%= dao.getCategoryName(p.getCid()) %></td>
          <td>$<%= p.getPprice() %></td>
          <td><%= p.getPquantity() %></td>
          <td>
            <button class="btn-action btn-edit" data-pid="<%= p.getPid() %>" onclick="openEditModal(this.getAttribute('data-pid'))">
              <i class="fas fa-edit"></i>
            </button>
            <button class="btn-action btn-delete" data-pid="<%= p.getPid() %>" onclick="deleteProduct(this.getAttribute('data-pid'))">
              <i class="fas fa-trash"></i>
            </button>
          </td>
        </tr>
      <% } %>
    </tbody>
  </table>
</div>

<!-- Add Product Modal -->
<div id="addProductModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2>Add New Product</h2>
      <button class="close-modal" onclick="closeModal('addProductModal')">&times;</button>
    </div>
    <form method="post" action="addproduct" enctype="multipart/form-data">
      <div class="form-group">
        <label for="brand">Brand:</label>
        <select name="bname" id="brand" required>
          <% 
          List<brand> listb = dao.getAllbrand();
          for(brand b : listb) { 
          %>
            <option value="<%= b.getBname() %>"><%= b.getBname() %></option>
          <% } %>
        </select>
      </div>
      <div class="form-group">
        <label for="category">Category:</label>
        <select name="cname" id="category" required>
          <% 
          List<category> listc = dao.getAllcategory();
          for(category c : listc) { 
          %>
            <option value="<%= c.getCname() %>"><%= c.getCname() %></option>
          <% } %>
        </select>
      </div>
      <div class="form-group">
        <label for="pname">Product Name:</label>
        <input type="text" name="pname" id="pname" required>
      </div>
      <div class="form-group">
        <label for="pprice">Price:</label>
        <input type="number" name="pprice" id="pprice" required>
      </div>
      <div class="form-group">
        <label for="pquantity">Quantity:</label>
        <input type="number" name="pquantity" id="pquantity" value="1" required>
      </div>
      <div class="form-group">
        <label for="pimage">Product Image:</label>
        <input type="file" name="pimage" id="pimage" required>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn-cancel" onclick="closeModal('addProductModal')">Cancel</button>
        <button type="submit" class="btn-save">Add Product</button>
      </div>
    </form>
  </div>
</div>

<!-- Edit Product Modal -->
<div id="editProductModal" class="modal">
  <div class="modal-content">
    <div class="modal-header">
      <h2>Edit Product</h2>
      <button class="close-modal" onclick="closeModal('editProductModal')">&times;</button>
    </div>
    <form method="post" action="updateproduct" enctype="multipart/form-data">
      <input type="hidden" name="pid" id="edit_pid">
      <div class="form-group">
        <label for="edit_brand">Brand:</label>
        <select name="bname" id="edit_brand" required>
          <% for(brand b : listb) { %>
            <option value="<%= b.getBname() %>"><%= b.getBname() %></option>
          <% } %>
        </select>
      </div>
      <div class="form-group">
        <label for="edit_category">Category:</label>
        <select name="cname" id="edit_category" required>
          <% for(category c : listc) { %>
            <option value="<%= c.getCname() %>"><%= c.getCname() %></option>
          <% } %>
        </select>
      </div>
      <div class="form-group">
        <label for="edit_pname">Product Name:</label>
        <input type="text" name="pname" id="edit_pname" required>
      </div>
      <div class="form-group">
        <label for="edit_pprice">Price:</label>
        <input type="number" name="pprice" id="edit_pprice" required>
      </div>
      <div class="form-group">
        <label for="edit_pquantity">Quantity:</label>
        <input type="number" name="pquantity" id="edit_pquantity" required>
      </div>
      <div class="form-group">
        <label for="edit_pimage">Product Image:</label>
        <input type="file" name="pimage" id="edit_pimage">
        <small>Leave empty to keep current image</small>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn-cancel" onclick="closeModal('editProductModal')">Cancel</button>
        <button type="submit" class="btn-save">Update Product</button>
      </div>
    </form>
  </div>
</div>

<script>
function openAddModal() {
  document.getElementById('addProductModal').style.display = 'block';
}

function openEditModal(pid) {
  // Fetch product details via AJAX and populate the form
  fetch('getproduct?id=' + pid)
    .then(response => response.json())
    .then(product => {
      document.getElementById('edit_pid').value = product.pid;
      document.getElementById('edit_brand').value = product.bname;
      document.getElementById('edit_category').value = product.cname;
      document.getElementById('edit_pname').value = product.pname;
      document.getElementById('edit_pprice').value = product.pprice;
      document.getElementById('edit_pquantity').value = product.pquantity;
      document.getElementById('editProductModal').style.display = 'block';
    });
}

function closeModal(modalId) {
  document.getElementById(modalId).style.display = 'none';
}

function deleteProduct(pid) {
  if(confirm('Are you sure you want to delete this product?')) {
    window.location.href = 'deleteproduct?id=' + pid;
  }
}

// Close modal when clicking outside
window.onclick = function(event) {
  if (event.target.className === 'modal') {
    event.target.style.display = 'none';
  }
}

function filterProducts() {
  const input = document.getElementById('searchInput');
  const filter = input.value.toLowerCase();
  const table = document.querySelector('.products-table table');
  const rows = table.getElementsByTagName('tr');

  // Loop through all table rows except the header
  for (let i = 1; i < rows.length; i++) {
    const row = rows[i];
    const cells = row.getElementsByTagName('td');
    let found = false;

    // Loop through all cells in the row
    for (let j = 0; j < cells.length - 1; j++) { // -1 to exclude the actions column
      const cell = cells[j];
      if (cell) {
        const text = cell.textContent || cell.innerText;
        if (text.toLowerCase().indexOf(filter) > -1) {
          found = true;
          break;
        }
      }
    }

    // Show/hide row based on search match
    row.style.display = found ? '' : 'none';
  }
}
</script>

<footer>
  <%@ include file = "footer.jsp" %>
</footer>
</body>
</html>