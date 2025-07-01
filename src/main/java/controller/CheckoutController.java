package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.CartItem;
import model.Product;
import model.User;
import services.CartService;

@WebServlet(name = "CheckoutController", urlPatterns = { "/checkout" })
public class CheckoutController extends HttpServlet {
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

        request.getRequestDispatcher("WEB-INF/views/pages/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Xoá giỏ hàng sau khi thanh toán
        HttpSession session = request.getSession();
        session.removeAttribute("cart");

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Thanh toán thành công</title>");
            out.println("<script type='text/javascript'>");
            out.println("alert('Bạn đã mua hàng thành công!');");
            out.println("window.location.href = '" + request.getContextPath() + "/';");
            out.println("</script>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Thanh toán thành công</h1>");
            out.println("<p>Cảm ơn bạn đã mua hàng tại cửa hàng của chúng tôi!</p>");
            out.println("</body>");
            out.println("</html>");
        }
    }
}
