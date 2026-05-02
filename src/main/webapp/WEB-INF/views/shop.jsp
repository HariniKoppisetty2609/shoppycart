<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Cart – Shop</title>
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
    .product-grid { display: flex; flex-direction: column; gap: 16px; }
    .product-card { display: flex; gap: 14px; align-items: flex-start; background: white; border-radius: 24px; border: 1px solid #edf2f7; box-shadow: 0 4px 12px rgba(0,0,0,0.05); padding: 14px; transition: box-shadow 0.2s; }
    .product-card:hover { box-shadow: 0 8px 20px rgba(0,0,0,0.1); }
    .product-icon { width: 85px; height: 85px; min-width: 85px; background: #f1f5f9; border-radius: 20px; display: flex; align-items: center; justify-content: center; font-size: 2.8rem; }
    .product-info { flex: 1; }
    .product-name { font-weight: 700; font-size: 1.05rem; color: #1e293b; }
    .product-price { color: #f97316; font-weight: 800; margin: 5px 0; font-size: 1.15rem; }
    .product-desc { font-size: 0.75rem; color: #64748b; margin-bottom: 8px; }
    .add-btn { background: #f97316; border: none; padding: 6px 16px; border-radius: 40px; color: white; font-weight: 600; font-size: 0.8rem; cursor: pointer; transition: background 0.2s, transform 0.15s; display: inline-flex; align-items: center; gap: 6px; }
    .add-btn:hover { background: #ea580c; transform: scale(0.97); }
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
      <span>Cart</span>
    </div>
    <a href="${pageContext.request.contextPath}/cart" class="cart-icon-btn">
      <i class="fas fa-shopping-cart"></i>
      <span class="cart-badge">${cartCount}</span>
    </a>
  </div>

  <%-- Tabs --%>
  <div class="tabs">
    <a href="${pageContext.request.contextPath}/shop" class="tab active">🛍️ Shop</a>
    <a href="${pageContext.request.contextPath}/cart" class="tab">🛒 cart (${cartCount})</a>
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
