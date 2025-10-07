<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Lịch sử giao dịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Thêm thư viện icon Font Awesome --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
            cursor: pointer;
        }
    </style>
</head>
<body>

<%-- Thêm Navbar cho đồng bộ --%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <a class="navbar-brand" href="/customer-home">Tiệm Cầm Đồ</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="navbar-text">
                        Xin chào, <strong>${history.customer.fullName}</strong>
                    </span>
                </li>
                <li class="nav-item ms-3">
                    <a href="/logout" class="btn btn-outline-danger">Đăng xuất</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
<a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">🏠 Quay về Home</a>
</div>
<div class="container my-5">
    <div class="text-center mb-5">
        <h1 class="display-5">Lịch Sử Giao Dịch</h1>
        <p class="lead text-muted">Theo dõi tất cả các hoạt động cầm đồ và mua hàng của bạn.</p>
    </div>

    <%-- LỊCH SỬ CẦM ĐỒ --%>
    <div class="card shadow-sm mb-5">
        <div class="card-header bg-dark text-white">
            <h4 class="mb-0"><i class="fas fa-hand-holding-dollar me-2"></i> Sản Phẩm Đã Cầm</h4>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty history.pawnedItems}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th class="text-center">Ngày cầm</th>
                                <th class="text-end">Số tiền cầm</th>
                                <th class="text-center">Ngày hết hạn</th>
                                <th class="text-center">Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${history.pawnedItems}">
                                <tr>
                                    <td>${item.productName}</td>
                                    <td class="text-center"><fmt:parseDate value="${item.pawnDate}" pattern="yyyy-MM-dd" var="pDate" /><fmt:formatDate value="${pDate}" pattern="dd/MM/yyyy" /></td>
                                    <td class="text-end fw-bold"><fmt:formatNumber value="${item.pawnPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                                    <td class="text-center"><fmt:parseDate value="${item.dueDate}" pattern="yyyy-MM-dd" var="dDate" /><fmt:formatDate value="${dDate}" pattern="dd/MM/yyyy" /></td>
                                    <td class="text-center"><span class="badge bg-secondary">${item.status}</span></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-muted text-center my-3">Bạn chưa có lịch sử cầm đồ nào.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <%-- LỊCH SỬ MUA HÀNG THANH LÝ --%>
    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white">
            <h4 class="mb-0"><i class="fas fa-shopping-cart me-2"></i> Sản Phẩm Đã Mua</h4>
        </div>
        <div class="card-body">
            <c:choose>
                <c:when test="${not empty history.purchasedItems}">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Tên sản phẩm</th>
                                <th class="text-center">Ngày mua</th>
                                <th class="text-end">Giá mua</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="item" items="${history.purchasedItems}">
                                <tr>
                                    <td>${item.productName}</td>
                                    <td class="text-center"><fmt:parseDate value="${item.purchaseDate}" pattern="yyyy-MM-dd" var="purDate" /><fmt:formatDate value="${purDate}" pattern="dd/MM/yyyy" /></td>
                                    <td class="text-end fw-bold"><fmt:formatNumber value="${item.purchasePrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <p class="text-muted text-center my-3">Bạn chưa có lịch sử mua hàng nào.</p>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>