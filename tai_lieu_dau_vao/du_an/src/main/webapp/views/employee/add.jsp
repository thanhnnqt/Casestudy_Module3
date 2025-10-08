<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Thêm nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white">
                    <h3 class="mb-0">Thêm nhân viên mới</h3>
                </div>
                <div class="card-body">

                    <%-- KHU VỰC HIỂN THỊ LỖI --%>
                    <c:if test="${not empty errors}">
                        <div class="alert alert-danger">
                            <strong>Vui lòng sửa các lỗi sau:</strong>
                            <ul>
                                <c:forEach var="error" items="${errors}">
                                    <li>${error}</li>
                                </c:forEach>
                            </ul>
                        </div>
                    </c:if>

                    <form action="/employees?action=add" method="post">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Họ và tên</label>
                                <input type="text" name="fullName" class="form-control" value="${fullName_val}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Ngày sinh</label>
                                <input type="date" name="dob" class="form-control" value="${dob_val}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số điện thoại</label>
                                <input type="text" name="phoneNumber" class="form-control" value="${phoneNumber_val}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" name="email" class="form-control" value="${email_val}" required>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Lương</label>
                                <input type="number" step="1000" name="salary" class="form-control" value="${salary_val}" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Số CCCD</label>
                                <input type="text" name="citizenNumber" class="form-control" value="${citizenNumber_val}" required>
                            </div>
                        </div>
                        <hr>
                        <h5>Thông tin tài khoản</h5>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label">Tên đăng nhập</label>
                                <input type="text" name="userName" class="form-control" value="${username_val}" required>
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
            </div>
        </div>
    </div>
</div>
</body>
</html>