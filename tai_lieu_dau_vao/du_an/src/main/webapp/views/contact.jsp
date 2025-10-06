<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Liên Hệ | Cầm Đồ Nhanh</title>

    <!-- Tải Bootstrap CSS CỤC BỘ -->
    <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Tải Font Awesome CỤC BỘ -->
    <!-- Đảm bảo thư mục fontawesome-free-7.1.0-web/css và webfonts đã có trong dự án -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/fontawesome-free-7.1.0-web/css/all.min.css" />

    <!-- Custom Style (Đồng bộ font và hiệu ứng hover) -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f9fb;
        }
        /* Style cho khối Info Cards */
        .card:hover {
            transform: translateY(-3px);
            transition: all 0.3s ease;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
        }
    </style>
</head>
<body class="antialiased">

<!-- Header / Navigation Bar (Đồng bộ với các trang khác) -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold text-danger" href="<%= request.getContextPath() %>/index.jsp">CẦM ĐỒ NHANH</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/index.jsp">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/products.jsp">Sản phẩm</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/about.jsp">Giới thiệu</a></li>
                <li class="nav-item"><a class="nav-link active fw-bold text-danger" href="<%= request.getContextPath() %>/views/contact.jsp">Liên hệ</a></li>
                <li class="nav-item"><a class="btn btn-danger ms-2" href="<%= request.getContextPath() %>/views/login.jsp">Đăng nhập</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero/Breadcrumb Section for Contact Page -->
<section class="bg-dark py-5 text-white">
    <div class="container text-center">
        <h1 class="display-5 fw-bold mb-2">Liên Hệ Với Chúng Tôi</h1>
        <p class="lead text-white-50">Đội ngũ hỗ trợ chuyên nghiệp luôn sẵn sàng giải đáp thắc mắc của bạn.</p>
    </div>
</section>

<!-- Contact Info Cards Section -->
<section class="py-5 bg-white">
    <div class="container">
        <div class="row g-4 text-center">

            <!-- Card 1: Location -->
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow border-0">
                    <i class="fa-solid fa-map-pin fs-3 text-danger mx-auto mb-3"></i>
                    <h3 class="h5 fw-bold text-dark mb-2">Địa Chỉ Trụ Sở</h3>
                    <p class="text-muted text-sm mb-0">123 Đường Tài Chính, Quận Tiện Lợi, TP. Thủ Đô</p>
                </div>
            </div>

            <!-- Card 2: Phone -->
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow border-0">
                    <i class="fa-solid fa-phone-volume fs-3 text-danger mx-auto mb-3"></i>
                    <h3 class="h5 fw-bold text-dark mb-2">Đường Dây Nóng</h3>
                    <p class="text-muted text-sm mb-0 font-weight-bold">1800-CAMDO (Miễn phí)</p>
                    <p class="text-muted text-xs mb-0">(Hỗ trợ 24/7)</p>
                </div>
            </div>

            <!-- Card 3: Email -->
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow border-0">
                    <i class="fa-solid fa-envelope fs-3 text-danger mx-auto mb-3"></i>
                    <h3 class="h5 fw-bold text-dark mb-2">Hộp Thư Liên Hệ</h3>
                    <p class="text-muted text-sm mb-0">info@camdonhanh.vn</p>
                </div>
            </div>

        </div>
    </div>
</section>

<!-- Map Placeholder (Địa điểm) -->
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center fw-bold text-dark mb-4">Tìm Chúng Tôi Trên Bản Đồ</h2>
        <!-- Placeholder cho Google Maps. Sử dụng thẻ div với chiều cao cố định của Bootstrap -->
        <div class="embed-responsive embed-responsive-21by9 rounded-3 shadow-lg border border-white" style="height: 400px; overflow: hidden;">
            <div class="bg-secondary h-100 w-100 d-flex align-items-center justify-content-center text-white lead fw-bold">
                [Khu vực tích hợp Google Maps thực tế]
            </div>
        </div>
    </div>
</section>

