<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.du_an.entity.Customer" %>

<%
    Customer existingCustomer = (Customer) request.getAttribute("existingCustomer");
    String error = (String) request.getAttribute("error");
    String phoneOrCCCD = request.getParameter("phoneOrCCCD") != null ? request.getParameter("phoneOrCCCD") : "";
    String oldUsername = request.getParameter("username") != null ? request.getParameter("username") : "";
    String oldFullName = request.getParameter("fullName") != null ? request.getParameter("fullName") : "";
    String oldCitizenNumber = request.getParameter("citizenNumber") != null ? request.getParameter("citizenNumber") : "";
    String oldPhoneNumber = request.getParameter("phoneNumber") != null ? request.getParameter("phoneNumber") : "";
    String oldAddress = request.getParameter("address") != null ? request.getParameter("address") : "";
    String oldEmail = request.getParameter("email") != null ? request.getParameter("email") : "";
    String oldDob = request.getParameter("dob") != null ? request.getParameter("dob") : "";
%>

<link href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css" rel="stylesheet">

<div class="container mt-4">
    <div class="card shadow-sm border-0">
        <div class="card-header d-flex justify-content-between align-items-center"
             style="background: linear-gradient(90deg, #4facfe 0%, #00f2fe 100%); color: white;">
            <span>Kiểm tra và tạo khách hàng</span>
            <a href="${pageContext.request.contextPath}/pawn-contracts" class="btn btn-light btn-sm">Quay về</a>
        </div>
        <div class="card-body">

            <% if (error != null) { %>
            <div class="alert alert-danger"><%= error %></div>
            <% } %>

            <!-- Form kiểm tra khách hàng -->
            <form action="${pageContext.request.contextPath}/check-customer" method="get" class="mb-4">
                <input type="hidden" name="action" value="check">
                <div class="row g-3 align-items-end">
                    <div class="col-md-8">
                        <label class="form-label">Số điện thoại hoặc CCCD *</label>
                        <input type="text" name="phoneOrCCCD" class="form-control" required
                               value="<%= phoneOrCCCD %>" placeholder="Nhập số điện thoại hoặc CCCD">
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100">Kiểm tra khách hàng</button>
                    </div>
                </div>
            </form>

            <% if (phoneOrCCCD != null && !phoneOrCCCD.trim().isEmpty()) { %>
            <% if (existingCustomer != null) { %>
            <div class="alert alert-info">
                <strong>Khách hàng đã tồn tại:</strong>
                <ul class="mb-0">
                    <li>Họ tên: <%= existingCustomer.getFullName() %></li>
                    <li>CCCD: <%= existingCustomer.getCitizenNumber() %></li>
                    <li>SĐT: <%= existingCustomer.getPhoneNumber() %></li>
                    <% if (existingCustomer.getEmail() != null) { %>
                    <li>Email: <%= existingCustomer.getEmail() %></li>
                    <% } %>
                </ul>
                <a href="${pageContext.request.contextPath}/pawn-contracts?action=create&customerId=<%= existingCustomer.getCustomerId() %>"
                   class="btn btn-success mt-3">Tạo hợp đồng cho khách hàng này</a>
            </div>
            <% } else { %>
            <div class="alert alert-warning">
                Khách hàng chưa tồn tại. Vui lòng nhập thông tin để tạo khách hàng mới.
            </div>

            <!-- Form tạo khách hàng mới -->
            <form action="${pageContext.request.contextPath}/check-customer" method="post">
                <input type="hidden" name="action" value="create">
                <input type="hidden" name="phoneOrCCCD" value="<%= phoneOrCCCD %>">

                <h5 class="mb-3">Thông tin khách hàng mới</h5>
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label">Username *</label>
                        <input type="text" name="username" class="form-control" required placeholder="Username"
                               value="<%= oldUsername %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Password *</label>
                        <input type="password" name="password" class="form-control" required placeholder="Mật khẩu (ít nhất 6 ký tự)" minlength="6">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Họ tên *</label>
                        <input type="text" name="fullName" class="form-control" required placeholder="Họ tên"
                               value="<%= oldFullName %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">CCCD *</label>
                        <input type="text" name="citizenNumber" class="form-control" required placeholder="CCCD"
                               value="<%= oldCitizenNumber %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Số điện thoại *</label>
                        <input type="text" name="phoneNumber" class="form-control" required placeholder="Số điện thoại"
                               value="<%= phoneOrCCCD %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Địa chỉ</label>
                        <input type="text" name="address" class="form-control" placeholder="Địa chỉ"
                               value="<%= oldAddress %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" placeholder="Email"
                               value="<%= oldEmail %>">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Ngày sinh</label>
                        <input type="date" name="dob" class="form-control" value="<%= oldDob %>">
                    </div>
                </div>
                <button type="submit" class="btn btn-success w-100">Tạo khách hàng</button>
            </form>
            <% } %>
            <% } %>

        </div>
    </div>
</div>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>
<script>
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(event) {
            const requiredInputs = form.querySelectorAll('input[required], select[required]');
            let valid = true;
            requiredInputs.forEach(input => {
                if (!input.value.trim()) {
                    valid = false;
                    input.classList.add('is-invalid');
                } else {
                    input.classList.remove('is-invalid');
                }
            });
            if (!valid) {
                event.preventDefault();
                alert('Vui lòng điền đầy đủ các trường bắt buộc.');
            }
        });
    });
</script>
<script>
    document.querySelectorAll('form').forEach(form => {
        form.addEventListener('submit', function(event) {
            const requiredInputs = form.querySelectorAll('input[required]');
            let valid = true;
            requiredInputs.forEach(input => {
                if (!input.value.trim()) {
                    valid = false;
                    input.classList.add('is-invalid');
                    input.nextElementSibling?.remove();
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'invalid-feedback';
                    errorDiv.textContent = `${input.placeholder} không được để trống`;
                    input.parentNode.appendChild(errorDiv);
                } else {
                    input.classList.remove('is-invalid');
                }
                // Kiểm tra riêng cho password
                if (input.name === 'password' && input.value.trim().length < 6) {
                    valid = false;
                    input.classList.add('is-invalid');
                    input.nextElementSibling?.remove();
                    const errorDiv = document.createElement('div');
                    errorDiv.className = 'invalid-feedback';
                    errorDiv.textContent = 'Mật khẩu phải có ít nhất 6 ký tự';
                    input.parentNode.appendChild(errorDiv);
                }
            });
            if (!valid) {
                event.preventDefault();
                alert('Vui lòng điền đầy đủ và đúng các trường bắt buộc.');
            }
        });
    });
</script>

<style>
    .is-invalid {
        border-color: #dc3545;
    }
    .invalid-feedback {
        display: block;
        color: #dc3545;
        font-size: 0.875em;
    }
</style>