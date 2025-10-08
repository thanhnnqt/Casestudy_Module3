<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Quản lý Nhân viên</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <%-- Thêm thư viện icon Font Awesome --%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .table-hover tbody tr:hover {
            background-color: #f1f1f1;
        }
        .action-icons a {
            margin: 0 5px;
        }
    </style>
</head>
<body>

<%-- Navbar đồng bộ --%>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm">
    <div class="container">
        <%-- THAY ĐỔI TẠI ĐÂY --%>
        <a class="navbar-brand fw-bold text-danger" href="${pageContext.request.contextPath}/index.jsp">CẦM ĐỒ NHANH</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <span class="navbar-text">
                        Xin chào, <strong>${sessionScope.account.username}</strong>
                    </span>
                </li>
                <li class="nav-item ms-3">
                    <a href="/logout" class="btn btn-outline-danger">Đăng xuất</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container my-5">
    <div class="card shadow-sm">
        <div class="card-header bg-dark text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0"><i class="fas fa-users me-2"></i> Danh sách Nhân viên</h4>
            <a href="/employees?action=add" class="btn btn-light">
                <i class="fas fa-plus-circle me-2"></i>Thêm mới
            </a>
        </div>
        <div class="card-body">
            <form action="/employees" method="get" class="row g-3 mb-4">
                <div class="col-md-5">
                    <input type="text" class="form-control" name="searchKeyword" placeholder="Nhập ID hoặc Tên nhân viên để tìm kiếm..." value="${searchKeyword}">
                </div>
                <div class="col-auto">
                    <button type="submit" class="btn btn-primary"><i class="fas fa-search me-1"></i> Tìm kiếm</button>
                    <a href="/employees" class="btn btn-secondary"><i class="fas fa-sync-alt me-1"></i> Reset</a>
                </div>
            </form>

            <c:choose>
                <c:when test="${not empty employeeList}">
                    <div class="table-responsive">
                        <table class="table table-hover table-bordered align-middle">
                            <thead class="table-light">
                            <tr>
                                <th class="text-center">ID</th>
                                <th>Họ và Tên</th>
                                <th>Tên đăng nhập</th>
                                <th>Số điện thoại</th>
                                <th>Email</th>
                                <th class="text-center">Ngày sinh</th>
                                <th>Số CCCD</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="emp" items="${employeeList}">
                                <tr>
                                    <td class="text-center">${emp.employeeId}</td>
                                    <td>${emp.fullName}</td>
                                    <td>${emp.userName}</td>
                                    <td>${emp.phoneNumber}</td>
                                    <td>${emp.email}</td>
                                    <td class="text-center">
                                        <fmt:parseDate value="${emp.dob}" pattern="yyyy-MM-dd" var="parsedDate" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                    </td>
                                    <td>${emp.citizenNumber}</td>
                                    <td class="text-center action-icons">
                                        <a href="/employees?action=edit&id=${emp.employeeId}" class="text-warning" title="Sửa">
                                            <i class="fas fa-edit"></i>
                                        </a>
                                        <a href="#" class="text-danger" title="Xóa"
                                           data-bs-toggle="modal"
                                           data-bs-target="#confirmDeleteModal"
                                           data-id="${emp.employeeId}">
                                            <i class="fas fa-trash"></i>
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="text-center p-4 text-muted border rounded">
                        <i class="fas fa-info-circle fa-2x mb-3"></i>
                        <p class="mb-0">Không tìm thấy nhân viên nào phù hợp.</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<%-- Modal xác nhận xóa --%>
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