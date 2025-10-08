<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<c:import url="/views/layout/library.jsp"/>;
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Trang chủ Nhân viên</title>
    <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: "Segoe UI", Tahoma, sans-serif;
            background-color: #f8f9fa;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* HEADER */
        header {
            background: linear-gradient(135deg, #c62828, #c62828);
            color: white;
            padding: 20px 0;
            box-shadow: 0 3px 10px rgba(0,0,0,0.15);
        }
        header h1 {
            font-size: 1.8rem;
            font-weight: 600;
        }

        /* THÔNG TIN NHÂN VIÊN */
        .user-info {
            text-align: center;
            margin-top: 20px;
        }
        .user-info h3 {
            color: #c62828;
            font-weight: 700;
        }
        .user-info p {
            color: #6c757d;
            font-size: 1rem;
            margin-bottom: 0;
        }

        /* MAIN */
        main {
            flex: 1;
            padding: 40px 15px;
        }

        /* CARD MENU */
        .card-menu {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 40px;
            max-width: 900px;
            margin-left: auto;
            margin-right: auto;
        }
        .menu-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            padding: 25px 20px;
            text-align: center;
            transition: all 0.3s ease;
            text-decoration: none;
            color: inherit;
        }
        .menu-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 8px 20px rgba(0,0,0,0.12);
        }
        .menu-card i {
            font-size: 2.5rem;
            color: #198754;
            margin-bottom: 15px;
        }
        .menu-card h5 {
            font-weight: 600;
            color: #343a40;
        }
        .menu-card p {
            font-size: 0.95rem;
            color: #6c757d;
        }

        /* FOOTER */
        footer {
            background-color: #212529;
            color: #ccc;
            text-align: center;
            padding: 15px 0;
            font-size: 0.9rem;
            margin-top: auto;
        }

        .action-buttons {
            margin-top: 40px;
        }
        .btn {
            border-radius: 8px;
            transition: all 0.3s ease;
        }
        .btn:hover {
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<!-- Header -->
<header class="text-center">
    <div class="container">
        <h1>💼 Hệ thống Quản lý Cầm đồ</h1>
    </div>
</header>

<!-- Thông tin nhân viên -->
<section class="user-info">
    <div class="container">
        <h3>Xin chào, ${account.username} 👋</h3>
        <p>Vai trò: <strong>${account.role}</strong></p>
    </div>
</section>

<!-- Main content -->
<main>
    <div class="container">
        <div class="card-menu">

            <a href="${pageContext.request.contextPath}/customer-history" class="menu-card">
                <i class="bi bi-journal-text"></i>
                <h5>Xem lịch sử giao dịch</h5>
                <p>Xem, tìm kiếm lịch sử các sản phẩm bạn đã cầm và mua tại tiệm</p>
            </a>

            <a href="/update?id=${account.id}" class="menu-card">
                <i class="bi bi-journal-text"></i>
                <h5>Chỉnh sửa thông tin</h5>
                <p>Xem, chỉnh sửa thông tin cá nhân của khách hàng</p>
            </a>

            <a href="${pageContext.request.contextPath}/index.jsp" class="menu-card">
                <i class="bi bi-people"></i>
                <h5>Quay lại trang chủ</h5>
                <p>Quay lại trang chủ hệ thống</p>
            </a>

            <a href="${pageContext.request.contextPath}/logout" class="menu-card">
                <i class="bi bi-box-seam"></i>
                <h5>Đăng xuất</h5>
                <p>Đăng xuất khỏi hệ thống</p>
            </a>

        </div>
    </div>
</main>

<!-- Footer -->
<footer>
    <div class="container">
        <p>© 2025 Cầm Đồ Nhanh | Thiết kế bởi Nhóm Dự Án</p>
    </div>
</footer>

<!-- Bootstrap & Icons -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
<script src="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
