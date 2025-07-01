package services;

import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.List;

import model.CartItem;
import model.Product;

public class CartService {

    // Lấy giỏ hàng từ session
    public List<CartItem> getCart(HttpSession session) {
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        if (cart == null) {
            cart = new ArrayList<>();
            session.setAttribute("cart", cart);
        }
        return cart;
    }

    // Thêm sản phẩm vào giỏ hàng và ghi lại vào session
    public void addToCart(HttpSession session, CartItem product, int quantity, int maxQuantity) {
        List<CartItem> cart = getCart(session);
        boolean found = false;
        // Kiểm tra xem sản phẩm đã có trong giỏ hàng chưa
        for (CartItem item : cart) {
            if (item.getId().equals(product.getId())) {
                int newQty = item.getQuantity() + quantity;
                if (newQty > maxQuantity) {
                    newQty = maxQuantity;
                }
                item.setQuantity(newQty);
                found = true;
                break;
            }
        }
        // Nếu sản phẩm chưa có trong giỏ hàng, thêm mới
        if (!found) {
            // Nếu số lượng thêm lớn hơn maxQuantity thì chỉ lấy maxQuantity
            int addQty = Math.min(product.getQuantity(), maxQuantity);
            product.setQuantity(addQty);
            cart.add(product);
        }
        session.setAttribute("cart", cart);
    }

    // Cập nhật số lượng sản phẩm trong giỏ hàng, không vượt quá maxQuantity
    public void updateCart(HttpSession session, String productId, int quantity, int maxQuantity) {
        List<CartItem> cart = getCart(session);
        for (CartItem item : cart) {
            if (item.getId().equals(productId)) {
                int newQty = Math.min(quantity, maxQuantity);
                item.setQuantity(newQty);
                break;
            }
        }
        session.setAttribute("cart", cart);
    }

    // Tính tiền tổng của giỏ hàng
    public double calculateTotal(HttpSession session, List<Product> products) {
        List<CartItem> cart = getCart(session);
        double total = 0.0;
        for (CartItem item : cart) {
            for (Product product : products) {
                if (product.getProductId().equals(item.getId())) {
                    total += product.getUnitPrice() * item.getQuantity();
                    break;
                }
            }
        }
        return total;
    }

    // Xoá sản phẩm khỏi giỏ hàng và ghi lại vào session
    public void removeFromCart(HttpSession session, String productId) {
        List<CartItem> cart = getCart(session);
        cart.removeIf(item -> item.getId().equals(productId));
        session.setAttribute("cart", cart);
    }

    // Xoá toàn bộ giỏ hàng
    public void clearCart(HttpSession session) {
        session.setAttribute("cart", new ArrayList<CartItem>());
    }
}
