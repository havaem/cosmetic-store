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
                                <p class="text-center fs-5 mb-2 uppercase text-primary">Đơn hàng của bạn</p>
                            </div>
                            <form action="${pageContext.request.contextPath}/checkout" method="post">
                                <div class="row">
                                    <!-- Thông tin giao hàng -->
                                    <div class="col-md-6">
                                        <h5>Thông tin người nhận</h5>
                                        <div class="mb-3">
                                            <label class="form-label">Họ và tên</label>
                                            <input type="text" class="form-control" name="name" required
                                                value="${userLogin.name}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Số điện thoại</label>
                                            <input type="tel" class="form-control" name="phone" required
                                                value="${userLogin.phone}">
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Địa chỉ giao hàng</label>
                                            <input type="text" class="form-control" name="address" required
                                                value="${userLogin.address}">
                                        </div>
                                    </div>

                                    <!-- Phương thức thanh toán + đơn hàng -->
                                    <div class="col-md-6">
                                        <h5>Phương thức thanh toán</h5>
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="payment" id="cod"
                                                value="cod" checked>
                                            <label class="form-check-label" for="cod">Thanh toán khi nhận hàng
                                                (COD)</label>
                                        </div>
                                        <div class="form-check mb-4">
                                            <input class="form-check-input" type="radio" name="payment" id="bank"
                                                value="bank" disabled>
                                            <label class="form-check-label" for="bank">Chuyển khoản ngân hàng</label>
                                        </div>

                                        <h5>Tóm tắt đơn hàng</h5>
                                        <ul class="list-group mb-3">
                                            <c:forEach var="product" items="${productList}" varStatus="status">
                                                <c:set var="cartItem" value="${cart[status.index]}" />
                                                <li class="list-group-item d-flex justify-content-between">
                                                    <span>${product.productName} x ${cartItem.quantity}</span>
                                                    <strong>
                                                        <fmt:formatNumber
                                                            value="${product.unitPrice * cartItem.quantity}"
                                                            type="currency" currencySymbol="₫" />
                                                    </strong>
                                                </li>
                                            </c:forEach>


                                            <li class="list-group-item d-flex justify-content-between">
                                                <span>Phí vận chuyển</span>
                                                <span>30.000₫</span>
                                            </li>
                                            <li class="list-group-item d-flex justify-content-between">
                                                <strong>Tổng cộng</strong>
                                                <strong>
                                                    <fmt:formatNumber value="${totalPrice+30000}" type="currency"
                                                        currencySymbol="₫" />
                                                </strong>
                                            </li>
                                        </ul>

                                        <button type="submit" class="btn btn-primary w-100">Xác nhận đặt hàng</button>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <%@ include file="../components/_footer.jsp" %>

                </body>

            </html>
