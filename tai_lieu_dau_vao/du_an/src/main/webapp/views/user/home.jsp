<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Customer Home</title>
    <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5 text-center">
    <h2 class="text-primary mb-3">👤 Chào khách hàng: <span class="fw-bold">${account.username}</span></h2>
    <p>Vai trò: <strong>${account.role}</strong></p>
    <hr>
    <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary me-2">
        🏠 Về trang chủ
    </a>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
        🚪 Đăng xuất
    </a>
</div>
</body>
</html>
