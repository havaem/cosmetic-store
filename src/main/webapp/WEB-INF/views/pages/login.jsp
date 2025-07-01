<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>
            <%@ include file="../components/_head.jsp" %>

                <body>
                    <%@ include file="../components/_header.jsp" %>

                        <div class="container">
                            <div class="login-card">
                                <h4 class="text-center mb-4">Đăng nhập tài khoản</h4>
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger text-center">${error}</div>
                                </c:if>
                                <c:if test="${not empty sessionScope.success}">
                                    <div class="alert alert-success text-center">${sessionScope.success}</div>
                                    <c:remove var="success" scope="session" />
                                </c:if>
                                <form action="${pageContext.request.contextPath}/login" method="post">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email hoặc Tên đăng nhập</label>
                                        <input type="text" class="form-control" id="email" name="username" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label">Mật khẩu</label>
                                        <input type="password" class="form-control" id="password" name="password"
                                            required>
                                    </div>

                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <div></div>
                                        <a href="/forgot-password" class="text-decoration-none small">Quên mật khẩu?</a>
                                    </div>

                                    <button type="submit" class="btn btn-primary w-100">Đăng nhập</button>
                                </form>

                                <p class="text-center mt-3 mb-0">
                                    Chưa có tài khoản? <a href="${pageContext.request.contextPath}/register"
                                        class="text-decoration-none text-primary">Đăng
                                        ký</a>
                                </p>
                            </div>
                        </div>

                        <%@ include file="../components/_footer.jsp" %>

                </body>

            </html>
