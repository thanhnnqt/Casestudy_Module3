<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cầm Đồ Nhanh | Giải Pháp Tài Chính Tin Cậy</title>

    <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/fontawesome-free-7.1.0-web/css/all.min.css" />

    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f9fb;
        }
        .text-primary-color { color: #DC2626; }
        .bg-primary-color { background-color: #DC2626 !important; }

        .hero-bg {
            background-image: url('<%= request.getContextPath() %>/img/bg.png');
            background-size: cover;
            background-position: center;
            min-height: 500px;
            position: relative;
        }
        .hero-overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: rgba(0, 0, 0, 0.6);
        }
        .service-img {
            height: 180px;
            object-fit: cover;
            width: 100%;
            padding: 1rem;
        }
        .card:hover {
            transform: translateY(-3px);
            transition: all 0.3s ease;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
        }
        .hover-shadow:hover {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
        }
    </style>
</head>
<body class="antialiased">

<!-- Header / Navigation Bar -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-danger" href="<%= request.getContextPath() %>/index.jsp">CẦM ĐỒ NHANH</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link active fw-bold text-danger" href="<%= request.getContextPath() %>/index.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/products.jsp">Danh mục Sản phẩm</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/liquidation-products">Sản phẩm thanh lý</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/about.jsp">Giới thiệu</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/contact.jsp">Liên hệ</a></li>

                <!-- Nếu chưa đăng nhập -->
                <c:if test="${empty sessionScope.account}">
                    <li class="nav-item">
                        <a class="btn btn-danger ms-2" href="<%= request.getContextPath() %>/views/login/login.jsp">
                            <i class="fa-solid fa-right-to-bracket me-1"></i> Đăng nhập
                        </a>
                    </li>
                </c:if>

                <!-- Nếu đã đăng nhập -->
                <c:if test="${not empty sessionScope.account}">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle text-danger fw-bold" href="#" id="userMenu" role="button" data-bs-toggle="dropdown">
                            <i class="fa-solid fa-user me-1"></i> ${sessionScope.account.username}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <c:choose>
                                <c:when test="${sessionScope.account.role eq 'ADMIN'}">
                                    <li><a class="dropdown-item" href="<%= request.getContextPath() %>/admin-home">Trang Quản Trị</a></li>
                                </c:when>
                                <c:when test="${sessionScope.account.role eq 'STAFF'}">
                                    <li><a class="dropdown-item" href="<%= request.getContextPath() %>/employee-home">Trang Nhân Viên</a></li>
                                </c:when>
                                <c:when test="${sessionScope.account.role eq 'USER'}">
                                    <li><a class="dropdown-item" href="<%= request.getContextPath() %>/customer-home">Tài Khoản Của Tôi</a></li>
                                </c:when>
                            </c:choose>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item text-danger" href="<%= request.getContextPath() %>/logout">
                                <i class="fa-solid fa-right-from-bracket me-1"></i> Đăng xuất
                            </a></li>
                        </ul>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="hero-bg text-white d-flex align-items-center">
    <div class="hero-overlay"></div>
    <div class="container py-5 position-relative z-1">
        <div class="row">
            <div class="col-lg-7 col-md-9">
                <p class="fs-6 fw-bold text-warning text-uppercase mb-3">Giải Pháp Tài Chính Tức Thì</p>
                <h1 class="display-4 fw-bolder mb-3">
                    Vốn Nhanh, Thủ Tục <span class="text-danger">Siêu Đơn Giản</span>
                </h1>
                <p class="lead text-white-50 mb-4">
                    Chúng tôi cung cấp dịch vụ cầm cố tài sản đa dạng như ô tô, xe máy, trang sức và thiết bị điện tử với lãi suất cạnh tranh.
                </p>
                <div class="d-flex gap-3">
                    <a href="<%= request.getContextPath() %>/views/contact.jsp" class="btn btn-danger btn-lg shadow-lg fw-bold px-4">
                        <i class="fa-solid fa-handshake me-2"></i> Bắt đầu Tư Vấn Ngay
                    </a>

                    <!-- Nếu chưa đăng nhập, hiển thị nút đăng nhập -->
                    <c:if test="${empty sessionScope.account}">
                        <a href="<%= request.getContextPath() %>/views/login/login.jsp" class="btn btn-outline-light btn-lg shadow-lg fw-bold px-4">
                            <i class="fa-solid fa-right-to-bracket me-2"></i> Đăng Nhập
                        </a>
                    </c:if>

                    <!-- Nếu đã đăng nhập, hiển thị nút vào trang quản lý -->
                    <c:if test="${not empty sessionScope.account}">
                        <c:choose>
                            <c:when test="${sessionScope.account.role eq 'ADMIN'}">
                                <a href="<%= request.getContextPath() %>/admin-home" class="btn btn-outline-light btn-lg shadow-lg fw-bold px-4">
                                    <i class="fa-solid fa-gauge me-2"></i> Vào Trang Quản Trị
                                </a>
                            </c:when>
                            <c:when test="${sessionScope.account.role eq 'STAFF'}">
                                <a href="<%= request.getContextPath() %>/employee-home" class="btn btn-outline-light btn-lg shadow-lg fw-bold px-4">
                                    <i class="fa-solid fa-briefcase me-2"></i> Trang Nhân Viên
                                </a>
                            </c:when>
                            <c:when test="${sessionScope.account.role eq 'USER'}">
                                <a href="<%= request.getContextPath() %>/customer-home" class="btn btn-outline-light btn-lg shadow-lg fw-bold px-4">
                                    <i class="fa-solid fa-user me-2"></i> Trang Của Tôi
                                </a>
                            </c:when>
                        </c:choose>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- (Phần Services, CTA, Footer giữ nguyên) -->
<!-- ... -->
<link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js" rel="stylesheet">
</body>
</html>
