package controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.AuthService;

/**
 *
 * @author South
 */
@WebServlet(urlPatterns = { "/register" })
public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.getRequestDispatcher("WEB-INF/views/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");

        // Validate dữ liệu
        if (email == null || email.isEmpty() ||
                name == null || name.isEmpty() ||
                address == null || address.isEmpty() ||
                phone == null || phone.isEmpty() ||
                password == null || password.isEmpty()) {
            request.setAttribute("error", "Vui lòng nhập đầy đủ thông tin.");
            doGet(request, response);
            return;
        }

        // Đăng ký tài khoản qua AuthService
        AuthService authService = new AuthService();
        boolean success = authService.register(name, phone, address, email, password);
        if (!success) {
            request.setAttribute("error", "Email đã tồn tại.");
            doGet(request, response);
            return;
        }
        // Sau khi đăng ký thành công, chuyển hướng sang trang login
        request.getSession().setAttribute("success", "Đăng ký tài khoản thành công.");
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
