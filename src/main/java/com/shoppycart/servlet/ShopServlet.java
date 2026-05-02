package com.shoppycart.servlet;

import com.shoppycart.model.CartItem;
import com.shoppycart.model.ProductCatalog;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.LinkedHashMap;
import java.util.Map;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        req.setAttribute("products", ProductCatalog.getAll());
        req.setAttribute("cartCount", getCartCount(req.getSession()));
        req.getRequestDispatcher("/WEB-INF/views/shop.jsp").forward(req, resp);
    }

    static int getCartCount(HttpSession session) {
        @SuppressWarnings("unchecked")
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) return 0;
        return cart.values().stream().mapToInt(CartItem::getQuantity).sum();
    }

    @SuppressWarnings("unchecked")
    static Map<Integer, CartItem> getOrCreateCart(HttpSession session) {
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new LinkedHashMap<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }
}
