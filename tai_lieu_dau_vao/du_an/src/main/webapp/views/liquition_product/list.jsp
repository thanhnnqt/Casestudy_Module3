<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Sản phẩm đang thanh lý</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .product-card {
            transition: transform .2s;
            border: 1px solid #dee2e6;
            border-radius: .375rem;
        }
        .product-card:hover {
            transform: scale(1.03);
            box-shadow: 0 .5rem 1rem rgba(0,0,0,.15);
        }
    </style>
</head>
<body>
<div class="container mt-4">
    <div class="text-center mb-4">
        <h1>Sản phẩm đang được thanh lý</h1>
        <p class="lead">Cơ hội sở hữu những sản phẩm chất lượng với giá tốt nhất!</p>
    </div>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
        <c:forEach var="product" items="${productList}">
            <div class="col">
                <div class="card h-100 product-card">
                    <div class="card-body d-flex flex-column">
                        <h5 class="card-title">${product.productName}</h5>
                        <p class="card-text text-muted flex-grow-1">${product.description}</p>
                        <h4 class="text-danger">
                            <fmt:formatNumber value="${product.liquidationPrice}" type="currency" currencySymbol="₫" maxFractionDigits="0"/>
                        </h4>
                    </div>
                    <div class="card-footer">
                        <small class="text-muted">Ngày thanh lý:
                                <%-- SỬA Ở ĐÂY: Đặt 2 thẻ trên cùng 1 dòng --%>
                            <fmt:parseDate value="${product.liquidationDate}" pattern="yyyy-MM-dd" var="parsedDate" /><fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                        </small>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>