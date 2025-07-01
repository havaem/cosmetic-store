<%-- Document : home Created on : Jun 2, 2025, 9:22:27â¯PM Author : Nguyen_Hoang_Ngoc_Chau --%>

    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>
                <%@ include file="../components/_head.jsp" %>

                    <body>
                        <%@ include file="../components/_header.jsp" %>

                            <div class="container">
                                <div id="carouselExampleAutoplaying" class="carousel slide mb-8"
                                    data-bs-ride="carousel">
                                    <div class="carousel-inner">
                                        <div class="carousel-item active">
                                            <img src="https://media.hcdn.vn/hsk/1748949008home4-66.jpg"
                                                class="d-block w-100" alt="...">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="https://media.hcdn.vn/hsk/1748860680homesanle026.jpg"
                                                class="d-block w-100" alt="...">
                                        </div>
                                        <div class="carousel-item">
                                            <img src="https://media.hcdn.vn/hsk/1748600918homekt2607d.jpg"
                                                class="d-block w-100" alt="...">
                                        </div>
                                    </div>
                                    <button class="carousel-control-prev" type="button"
                                        data-bs-target="#carouselExampleAutoplaying" data-bs-slide="prev">
                                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Previous</span>
                                    </button>
                                    <button class="carousel-control-next" type="button"
                                        data-bs-target="#carouselExampleAutoplaying" data-bs-slide="next">
                                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                        <span class="visually-hidden">Next</span>
                                    </button>
                                </div>

                                <div class="mb-4 page-title">
                                    <p class="text-center fs-5 mb-2 uppercase text-primary">Sản phẩm mới</p>
                                </div>
                                <div class="row">
                                    <c:forEach var="product" items="${listProduct}">
                                        <div class="col-md-3 col-sm-6 mb-4">
                                            <a class="product-card d-flex flex-column p-2" href="">
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

                                            </a>
                                        </div>

                                    </c:forEach>
                                    <a href="${pageContext.request.contextPath}/products"
                                        class="text-white text-decoration-none btn btn-primary w-100 mt-2">Xem tất
                                        cả</a>

                                </div>
                            </div>

                            <%@ include file="../components/_footer.jsp" %>

                    </body>

                </html>
