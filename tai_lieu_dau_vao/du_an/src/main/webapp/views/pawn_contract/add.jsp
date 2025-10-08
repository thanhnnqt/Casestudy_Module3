<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.du_an.entity.Customer" %>
<%@ page import="com.example.du_an.entity.Employee" %>

<%
    // Lấy flash message từ session, xóa luôn để chỉ hiển thị 1 lần
    String success = (String) session.getAttribute("flashSuccess");
    String error = (String) session.getAttribute("flashError");
    session.removeAttribute("flashSuccess");
    session.removeAttribute("flashError");

    Customer existingCustomer = (Customer) request.getAttribute("existingCustomer");
    List<Employee> employees = (List<Employee>) request.getAttribute("employees");
%>

<link href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-4">
    <div class="card shadow-sm border-0">
        <div class="card-header d-flex justify-content-between align-items-center"
             style="background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%); color: white;">
            <span>Tạo hợp đồng cầm đồ</span>
            <a href="${pageContext.request.contextPath}/pawn-contracts" class="btn btn-light btn-sm">Quay về</a>
        </div>
        <div class="card-body">

            <% if (success != null) { %>
            <div class="alert alert-success"><%= success %></div>
            <% } %>
            <c:if test="${not empty error}">
                <div class="alert alert-danger">${error}</div>
            </c:if>

            <% if (existingCustomer != null) { %>
            <div class="alert alert-info">
                <strong>Khách hàng:</strong>
                <ul class="mb-0">
                    <li>Họ tên: <%= existingCustomer.getFullName() %></li>
                    <li>CCCD: <%= existingCustomer.getCitizenNumber() %></li>
                    <li>SĐT: <%= existingCustomer.getPhoneNumber() %></li>
                </ul>
            </div>

            <%-- ✅ 1. Thêm enctype="multipart/form-data" --%>
            <form action="${pageContext.request.contextPath}/pawn-contracts" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="create">
                <input type="hidden" name="customerId" value="<%= existingCustomer.getCustomerId() %>">

                <h5 class="mb-3">Thông tin sản phẩm</h5>
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Tên sản phẩm *</label>
                        <input type="text" name="productName" class="form-control" required placeholder="Tên sản phẩm"
                               value="${not empty productName ? productName : ''}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Giá trị định giá *</label>
                        <input type="number" name="productValue" class="form-control" required step="1000" placeholder="Giá trị sản phẩm"
                               value="${not empty productValue ? productValue : ''}">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Mô tả sản phẩm</label>
                        <textarea name="description" class="form-control" rows="2" placeholder="Mô tả sản phẩm">${not empty description ? description : ''}</textarea>
                    </div>

                    <%-- ✅ 2. Thêm ô input cho file ảnh --%>
                    <div class="col-12">
                        <label for="productImage" class="form-label">Hình ảnh sản phẩm</label>
                        <input class="form-control" type="file" id="productImage" name="productImage" accept="image/*">
                    </div>
                </div>

                <h5 class="mb-3">Thông tin hợp đồng</h5>
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Nhân viên *</label>
                        <select name="employeeId" class="form-select" required>
                            <option value="" disabled selected>-- Chọn nhân viên --</option>
                            <c:forEach var="emp" items="${employees}">
                                <option value="${emp.employeeId}" ${emp.employeeId == employeeId ? 'selected' : ''}>
                                        ${emp.fullName}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số tiền khách muốn cầm *</label>
                        <input type="number" name="pawnAmount" class="form-control" required step="1000" placeholder="Số tiền cầm"
                               value="${not empty pawnAmount ? pawnAmount : ''}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Lãi suất (%) *</label>
                        <input type="number" name="interestRate" class="form-control" required step="0.01" placeholder="Lãi suất"
                               value="${not empty interestRate ? interestRate : ''}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày cầm *</label>
                        <input type="date" name="pawnDate" class="form-control" required
                               value="${not empty pawnDate ? pawnDate : ''}">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày đến hạn *</label>
                        <input type="date" name="dueDate" class="form-control" required
                               value="${not empty dueDate ? dueDate : ''}">
                    </div>
                </div>

                <button type="submit" class="btn btn-success w-100">Tạo hợp đồng</button>
            </form>
            <% } else { %>
            <div class="alert alert-warning">
                Vui lòng kiểm tra và tạo khách hàng trước khi tạo hợp đồng.
                <a href="${pageContext.request.contextPath}/check-customer" class="btn btn-primary mt-2">Kiểm tra khách hàng</a>
            </div>
            <% } %>
        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>
<script>
    // Giữ nguyên script của bạn
    window.addEventListener('DOMContentLoaded', () => {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            setTimeout(() => {
                alert.style.transition = 'opacity 0.5s, max-height 0.5s';
                alert.style.opacity = '0';
                alert.style.maxHeight = '0';
                setTimeout(() => alert.remove(), 500);
            }, 5000000);
        });
    });
</script>