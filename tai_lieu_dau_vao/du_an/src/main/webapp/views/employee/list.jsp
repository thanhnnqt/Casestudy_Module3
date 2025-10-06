<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Danh sách nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h2>Danh sách nhân viên</h2>
        <a href="/employees?action=add" class="btn btn-success">Thêm mới nhân viên</a>
    </div>


    <form action="/employees" method="get" class="row g-3 mb-3">
        <div class="col-auto">
            <input type="text" class="form-control" name="searchKeyword" placeholder="Nhập ID hoặc Tên nhân viên" value="${searchKeyword}">
        </div>
        <div class="col-auto">
            <button type="submit" class="btn btn-primary">Tìm kiếm</button>
            <a href="/employees" class="btn btn-secondary">Reset</a>
        </div>
    </form>


    <table class="table table-striped table-bordered">
        <thead class="table-dark">
        <tr>
            <th>ID</th>
            <th>Họ và Tên</th>
            <th>Tên đăng nhập</th>
            <th>Số điện thoại</th>
            <th>Email</th>
            <th>Ngày sinh</th>
            <th>Số CCCD</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="emp" items="${employeeList}">
            <tr>
                <td>${emp.employeeId}</td>
                <td>${emp.fullName}</td>
                <td>${emp.userName}</td>
                <td>${emp.phoneNumber}</td>
                <td>${emp.email}</td>
                <td>

                    <fmt:parseDate value="${emp.dob}" pattern="yyyy-MM-dd" var="parsedDate" />
                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                </td>
                <td>${emp.citizenNumber}</td>
                <td>
                    <a href="/employees?action=edit&id=${emp.employeeId}" class="btn btn-warning btn-sm">Sửa</a>
                    <a href="#" class="btn btn-danger btn-sm"
                       data-bs-toggle="modal"
                       data-bs-target="#confirmDeleteModal"
                       data-id="${emp.employeeId}">Xóa</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<div class="modal fade" id="confirmDeleteModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xác nhận xóa</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                Bạn có chắc chắn muốn xóa nhân viên này không?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                <a id="confirmDeleteBtn" href="#" class="btn btn-danger">Xóa</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener("DOMContentLoaded", function () {
        const deleteModal = document.getElementById("confirmDeleteModal");
        if (deleteModal) {
            const confirmDeleteBtn = document.getElementById("confirmDeleteBtn");
            deleteModal.addEventListener("show.bs.modal", function (event) {
                const button = event.relatedTarget;
                const employeeId = button.getAttribute("data-id");
                confirmDeleteBtn.href = "/employees?action=delete&id=" + employeeId;
            });
        }
    });
</script>
</body>
</html>