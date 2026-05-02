<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ShoppyCart – Shop</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>

<%-- Toast notification --%>
<c:if test="${not empty sessionScope.toast}">
  <div class="toast" id="toast">${sessionScope.toast}</div>
  <c:remove var="toast" scope="session"/>
  <script>
    setTimeout(() => document.getElementById('toast')?.remove(), 2500);
  </script>
</c:if>

<div class="app-container">

  <%-- Header --%>
  <div class="shop-header">
    <div class="logo">
      <i class="fas fa-bag-shopping"></i>
      <span>ShoppyCart</span>
    </div>
    <a href="${pageContext.request.contextPath}/cart" class="cart-icon-btn">
      <i class="fas fa-shopping-cart"></i>
      <span class="cart-badge">${cartCount}</span>
    </a>
  </div>

  <%-- Tabs --%>
  <div class="tabs">
    <a href="${pageContext.request.contextPath}/shop" class="tab active">🛍️ Shop</a>
    <a href="${pageContext.request.contextPath}/cart" class="tab">🛒 Cart (${cartCount})</a>
  </div>

  <%-- Product Grid --%>
  <div class="page-content">
    <div class="product-grid">
      <c:forEach var="product" items="${products}">
        <div class="product-card">
          <div class="product-icon">${product.icon}</div>
          <div class="product-info">
            <div class="product-name">${product.name}</div>
            <div class="product-price">${product.formattedPrice}</div>
            <div class="product-desc">${product.description}</div>
            <form action="${pageContext.request.contextPath}/cart" method="post">
              <input type="hidden" name="action" value="add">
              <input type="hidden" name="productId" value="${product.id}">
              <button type="submit" class="add-btn">
                <i class="fas fa-cart-plus"></i> Add to Cart
              </button>
            </form>
          </div>
        </div>
      </c:forEach>
    </div>
  </div>

</div>
</body>
</html>
