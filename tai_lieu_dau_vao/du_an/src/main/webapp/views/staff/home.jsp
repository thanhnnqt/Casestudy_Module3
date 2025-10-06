<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Employee Home</title>
    <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
<div class="container py-5 text-center">
    <h2 class="text-success mb-3">💼 Chào nhân viên: <span class="fw-bold">${account.username}</span></h2>
    <p>Vai trò: <strong>${account.role}</strong></p>
    <hr>
    <div class="d-flex flex-column align-items-center gap-3 mt-4">
        <a href="${pageContext.request.contextPath}/pawn-contracts" class="btn btn-outline-primary w-50">
            📑 Quản lý hợp đồng cầm đồ
        </a>
        <a href="${pageContext.request.contextPath}/liquidation-contract" class="btn btn-outline-warning w-50">
            💰 Quản lý hợp đồng thanh lý
        </a>
        <div class="d-flex gap-3 mt-3">
            <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-outline-secondary">
                🏠 Về trang chủ
            </a>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                🚪 Đăng xuất
            </a>
        </div>
    </div>
</div>
</body>
</html>
