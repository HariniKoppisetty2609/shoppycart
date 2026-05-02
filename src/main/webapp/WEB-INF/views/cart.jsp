<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>ShoppyCart – Cart</title>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: system-ui, 'Segoe UI', -apple-system, BlinkMacSystemFont, sans-serif; }
    body { background: #f4f6fa; padding: 20px; }
    .app-container { max-width: 550px; margin: 0 auto; background: white; border-radius: 32px; box-shadow: 0 20px 35px rgba(0,0,0,0.1); overflow: hidden; }
    .shop-header { background: linear-gradient(135deg, #1e2a3a, #0f172a); color: white; padding: 18px 24px; display: flex; justify-content: space-between; align-items: center; }
    .logo { font-size: 1.7rem; font-weight: bold; display: flex; align-items: center; gap: 8px; text-decoration: none; color: white; }
    .logo i { font-size: 1.8rem; color: #facc15; }
    .cart-icon-btn { position: relative; cursor: pointer; background: rgba(255,255,255,0.15); padding: 8px 14px; border-radius: 40px; text-decoration: none; color: white; font-size: 1.5rem; transition: background 0.2s; }
    .cart-icon-btn:hover { background: rgba(255,255,255,0.25); }
    .cart-badge { position: absolute; top: -6px; right: -6px; background: #f97316; color: white; border-radius: 30px; padding: 2px 8px; font-size: 0.7rem; font-weight: bold; }
    .tabs { display: flex; background: white; border-bottom: 1px solid #e2e8f0; }
    .tab { flex: 1; text-align: center; padding: 14px 0; font-weight: 600; color: #64748b; cursor: pointer; text-decoration: none; font-size: 1rem; transition: color 0.2s, background 0.2s; }
    .tab:hover { background: #fff7ed; color: #f97316; }
    .tab.active { color: #f97316; border-bottom: 3px solid #f97316; background: #fff7ed; }
    .page-content { padding: 20px 18px; }
    .cart-item { background: #fef9f0; border-radius: 20px; padding: 12px 14px; margin-bottom: 12px; display: flex; justify-content: space-between; align-items: center; border-left: 5px solid #f97316; }
    .cart-item-left { display: flex; align-items: center; gap: 10px; }
    .cart-item-icon { font-size: 1.8rem; }
    .cart-item-name { font-weight: 600; font-size: 0.95rem; color: #1e293b; }
    .cart-item-price { color: #f97316; font-weight: 700; font-size: 0.9rem; }
    .cart-item-right { display: flex; align-items: center; gap: 10px; }
    .qty-controls { display: flex; align-items: center; gap: 8px; background: white; padding: 4px 10px; border-radius: 40px; border: 1px solid #e2e8f0; }
    .qty-btn { background: #f1f5f9; border: none; width: 28px; height: 28px; border-radius: 50%; font-weight: bold; font-size: 1.1rem; cursor: pointer; line-height: 1; transition: background 0.15s; }
    .qty-btn:hover { background: #e2e8f0; }
    .qty-value { min-width: 22px; text-align: center; font-weight: 600; font-size: 0.95rem; }
    .remove-btn { background: none; border: none; color: #ef4444; cursor: pointer; font-size: 1.1rem; padding: 4px 6px; border-radius: 8px; transition: background 0.15s; }
    .remove-btn:hover { background: #fee2e2; }
    .cart-summary { margin-top: 20px; background: #f8fafc; border-radius: 24px; padding: 16px 18px; border: 1px solid #e2e8f0; }
    .total-row { display: flex; justify-content: space-between; align-items: center; font-weight: 700; font-size: 1.1rem; margin-bottom: 14px; color: #1e293b; }
    .total-amount { color: #f97316; font-size: 1.25rem; }
    .checkout-btn { background: #22c55e; width: 100%; border: none; padding: 14px; border-radius: 40px; color: white; font-weight: bold; font-size: 1rem; display: flex; align-items: center; justify-content: center; gap: 10px; cursor: pointer; transition: background 0.2s; }
    .checkout-btn:hover { background: #16a34a; }
    .empty-cart { text-align: center; padding: 50px 20px; color: #94a3b8; }
    .empty-cart i { font-size: 3.5rem; margin-bottom: 12px; opacity: 0.4; display: block; }
    .empty-cart p { font-size: 1.1rem; margin-bottom: 16px; }
    .shop-link { background: #f97316; color: white; text-decoration: none; padding: 10px 24px; border-radius: 40px; font-weight: 600; font-size: 0.9rem; transition: background 0.2s; }
    .shop-link:hover { background: #ea580c; }
    .toast { position: fixed; bottom: 30px; left: 50%; transform: translateX(-50%); background: #1e293b; color: white; padding: 10px 22px; border-radius: 50px; font-size: 0.875rem; z-index: 999; white-space: nowrap; box-shadow: 0 8px 24px rgba(0,0,0,0.2); animation: slideUp 0.3s ease; }
    @keyframes slideUp { from { opacity: 0; bottom: 10px; } to { opacity: 1; bottom: 30px; } }
  </style>
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
