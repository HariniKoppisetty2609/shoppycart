package com.shoppycart.servlet;

import com.shoppycart.model.CartItem;
import com.shoppycart.model.Product;
import com.shoppycart.model.ProductCatalog;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;
import java.util.Optional;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = ShopServlet.getOrCreateCart(session);

        int total = cart.values().stream().mapToInt(CartItem::getSubtotal).sum();
        String formattedTotal = String.format("₹%,d", total);

        req.setAttribute("cartItems", cart.values());
        req.setAttribute("cartTotal", formattedTotal);
        req.setAttribute("cartCount", ShopServlet.getCartCount(session));
        req.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String action = req.getParameter("action");
        HttpSession session = req.getSession();
        Map<Integer, CartItem> cart = ShopServlet.getOrCreateCart(session);

        switch (action == null ? "" : action) {
            case "add": {
                int id = Integer.parseInt(req.getParameter("productId"));
                Optional<Product> product = ProductCatalog.findById(id);
                product.ifPresent(p -> {
                    if (cart.containsKey(id)) {
                        cart.get(id).setQuantity(cart.get(id).getQuantity() + 1);
                    } else {
                        cart.put(id, new CartItem(p, 1));
                    }
                });
                session.setAttribute("toast", "✓ Item added to cart");
                resp.sendRedirect(req.getContextPath() + "/shop");
                break;
            }
            case "increase": {
                int id = Integer.parseInt(req.getParameter("productId"));
                if (cart.containsKey(id)) {
                    cart.get(id).setQuantity(cart.get(id).getQuantity() + 1);
                }
                resp.sendRedirect(req.getContextPath() + "/cart");
                break;
            }
            case "decrease": {
                int id = Integer.parseInt(req.getParameter("productId"));
                if (cart.containsKey(id)) {
                    int newQty = cart.get(id).getQuantity() - 1;
                    if (newQty <= 0) {
                        cart.remove(id);
                    } else {
                        cart.get(id).setQuantity(newQty);
                    }
                }
                resp.sendRedirect(req.getContextPath() + "/cart");
                break;
            }
            case "remove": {
                int id = Integer.parseInt(req.getParameter("productId"));
                cart.remove(id);
                session.setAttribute("toast", "🗑️ Item removed");
                resp.sendRedirect(req.getContextPath() + "/cart");
                break;
            }
            case "checkout": {
                int total = cart.values().stream().mapToInt(CartItem::getSubtotal).sum();
                String msg = String.format("✅ Order placed! Total ₹%,d. Thanks for shopping!", total);
                cart.clear();
                session.setAttribute("toast", msg);
                resp.sendRedirect(req.getContextPath() + "/shop");
                break;
            }
            default:
                resp.sendRedirect(req.getContextPath() + "/shop");
        }
    }
}
