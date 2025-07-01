package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Product;
import services.CartService;
import dao.ProductDao;

@WebServlet(name = "CartController", urlPatterns = { "/cart" })
public class CartController extends HttpServlet {
    private final CartService cartService = new CartService();
    private final ProductDao productDao = new ProductDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        List<CartItem> cart = cartService.getCart(session);

        List<Product> productList = new ArrayList<>();
        for (CartItem item : cart) {
            Product product = productDao.selectProduct(item.getId());
            if (product != null) {
                productList.add(product);
            } else {
                // xoá sản phẩm khỏi giỏ hàng nếu không tìm thấy
                cartService.removeFromCart(session, item.getId());
            }
        }

        request.setAttribute("cart", cart);
        request.setAttribute("productList", productList);
        request.setAttribute("totalPrice", cartService.calculateTotal(session, productList));
        request.getRequestDispatcher("WEB-INF/views/pages/cart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String action = request.getParameter("action");
        String productId = request.getParameter("productId");
        String quantity = request.getParameter("quantity");

        if (action != null) {
            Product product = null;
            if (productId != null) {
                product = productDao.selectProduct(productId);
            }
            if (productId != null && (action.equals("add") || action.equals("update"))) {
                if (product == null) {
                    response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
            }
            switch (action) {
                case "add" -> {
                    if (productId != null && product != null) {
                        int qty = (quantity == null || quantity.isEmpty()) ? 1 : Integer.parseInt(quantity);
                        int maxQty = product.getQuantityInStock();
                        if (qty > maxQty) {
                            qty = maxQty;
                        }
                        cartService.addToCart(session, new CartItem(productId, qty), qty, maxQty);
                        response.setStatus(HttpServletResponse.SC_OK);
                        return;
                    }
                }
                case "update" -> {
                    if (productId != null && quantity != null && product != null) {
                        System.out.println("Updating product: " + productId + " with quantity: " + quantity);
                        int qty = Integer.parseInt(quantity);
                        int maxQty = product.getQuantityInStock();
                        cartService.updateCart(session, productId, qty, maxQty);
                        response.setStatus(HttpServletResponse.SC_OK);
                    }
                }
                case "remove" -> {
                    if (productId != null) {
                        cartService.removeFromCart(session, productId);
                        response.setStatus(HttpServletResponse.SC_OK);
                    }
                }
                case "clear" -> {
                    cartService.clearCart(session);
                    response.setStatus(HttpServletResponse.SC_OK);
                }
                default -> {
                    // No action
                }
            }
        }
        doGet(request, response);

    }
}
