<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Thêm hợp đồng thanh lý</title>
    <c:import url="../layout/library.jsp"/>
    <style>
        body {
            background-image: url('https://anviethouse.vn/wp-content/uploads/2021/06/Thiet-ke-shop-dien-thoai-1-5.jpg');
            background-size: cover;
            background-repeat: no-repeat;
            background-attachment: fixed;
            background-position: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .form-container {
            background-color: rgba(255, 255, 255, 0.95);
            border-radius: 12px;
            padding: 30px;
            margin-top: 50px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
            width: 50%;
        }
        h2 { text-align: center; color: #333; }
        .form-check-container {
            border: 1px solid #ddd;
            padding: 20px;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>
<c:import url="../layout/navbar.jsp"/>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10 form-container">
            <h2 class="mb-4">Thêm hợp đồng thanh lý mới</h2>
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">🏠 Quay về Home</a>
            <div class="form-check-container mb-4">
                <form action="/liquidation-contract" method="get">
                    <input type="hidden" name="action" value="checkCustomer">
                    <div class="d-flex align-items-end">
                        <div class="flex-grow-1 me-2">
                            <label class="form-label">Số điện thoại hoặc CCCD</label>
                            <input name="phoneOrCCCD" type="text" class="form-control" required
                                   value="${param.phoneOrCCCD != null ? param.phoneOrCCCD : ''}">
                        </div>
                        <button type="submit" class="btn btn-info">Kiểm tra</button>
                    </div>
                </form>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger mt-3">${error}</div>
            </c:if>

            <form action="/liquidation-contract?action=create" method="post">
                <input type="hidden" name="phoneOrCCCD" value="${param.phoneOrCCCD}">

                <c:if test="${not empty existingCustomer}">
                    <div class="mt-2">
                        <label class="form-label">Khách hàng đã tồn tại</label>
                        <input type="text" class="form-control" value="${existingCustomer.fullName}" readonly>
                        <input type="hidden" name="customerId" value="${existingCustomer.customerId}">
                    </div>
                </c:if>

                <c:if test="${empty existingCustomer}">
                    <div class="mt-2">
                        <label class="form-label">Họ tên</label>
                        <input name="fullName" type="text" class="form-control" required>
                    </div>
                    <div class="mt-2">
                        <label class="form-label">CCCD</label>
                        <input name="citizenNumber" type="text" class="form-control" required>
                    </div>
                    <div class="mt-2">
                        <label class="form-label">Số điện thoại</label>
                        <input name="phoneNumber" type="text" class="form-control" required>
                    </div>
                    <div class="mt-2">
                        <label class="form-label">Địa chỉ</label>
                        <input name="address" type="text" class="form-control">
                    </div>
                    <div class="mt-2">
                        <label class="form-label">Email</label>
                        <input name="email" type="email" class="form-control">
                    </div>
                    <div class="mt-2">
                        <label class="form-label">Ngày sinh</label>
                        <input name="dob" type="date" class="form-control">
                    </div>
                </c:if>

                <div class="mt-2">
                    <label class="form-label">Nhân viên</label>
                    <select name="employee_id" class="form-select" required>
                        <option value="">Chọn nhân viên</option>
                        <c:forEach var="employee" items="${employees}">
                            <option value="${employee.employeeId}">${employee.fullName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mt-2">
                    <label class="form-label">Sản phẩm</label>
                    <select name="product_id" class="form-select" required>
                        <option value="">Chọn sản phẩm</option>
                        <c:forEach var="product" items="${products}">
                            <option value="${product.productId}">${product.productName}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="mt-2">
                    <label class="form-label">Ngày tạo hợp đồng</label>
                    <input name="liquidation_date" type="date" class="form-control" required>
                </div>
                <div class="mt-2">
                    <label class="form-label">Giá hợp đồng</label>
                    <input name="price" type="number" class="form-control" required>
                </div>

                <div class="col-12 text-center mt-4">
                    <button type="submit" class="btn btn-primary px-5">Thêm hợp đồng</button>
                </div>
            </form>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>