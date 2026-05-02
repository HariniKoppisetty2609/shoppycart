<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ShoppyCart – Cart</title>
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
    <a href="${pageContext.request.contextPath}/shop" class="tab">🛍️ Shop</a>
    <a href="${pageContext.request.contextPath}/cart" class="tab active">🛒 Cart (${cartCount})</a>
  </div>

  <%-- Cart Content --%>
  <div class="page-content">

    <c:choose>
      <c:when test="${empty cartItems}">
        <div class="empty-cart">
          <i class="fas fa-shopping-bag"></i>
          <p>Your cart is empty</p>
          <a href="${pageContext.request.contextPath}/shop" class="shop-link">Browse Products</a>
        </div>
      </c:when>
      <c:otherwise>

        <%-- Cart Items --%>
        <c:forEach var="item" items="${cartItems}">
          <div class="cart-item">
            <div class="cart-item-left">
              <span class="cart-item-icon">${item.product.icon}</span>
              <div class="cart-item-details">
                <div class="cart-item-name">${item.product.name}</div>
                <div class="cart-item-price">${item.product.formattedPrice}</div>
              </div>
            </div>
            <div class="cart-item-right">
              <%-- Qty controls --%>
              <div class="qty-controls">
                <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline">
                  <input type="hidden" name="action" value="decrease">
                  <input type="hidden" name="productId" value="${item.product.id}">
                  <button type="submit" class="qty-btn">−</button>
                </form>
                <span class="qty-value">${item.quantity}</span>
                <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline">
                  <input type="hidden" name="action" value="increase">
                  <input type="hidden" name="productId" value="${item.product.id}">
                  <button type="submit" class="qty-btn">+</button>
                </form>
              </div>
              <%-- Remove --%>
              <form action="${pageContext.request.contextPath}/cart" method="post" style="display:inline">
                <input type="hidden" name="action" value="remove">
                <input type="hidden" name="productId" value="${item.product.id}">
                <button type="submit" class="remove-btn" title="Remove">
                  <i class="fas fa-trash-alt"></i>
                </button>
              </form>
            </div>
          </div>
        </c:forEach>

        <%-- Summary --%>
        <div class="cart-summary">
          <div class="total-row">
            <span>Total Amount</span>
            <span class="total-amount">${cartTotal}</span>
          </div>
          <form action="${pageContext.request.contextPath}/cart" method="post">
            <input type="hidden" name="action" value="checkout">
            <button type="submit" class="checkout-btn">
              <i class="fas fa-credit-card"></i> Proceed to Checkout
            </button>
          </form>
        </div>

      </c:otherwise>
    </c:choose>

  </div>

</div>
</body>
</html>
