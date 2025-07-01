<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>
            <%@ include file="../components/_head.jsp" %>

                <body>
                    <%@ include file="../components/_header.jsp" %>
                        <div class="container">
                            <div class="register-card">
                                <h4 class="text-center mb-4">Tạo tài khoản mới</h4>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center">${error}</div>
                                </c:if>
                                <form action="${pageContext.request.contextPath}/register" method="post">
                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="email" class="form-control" required>
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Họ và tên</label>
                                        <input type="text" name="name" class="form-control" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Địa chỉ</label>
                                        <input type="text" name="address" class="form-control" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Số điện thoại</label>
                                        <input type="tel" name="phone" class="form-control" required
                                            pattern="[0-9]{10,11}">
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Mật khẩu</label>
                                        <input type="password" id="password" name="password" minlength="8" required
                                            class="form-control">
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
                                </form>

                                <p class="text-center mt-3 mb-0">
                                    Đã có tài khoản? <a href="${pageContext.request.contextPath}/login"
                                        class="text-decoration-none text-primary">Đăng
                                        nhập</a>
                                </p>
                            </div>
                        </div>
                        <%@ include file="../components/_footer.jsp" %>

                </body>

            </html>
