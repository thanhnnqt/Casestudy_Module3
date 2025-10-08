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
<body class="container mt-5" style="max-width: 800px;">

<div class="card shadow-sm">
    <div class="card-header bg-success text-white">
        <h3 class="mb-0">✏️ Cập nhật hợp đồng cầm đồ</h3>
    </div>
    <div class="card-body">
        <c:if test="${not empty error}">
            <div class="alert alert-danger">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/pawn-contracts" method="post">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="${contract.pawnContractId}">
            <input type="hidden" name="productId" value="${contract.productId}">
            <input type="hidden" name="customerId" value="${contract.customerId}">

            <%-- Khách hàng (không cho sửa) --%>
            <div class="mb-3">
                <label class="form-label">Khách hàng</label>
                <input type="text" class="form-control" value="${contract.customerName}" disabled>
            </div>
            <hr>

            <h5 class="mb-3">Thông tin sản phẩm (Có thể sửa)</h5>
            <div class="row g-3 mb-3">
                <div class="col-md-12">
                    <label for="productName" class="form-label">Tên sản phẩm</label>
                    <input type="text" class="form-control" id="productName" name="productName" value="${product.productName}" required>
                </div>
                <div class="col-md-12">
                    <label for="description" class="form-label">Mô tả sản phẩm</label>
                    <textarea class="form-control" id="description" name="description" rows="2">${product.description}</textarea>
                </div>
                <div class="col-md-12">
                    <label for="productValue" class="form-label">Giá trị định giá (VNĐ)</label>
                    <input type="number" step="1000" class="form-control" id="productValue" name="productValue"
                           value="${product.pawnPrice}" required>
                </div>
            </div>
            <hr>

            <h5 class="mb-3">Thông tin hợp đồng</h5>
            <div class="row g-3">
                <div class="col-md-6">
                    <label for="employeeId" class="form-label">Nhân viên phụ trách</label>
                    <select class="form-select" id="employeeId" name="employeeId" required>
                        <option value="">-- Chọn nhân viên --</option>
                        <c:forEach var="emp" items="${employees}">
                            <option value="${emp.employeeId}" ${emp.employeeId == contract.employeeId ? 'selected' : ''}>
                                    ${emp.fullName}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="col-md-6">
                    <label for="pawnAmount" class="form-label">Số tiền cầm (VNĐ)</label>
                    <input type="number" step="1000" class="form-control" id="pawnAmount" name="pawnAmount"
                           value="${contract.pawnPrice}" required>
                </div>

                <div class="col-md-6">
                    <label for="interestRate" class="form-label">Lãi suất (%)</label>
                    <input type="number" step="0.01" class="form-control" id="interestRate" name="interestRate"
                           value="${contract.interestRate}" required>
                </div>

                <div class="col-md-6">
                    <label for="pawnDate" class="form-label">Ngày cầm</label>
                    <input type="date" class="form-control" id="pawnDate" name="pawnDate"
                           value="${contract.pawnDate}" required>
                </div>

                <div class="col-md-6">
                    <label for="dueDate" class="form-label">Ngày đáo hạn</label>
                    <input type="date" class="form-control" id="dueDate" name="dueDate"
                           value="${contract.dueDate}" required>
                </div>

                <div class="col-md-6">
                    <label for="returnDate" class="form-label">Ngày chuộc (nếu có)</label>
                    <input type="date" class="form-control" id="returnDate" name="returnDate"
                           value="${contract.returnDate}">
                </div>
            </div>

            <div class="col-12 d-flex justify-content-between mt-4">
                <button type="submit" class="btn btn-success px-4">💾 Lưu thay đổi</button>
                <a href="${pageContext.request.contextPath}/pawn-contracts" class="btn btn-secondary px-4">🔙 Quay lại</a>
            </div>
        </form>
    </div>
</div>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>

</body>
</html>