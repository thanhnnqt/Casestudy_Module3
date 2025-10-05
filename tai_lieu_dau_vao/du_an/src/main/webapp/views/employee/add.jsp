<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Thêm nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <h2>Thêm nhân viên mới</h2>
    <form action="/employees?action=add" method="post">
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Họ và tên</label>
                <input type="text" name="fullName" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Ngày sinh</label>
                <input type="date" name="dob" class="form-control" required>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Số điện thoại</label>
                <input type="text" name="phoneNumber" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Lương</label>
                <input type="number" step="1000" name="salary" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Số CCCD</label>
                <input type="text" name="citizenNumber" class="form-control" required>
            </div>
        </div>
        <hr>
        <h5>Thông tin tài khoản</h5>
        <div class="row">
            <div class="col-md-6 mb-3">
                <label class="form-label">Tên đăng nhập</label>
                <input type="text" name="userName" class="form-control" required>
            </div>
            <div class="col-md-6 mb-3">
                <label class="form-label">Mật khẩu</label>
                <input type="password" name="password" class="form-control" required>
            </div>
        </div>
        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="/employees" class="btn btn-secondary">Quay lại</a>
    </form>
</div>
</body>
</html>