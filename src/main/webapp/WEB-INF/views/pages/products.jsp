<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>
            <%@ include file="../components/_head.jsp" %>

                <body>
                    <%@ include file="../components/_header.jsp" %>
                        <div class="container">
                            <div class="d-flex justify-content-end mb-3">
                                <form action="${pageContext.request.contextPath}/products" method="get" class="d-flex"
                                    style="max-width: 300px;">
                                    <input type="text" name="keyword" class="form-control me-2"
                                        placeholder="Tìm kiếm..." value="${param.keyword}">
                                    <button type="submit" class="btn btn-outline-primary">Tìm</button>
                                </form>
                            </div>

                            <div class="row">
                                <c:forEach var="product" items="${listProduct}">
                                    <div class="col-md-3 col-sm-6 mb-4">
                                        <div class="product-card d-flex flex-column p-2">
                                            <img src="${product.productImage}" class="img-fluid user-select-none"
                                                alt="${product.productName}">

                                            <div class="product-data p-2 mt-auto">
                                                <p>${product.productName}</p>
                                                <div class="d-flex justify-content-between">
                                                    <span class="text-danger fw-bold mb-0">
                                                        ₫
                                                        <fmt:formatNumber value="${product.unitPrice}" type="number"
                                                            minFractionDigits="0" maxFractionDigits="2" />
                                                    </span>
                                                    <span>
                                                        Còn lại <span
                                                            class="font-medium">${product.quantityInStock}</span>
                                                    </span>
                                                </div>
                                            </div>
                                            <div class="product-card-buy">
                                                <button class="btn btn-primary w-100 btn-add-to-cart"
                                                    data-product-id="${product.productId}">
                                                    Thêm vào giỏ hàng
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                </c:forEach>
                            </div>
                        </div>
                        <%@ include file="../components/_footer.jsp" %>
                            <script>
                                document.addEventListener('DOMContentLoaded', function () {
                                    document.querySelectorAll('.btn-add-to-cart').forEach(function (btn) {
                                        btn.addEventListener('click', function (e) {
                                            e.preventDefault();
                                            const productId = btn.getAttribute('data-product-id');
                                            if (!productId) {
                                                alert('Sản phẩm không hợp lệ! ', productId);
                                                return;
                                            }
                                            console.log('Thêm sản phẩm vào giỏ hàng:', productId);
                                            fetch("<%=request.getContextPath()%>/cart", {
                                                method: "POST",
                                                headers: {
                                                    "Content-Type": "application/x-www-form-urlencoded"
                                                },
                                                body: "action=add&productId=" + encodeURIComponent(productId)
                                            })
                                                .then(res => {
                                                    if (res.ok) {
                                                        alert('Đã thêm vào giỏ hàng!');
                                                    } else {
                                                        alert('Có lỗi xảy ra!');
                                                    }
                                                });
                                        });
                                    });
                                });
                            </script>
                </body>

            </html>
