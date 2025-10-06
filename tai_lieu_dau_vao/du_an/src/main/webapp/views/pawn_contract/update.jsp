<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Cập nhật hợp đồng cầm đồ</title>
    <link href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<h2 class="mb-4 text-center">✏️ Cập nhật hợp đồng cầm đồ</h2>

<c:if test="${not empty error}">
    <div class="alert alert-danger">${error}</div>
</c:if>

<form action="${pageContext.request.contextPath}/pawn-contracts" method="post" class="row g-3">
    <input type="hidden" name="action" value="edit">
    <input type="hidden" name="id" value="${contract.pawnContractId}">

    <div class="col-md-4">
        <label for="customerId" class="form-label">Mã khách hàng</label>
        <input type="number" class="form-control" id="customerId" name="customerId"
               value="${contract.customerId}" required>
    </div>

    <div class="col-md-4">
        <label for="employeeId" class="form-label">Mã nhân viên</label>
        <input type="number" class="form-control" id="employeeId" name="employeeId"
               value="${contract.employeeId}" required>
    </div>

    <div class="col-md-4">
        <label for="productId" class="form-label">Mã sản phẩm</label>
        <input type="number" class="form-control" id="productId" name="productId"
               value="${contract.productId}" required>
    </div>

    <div class="col-md-4">
        <label for="pawnPrice" class="form-label">Giá trị cầm</label>
        <input type="number" step="0.01" class="form-control" id="pawnPrice" name="pawnPrice"
               value="${contract.pawnPrice}" required>
    </div>

    <div class="col-md-4">
        <label for="interestRate" class="form-label">Lãi suất (%)</label>
        <input type="number" step="0.01" class="form-control" id="interestRate" name="interestRate"
               value="${contract.interestRate}" required>
    </div>

    <div class="col-md-4">
        <label for="pawnDate" class="form-label">Ngày cầm</label>
        <input type="date" class="form-control" id="pawnDate" name="pawnDate"
               value="${contract.pawnDate}" required>
    </div>

    <div class="col-md-4">
        <label for="dueDate" class="form-label">Ngày đáo hạn</label>
        <input type="date" class="form-control" id="dueDate" name="dueDate"
               value="${contract.dueDate}" required>
    </div>

    <div class="col-md-4">
        <label for="returnDate" class="form-label">Ngày chuộc (nếu có)</label>
        <input type="date" class="form-control" id="returnDate" name="returnDate"
               value="${contract.returnDate}">
    </div>

    <div class="col-12 d-flex justify-content-between mt-4">
        <button type="submit" class="btn btn-success px-4">💾 Cập nhật</button>
        <a href="${pageContext.request.contextPath}/pawn-contracts" class="btn btn-secondary px-4">🔙 Quay lại</a>
    </div>
</form>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>

</body>
</html>
