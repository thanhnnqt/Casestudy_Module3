<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <title>Title</title>
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
            width: 40%;
        }
        h2 {
            text-align: center;
            color: #333;
        }
    </style>
</head>
<body>
<c:import url="../layout/navbar.jsp"/>
<h1>Thêm mới</h1>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-10 form-container">
            <h2 class="mb-4">Thêm hợp đồng thanh lý mới</h2>
            <form action="/liquidation-contract?action=create" method="post">
                <div>
                    <label class="form-label">Ngày tạo hợp đồng</label>
                    <input name="liquidation_date" type="date" class="form-control" required>
                </div>
                <div>
                    <label class="form-label">Giá hợp đồng</label>
                    <input name="price" type="number" class="form-control" required>
                </div>
                <div>
                    <label class="form-label">Khách hàng</label>
                    <input name="customer_id" type="number" class="form-control" required>
                </div>
                <div>
                    <label class="form-label">Nhân viên</label>
                    <input name="employee_id" type="number" class="form-control" required>
                </div>
                <div>
                    <label class="form-label">Sản phẩm</label>
                    <input name="product_id" type="number" class="form-control" required>
                </div>
                <%--                <br>--%>
                <%--                <div>--%>
                <%--                    <select name="customer_id">--%>
                <%--                        <option>------------------------Chọn khách hàng------------------------</option>--%>
                <%--                        <c:forEach items="${liquidationContracts}" var="customer">--%>
                <%--                            <option value="${customer.customerId}">${customer.customerId}</option>--%>
                <%--                        </c:forEach>--%>
                <%--                    </select>--%>
                <%--                </div>--%>
                <%--                <br>--%>
                <%--                <div>--%>
                <%--                    <select name="employee_id">--%>
                <%--                        <option>------------------------Chọn nhân viên------------------------</option>--%>
                <%--                        <c:forEach items="${liquidationContracts}" var="employee">--%>
                <%--                            <option value="${employee.employeeId}">${employee.employeeId}</option>--%>
                <%--                        </c:forEach>--%>
                <%--                    </select>--%>
                <%--                </div>--%>
                <%--                <br>--%>
                <%--                <div>--%>
                <%--                    <select name="product_id">--%>
                <%--                        <option>------------------------Chọn sản phẩm------------------------</option>--%>
                <%--                        <c:forEach items="${liquidationContracts}" var="product">--%>
                <%--                            <option value="${product.productId}">${product.productId}</option>--%>
                <%--                        </c:forEach>--%>
                <%--                    </select>--%>
                <%--                </div>--%>
                <div class="col-12 text-center mt-4">
                    <button type="submit" class="btn btn-primary px-5">Thêm hợp đồng</button>
                </div>
            </form>
        </div>
    </div>
</div>
<!-- Bootstrap JS Bundle -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>