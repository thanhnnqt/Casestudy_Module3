<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Sản phẩm đang thanh lý</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Thêm thư viện icon Font Awesome --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .product-card {
            transition: transform .2s ease-in-out, box-shadow .2s ease-in-out;
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;
        }
    </style>
</head>
<body>

<%-- Navbar đồng bộ --%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/customer-home">Tiệm Cầm Đồ</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <c:if test="${not empty sessionScope.account}">
                    <li class="nav-item">
                        <span class="navbar-text">
                            Xin chào, <strong>${sessionScope.account.username}</strong>
                        </span>
                    </li>
                    <li class="nav-item ms-3">
                        <a href="/logout" class="btn btn-outline-danger">Đăng xuất</a>
                    </li>
                </c:if>
                <c:if test="${empty sessionScope.account}">
                    <li class="nav-item">
                        <a href="/login" class="btn btn-outline-light">Đăng nhập</a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="text-center mb-5">
        <h1 class="display-5 fw-bold">Sản Phẩm Đang Được Thanh Lý</h1>
        <p class="lead text-muted">Cơ hội sở hữu những sản phẩm chất lượng với giá tốt nhất!</p>
    </div>

    <c:choose>
        <%-- Khi có sản phẩm để hiển thị --%>
        <c:when test="${not empty productList}">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <c:forEach var="product" items="${productList}">
                    <div class="col">
                        <div class="card h-100 shadow-sm product-card">
                            <div class="card-header bg-dark text-white">
                                <h5 class="card-title mb-0 text-truncate">${product.productName}</h5>
                            </div>
                            <div class="card-body">
                                <p class="card-text text-muted">${product.description}</p>
                            </div>
                            <ul class="list-group list-group-flush">
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-tag me-2 text-danger"></i>Giá bán</span>
                                    <span class="fw-bold fs-5 text-danger">
                                        <fmt:formatNumber value="${product.liquidationPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                                    </span>
                                </li>
                                <li class="list-group-item d-flex justify-content-between align-items-center">
                                    <span><i class="fas fa-calendar-alt me-2 text-primary"></i>Ngày thanh lý</span>
                                    <span class="text-muted">
                                        <fmt:parseDate value="${product.liquidationDate}" pattern="yyyy-MM-dd" var="parsedDate" /><fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>

        <%-- Khi không có sản phẩm nào --%>
        <c:otherwise>
            <div class="text-center p-5 text-muted border rounded bg-light">
                <i class="fas fa-box-open fa-3x mb-3"></i>
                <h4 class="mb-0">Hiện chưa có sản phẩm nào được thanh lý.</h4>
                <p>Vui lòng quay lại sau.</p>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<%-- Footer --%>
<footer class="bg-dark text-white text-center py-3 mt-5">
    <div class="container">
        <p class="mb-0">&copy; 2025 Tiệm Cầm Đồ Nhanh. All rights reserved.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>