<!-- Contact Form Section -->
<section class="py-5 bg-white">
    <div class="container max-w-4xl">
        <h2 class="text-center fw-bold text-dark mb-2">Gửi Yêu Cầu Tư Vấn</h2>
        <p class="text-center text-muted mb-4">Điền vào form dưới đây, chúng tôi sẽ liên hệ lại trong vòng 2 giờ làm việc.</p>

        <form id="contactForm" class="row g-4 bg-light p-4 rounded-3 shadow-sm mx-auto" style="max-width: 700px;">

            <!-- Full Name -->
            <div class="col-12">
                <label for="name" class="form-label fw-semibold">Họ tên đầy đủ</label>
                <input type="text" id="name" name="name" class="form-control form-control-lg" placeholder="Nguyễn Văn A" required>
            </div>

            <!-- Email & Phone Group -->
            <div class="col-md-6">
                <label for="email" class="form-label fw-semibold">Email</label>
                <input type="email" id="email" name="email" class="form-control form-control-lg" placeholder="vidu@email.com" required>
            </div>
            <div class="col-md-6">
                <label for="phone" class="form-label fw-semibold">Số điện thoại</label>
                <input type="tel" id="phone" name="phone" class="form-control form-control-lg" placeholder="09xx xxx xxx" required>
            </div>

            <!-- Message Content -->
            <div class="col-12">
                <label for="message" class="form-label fw-semibold">Nội dung/Loại tài sản cần cầm cố</label>
                <textarea id="message" name="message" rows="5" class="form-control form-control-lg" placeholder="Tôi cần cầm cố chiếc xe máy Honda X. Vui lòng báo giá ước tính." required></textarea>
            </div>

            <!-- Submit Button -->
            <div class="col-12 mt-4">
                <button type="submit" class="btn btn-danger btn-lg w-100 fw-bold shadow">
                    Gửi Yêu Cầu Tư Vấn
                </button>
            </div>
        </form>

    </div>
</section>

<!-- Footer (Đồng bộ với các trang khác) -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row">
            <!-- Logo & Contact -->
            <div class="col-md-3 mb-4">
                <h5 class="text-danger fw-bold mb-3">Cầm Đồ Nhanh</h5>
                <p class="text-secondary text-sm">Địa chỉ: 123 Đường Tài Chính, Quận Tiện Lợi, TP. Thủ Đô</p>
                <p class="text-secondary text-sm">Email: info@camdonhanh.vn</p>
                <div class="d-flex gap-3 mt-3">
                    <a href="#" class="text-secondary hover-danger"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-secondary hover-danger"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-secondary hover-danger"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <!-- Links 1 -->
            <div class="col-md-3 mb-4">
                <h5 class="fw-bold mb-3">Dịch vụ</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-secondary text-sm d-block py-1">Cầm ô tô</a></li>
                    <li><a href="#" class="text-secondary text-sm d-block py-1">Cầm xe máy</a></li>
                    <li><a href="#" class="text-secondary text-sm d-block py-1">Cầm điện tử</a></li>
                    <li><a href="#" class="text-secondary text-sm d-block py-1">Thanh lý tài sản</a></li>
                </ul>
            </div>
            <!-- Links 2 -->
            <div class="col-md-3 mb-4">
                <h5 class="fw-bold mb-3">Thông tin</h5>
                <ul class="list-unstyled">
                    <li><a href="#" class="text-secondary text-sm d-block py-1">Chính sách lãi suất</a></li>
                    <li><a href="#" class="text-secondary text-sm d-block py-1">Quy trình giao dịch</a></li>
                    <li><a href="#" class="text-secondary text-sm d-block py-1">Câu hỏi thường gặp (FAQ)</a></li>
                    <li><a href="#" class="text-secondary text-sm d-block py-1">Tuyển dụng</a></li>
                </ul>
            </div>
            <!-- Newsletter -->
            <div class="col-md-3 mb-4">
                <h5 class="fw-bold mb-3">Nhận tư vấn độc quyền</h5>
                <p class="text-secondary text-sm mb-3">Đăng ký để nhận ưu đãi tốt nhất.</p>
                <form>
                    <div class="input-group mb-3">
                        <input type="email" class="form-control bg-secondary text-white border-secondary" placeholder="Email của bạn" required>
                    </div>
                    <button type="submit" class="btn btn-danger w-100 fw-bold">
                        Đăng ký
                    </button>
                </form>
            </div>
        </div>
        <div class="border-top border-secondary pt-3 mt-3 text-center">
            <p class="text-secondary text-sm mb-0">&copy; 2025 Cầm Đồ Nhanh. All rights reserved. | Tuyên bố miễn trừ trách nhiệm: Vay có trách nhiệm.</p>
        </div>
    </div>
</footer>

<!-- Tải Bootstrap JS -->
<link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js" rel="stylesheet">
</body>
</html>
