<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cập nhật nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Cập nhật thông tin nhân viên</h2>
    <form action="/employees?action=edit" method="post">
        <input type="hidden" name="employeeId" value="${employee.employeeId}">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Họ và tên</label>
                <input type="text" name="fullName" class="form-control" value="${employee.fullName}" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Ngày sinh</label>
                <input type="date" name="dob" class="form-control" value="${employee.dob}" required>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Số điện thoại</label>
                <input type="text" name="phoneNumber" class="form-control" value="${employee.phoneNumber}" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" value="${employee.email}" required>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Lương</label>
                <input type="number" step="1000" name="salary" class="form-control" value="${employee.salary}" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Số CCCD</label>
                <input type="text" name="citizenNumber" class="form-control" value="${employee.citizenNumber}" required>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Cập nhật</button>
        <a href="/employees" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
</body>
</html>