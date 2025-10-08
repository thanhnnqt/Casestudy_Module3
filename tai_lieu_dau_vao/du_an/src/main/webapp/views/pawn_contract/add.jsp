<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

            <!-- Hiển thị flash message -->
            <% if (success != null) { %>
            <div class="alert alert-success"><%= success %></div>
            <% } %>
            <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <% if (existingCustomer != null) { %>
            <div class="alert alert-info">
                <strong>Khách hàng:</strong>
                <ul class="mb-0">
                    <li>Họ tên: <%= existingCustomer.getFullName() %></li>
                    <li>CCCD: <%= existingCustomer.getCitizenNumber() %></li>
                    <li>SĐT: <%= existingCustomer.getPhoneNumber() %></li>
                    <% if(existingCustomer.getEmail() != null) { %>
                    <li>Email: <%= existingCustomer.getEmail() %></li>
                    <% } %>
                </ul>
            </div>

            <!-- Form tạo hợp đồng -->
            <form action="${pageContext.request.contextPath}/pawn-contracts" method="post">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger">
                        <c:choose>
                            <c:when test="${not empty errors and errors.size() > 1}">
                                <strong>Vui lòng sửa các lỗi sau:</strong>
                                <ul>
                                    <c:forEach var="e" items="${errors}">
                                        <li>${e}</li>
                                    </c:forEach>
                                </ul>
                            </c:when>
                            <c:otherwise>
                                ${error}
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
                <input type="hidden" name="action" value="create">
                <input type="hidden" name="customerId" value="<%= existingCustomer.getCustomerId() %>">

                <h5 class="mb-3">Thông tin sản phẩm</h5>
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Tên sản phẩm *</label>
                        <input type="text" name="productName" class="form-control" required placeholder="Tên sản phẩm"
                               value="<%= request.getParameter("productName") != null ? request.getParameter("productName") : "" %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Giá trị sản phẩm *</label>
                        <input type="number" name="productValue" class="form-control" required step="0.01" placeholder="Giá trị sản phẩm"
                               value="<%= request.getParameter("productValue") != null ? request.getParameter("productValue") : "" %>">
                    </div>
                    <div class="col-12">
                        <label class="form-label">Mô tả sản phẩm</label>
                        <textarea name="description" class="form-control" rows="2" placeholder="Mô tả sản phẩm"><%= request.getParameter("description") != null ? request.getParameter("description") : "" %></textarea>
                    </div>
                </div>

                <h5 class="mb-3">Thông tin hợp đồng</h5>
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Nhân viên *</label>
                        <select name="employeeId" class="form-select" required>
                            <option value="" disabled>-- Chọn nhân viên --</option>
                            <% for (Employee emp : employees) { %>
                            <option value="<%= emp.getEmployeeId() %>"
                                    <%= request.getParameter("employeeId") != null && request.getParameter("employeeId").equals(String.valueOf(emp.getEmployeeId())) ? "selected" : "" %>>
                                <%= emp.getFullName() %>
                            </option>
                            <% } %>
                        </select>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số tiền khách muốn cầm *</label>
                        <input type="number" name="pawnAmount" class="form-control" required step="0.01" placeholder="Số tiền cầm"
                               value="<%= request.getParameter("pawnAmount") != null ? request.getParameter("pawnAmount") : "" %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Lãi suất (%)</label>
                        <input type="number" name="interestRate" class="form-control" step="0.01" placeholder="Lãi suất"
                               value="<%= request.getParameter("interestRate") != null ? request.getParameter("interestRate") : "" %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày cầm *</label>
                        <input type="date" name="pawnDate" class="form-control" required
                               value="<%= request.getParameter("pawnDate") != null ? request.getParameter("pawnDate") : "" %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày đến hạn *</label>
                        <input type="date" name="dueDate" class="form-control" required
                               value="<%= request.getParameter("dueDate") != null ? request.getParameter("dueDate") : "" %>">
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
    // Auto-hide alert sau 5 giây
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
