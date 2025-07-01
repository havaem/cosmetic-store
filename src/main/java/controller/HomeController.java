/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this
 * license Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this
 * template
 */
package controller;

import java.io.IOException;
import java.util.List;

import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Product;
import model.User;

/**
 *
 * @author VuNT13
 */
@WebServlet(name = "HomeController", urlPatterns = {""})
public class HomeController extends HttpServlet {
        private final ProductDao productDao = new ProductDao();

        @Override
        protected void doGet(HttpServletRequest request, HttpServletResponse response)
                        throws ServletException, IOException {
                request.setAttribute("currentPage", "home");

                List<Product> listProduct = productDao.selectAllProducts(8);
                request.setAttribute("listProduct", listProduct);
                // Get user from session
                HttpSession httpSession = request.getSession();
                User userLogin = (User) httpSession.getAttribute("userLogin");
                if (userLogin != null) {
                        System.err.println("User in session: " + userLogin.getName());
                        request.setAttribute("userLogin", userLogin);
                } else {
                        request.setAttribute("userLogin", null);
                }
                request.getRequestDispatcher("WEB-INF/views/pages/home.jsp").forward(request, response);
        }
}
