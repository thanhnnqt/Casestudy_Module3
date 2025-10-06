<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Lịch sử giao dịch</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1>Lịch sử giao dịch</h1>
            <h3>Khách hàng: <strong>${history.customer.fullName}</strong></h3>
        </div>
        <div>
            <a href="/customer-home" class="btn btn-secondary">Quay lại Trang chủ</a>
            <a href="/logout" class="btn btn-danger">Đăng xuất</a>
        </div>
    </div>

    <h4 class="mt-5">Sản phẩm đã cầm</h4>
    <c:choose>
        <c:when test="${not empty history.pawnedItems}">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Ngày cầm</th>
                    <th>Số tiền cầm</th>
                    <th>Ngày hết hạn</th>
                    <th>Trạng thái</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${history.pawnedItems}">
                    <tr>
                        <td>${item.productName}</td>
                        <td><fmt:parseDate value="${item.pawnDate}" pattern="yyyy-MM-dd" var="pDate" /><fmt:formatDate value="${pDate}" pattern="dd/MM/yyyy" /></td>
                        <td><fmt:formatNumber value="${item.pawnPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                        <td><fmt:parseDate value="${item.dueDate}" pattern="yyyy-MM-dd" var="dDate" /><fmt:formatDate value="${dDate}" pattern="dd/MM/yyyy" /></td>
                        <td>${item.status}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="text-muted">Chưa có lịch sử cầm đồ.</p>
        </c:otherwise>
    </c:choose>

    <h4 class="mt-5">Sản phẩm đã mua</h4>
    <c:choose>
        <c:when test="${not empty history.purchasedItems}">
            <table class="table table-striped table-bordered">
                <thead class="table-dark">
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>Ngày mua</th>
                    <th>Giá mua</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${history.purchasedItems}">
                    <tr>
                        <td>${item.productName}</td>
                        <td><fmt:parseDate value="${item.purchaseDate}" pattern="yyyy-MM-dd" var="purDate" /><fmt:formatDate value="${purDate}" pattern="dd/MM/yyyy" /></td>
                        <td><fmt:formatNumber value="${item.purchasePrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="text-muted">Chưa có lịch sử mua hàng.</p>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>