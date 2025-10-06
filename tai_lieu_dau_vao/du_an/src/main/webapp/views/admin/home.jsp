<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Admin Home</title>
    <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5 text-center">
    <h2 class="text-danger mb-3">👑 Chào mừng Admin: <span class="fw-bold">${account.username}</span></h2>
    <p>Vai trò của bạn: <strong>${account.role}</strong></p>
    <hr>


    <div>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary me-2">
            🏠 Về trang chủ
        </a>

        <%--  QUẢN LÝ NHÂN VIÊN --%>
        <a href="${pageContext.request.contextPath}/employees" class="btn btn-primary me-2">
            👨‍💼 Quản lý Nhân viên
        </a>

        <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
            🚪 Đăng xuất
        </a>
    </div>
</div>
</body>
</html>