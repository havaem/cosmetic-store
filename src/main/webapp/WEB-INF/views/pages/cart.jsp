<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@page contentType="text/html" pageEncoding="UTF-8" %>
            <!DOCTYPE html>
            <html>
            <%@ include file="../components/_head.jsp" %>

                <body>
                    <%@ include file="../components/_header.jsp" %>

                        <div class="container">
                            <div class="mb-4 page-title">
                                <p class="text-center fs-5 mb-2 uppercase text-primary">Giỏ hàng của bạn</p>
                            </div>
                            <c:if test="${empty productList}">
                                <div class="text-center py-5 bg-white rounded shadow-sm">
                                    <img src="https://cdn-icons-png.flaticon.com/512/1170/1170678.png" alt="Empty Cart"
                                        width="100" class="mb-4">
                                    <h4>Giỏ hàng của bạn đang trống</h4>
                                    <p class="text-muted">Bạn chưa thêm sản phẩm nào vào giỏ hàng.</p>
                                    <a href="${pageContext.request.contextPath}/products"
                                        class="btn btn-primary mt-3">Tiếp tục mua sắm</a>
                                </div>
                            </c:if>

                            <c:if test="${not empty productList}">
                                <div class="cart-card">
                                    <c:forEach var="product" items="${productList}" varStatus="status">
                                        <c:set var="cartItem" value="${cart[status.index]}" />
                                        <div class="row align-items-center mb-4 border-bottom pb-3">
                                            <div class="col-md-2">
                                                <img src="${product.productImage}" alt="${product.productName}"
                                                    class="img-fluid rounded">
                                            </div>
                                            <div class="col-md-4">
                                                <h6 class="mb-1">${product.productName}</h6>
                                                <p class="small text-muted mb-0">
                                                    <fmt:formatNumber value="${product.unitPrice}" type="currency"
                                                        currencySymbol="₫" />
                                                </p>
                                            </div>
                                            <div class="col-md-2">
                                                <form method="POST" class="d-flex gap-3"
                                                    action="${pageContext.request.contextPath}/cart">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="productId" value="${product.productId}">
                                                    <input type="number" class="form-control"
                                                        value="${cartItem.quantity}" min="1"
                                                        max="${product.quantityInStock}" name="quantity" required>
                                                    <button type="submit"
                                                        class="btn btn-sm btn-outline-primary flex-shrink-0">Cập
                                                        nhật</button>
                                                </form>
                                            </div>
                                            <div class="col-md-2 text-end">
                                                <strong>
                                                    <fmt:formatNumber value="${cartItem.quantity * product.unitPrice}"
                                                        type="currency" currencySymbol="₫" />
                                                </strong>
                                            </div>
                                            <div class="col-md-2 text-end">
                                                <form method="POST" action="${pageContext.request.contextPath}/cart">
                                                    <input type="hidden" name="action" value="remove">
                                                    <input type="hidden" name="productId" value="${product.productId}">
                                                    <button type="submit"
                                                        class="btn btn-sm btn-outline-danger">Xóa</button>
                                                </form>
                                            </div>
                                        </div>
                                    </c:forEach>
                                    <!-- Tổng cộng -->
                                    <div class="text-end">
                                        <h5>Tạm tính: <strong>
                                                <fmt:formatNumber value="${totalPrice}" type="currency"
                                                    currencySymbol="₫" />
                                            </strong></h5>
                                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-primary mt-3">Tiến hành thanh toán</a>
                                    </div>
                                </div>
                            </c:if>


                        </div>

                        <%@ include file="../components/_footer.jsp" %>

                </body>

            </html>
