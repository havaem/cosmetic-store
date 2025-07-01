<%@page contentType="text/html" pageEncoding="UTF-8" %>

    <nav class="navbar navbar-expand-lg bg-white border-bottom shadow-sm mb-4">
        <div class="container">
            <!-- Logo -->
            <a class="navbar-brand fw-bold text-pink uppercase"
                href="${pageContext.request.contextPath}/">ChauBeauty</a>

            <!-- Toggle for mobile -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Menu -->
            <div class="collapse navbar-collapse" id="navbarMain">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link ${currentPage == 'home' ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/">Trang chủ</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link ${currentPage == 'products' ? 'active' : ''}"
                            href="${pageContext.request.contextPath}/products">Sản phẩm</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Khuyến mãi</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Liên hệ</a>
                    </li>
                </ul>

                <!-- Icons -->
                <div class="d-flex align-items-center">
                    <c:choose>
                        <c:when test="${not empty userLogin}">
                            <a class="btn me-2 btn-primary" href="${pageContext.request.contextPath}/cart">
                                <i class="bi bi-cart4"></i>
                            </a>

                            <span class="text-dark me-2">Xin chào, <strong>${userLogin.name}</strong></span>
                            <button class="btn btn-outline-danger ms-2" id="logoutBtn">Đăng
                                xuất</button>
                        </c:when>
                        <c:otherwise>
                            <a class="btn btn-primary" href="${pageContext.request.contextPath}/login">
                                Đăng nhập</a>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${not empty userLogin}">

                    </c:if>

                </div>
            </div>
        </div>
    </nav>
    <script>
        document.getElementById('logoutBtn')?.addEventListener('click', function (e) {
            e.preventDefault();
            fetch('<%=request.getContextPath()%>/logout')
                .then(() => location.reload());
        });
    </script>
