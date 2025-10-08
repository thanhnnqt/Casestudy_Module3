<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới Thiệu | Cầm Đồ Nhanh</title>

    <!-- Bootstrap & Font Awesome -->
    <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/fontawesome-free-7.1.0-web/css/all.min.css" />

    <!-- Custom Style -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600;700&display=swap');
        body {
            font-family: 'Inter', sans-serif;
            background-color: #f7f9fb;
        }
        .navbar-brand { letter-spacing: 0.5px; }
        .card:hover {
            transform: translateY(-4px);
            transition: all 0.3s ease;
            box-shadow: 0 0.5rem 1rem rgba(0,0,0,0.15) !important;
        }
        footer a:hover { color: #dc2626 !important; }
    </style>
</head>
<body>

<!-- Header -->
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
                <li class="nav-item"><a class="nav-link active fw-bold text-danger" href="<%= request.getContextPath() %>/views/about.jsp">Giới thiệu</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/contact.jsp">Liên hệ</a></li>
                <li class="nav-item"><a class="btn btn-danger ms-2" href="<%= request.getContextPath() %>/views/login/login.jsp">Đăng nhập</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- Hero Section -->
<section class="bg-dark py-5 text-white text-center">
    <div class="container">
        <h1 class="display-5 fw-bold mb-2">Về Chúng Tôi</h1>
        <p class="lead text-white-50">Hành trình xây dựng uy tín và niềm tin khách hàng</p>
    </div>
</section>

<!-- Giới thiệu -->
<section class="py-5 bg-white">
    <div class="container">
        <div class="text-center mb-5">
            <h2 class="fw-bold text-dark mb-3">Sứ Mệnh & Tầm Nhìn</h2>
            <div class="mx-auto bg-danger" style="height:4px;width:60px;border-radius:50px;"></div>
        </div>
        <p class="mb-4 fs-6 text-gray-600 border-start border-danger border-4 ps-3 fst-italic">
            Cầm Đồ Nhanh được thành lập với tầm nhìn trở thành đối tác tài chính tin cậy hàng đầu,
            cung cấp giải pháp vốn linh hoạt và đáng tin cậy cho mọi cá nhân và doanh nghiệp.
        </p>
        <p class="mb-3 text-secondary lh-lg">
            Chúng tôi chuyên cung cấp dịch vụ cầm đồ uy tín, nhanh chóng và an toàn cho đa dạng tài sản có giá trị,
            bao gồm ô tô, xe máy, thiết bị điện tử, và trang sức.
            Mục tiêu của chúng tôi không chỉ là giải quyết nhu cầu vốn tức thì mà còn xây dựng mối quan hệ lâu dài dựa trên sự tin tưởng và minh bạch.
        </p>
        <p class="text-secondary lh-lg fw-semibold">
            Với đội ngũ chuyên gia tận tâm, Cầm Đồ Nhanh cam kết đồng hành cùng khách hàng trong mọi tình huống tài chính,
            đảm bảo định giá chính xác và giải ngân nhanh chóng.
        </p>
    </div>
</section>

<!-- Giá trị cốt lõi -->
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center fw-bold text-dark mb-4">Giá Trị Cốt Lõi Của Chúng Tôi</h2>
        <div class="row g-4 text-center">
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow-sm border-0">
                    <i class="fa-solid fa-gem fs-3 text-danger mb-3"></i>
                    <h3 class="h5 fw-bold mb-2">Liêm Chính & Minh Bạch</h3>
                    <p class="text-muted">Mọi giao dịch đều minh bạch, không có chi phí ẩn. Lãi suất rõ ràng.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow-sm border-0">
                    <i class="fa-solid fa-users fs-3 text-danger mb-3"></i>
                    <h3 class="h5 fw-bold mb-2">Đồng Hành Khách Hàng</h3>
                    <p class="text-muted">Luôn lắng nghe và tư vấn giải pháp tài chính tốt nhất, đặt quyền lợi khách hàng là trọng tâm.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow-sm border-0">
                    <i class="fa-solid fa-bolt fs-3 text-danger mb-3"></i>
                    <h3 class="h5 fw-bold mb-2">Tốc Độ & Hiệu Quả</h3>
                    <p class="text-muted">Tối ưu hóa quy trình, giải ngân nhanh nhất và tiện lợi nhất.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Footer -->
<footer class="bg-dark text-white py-4 mt-5">
    <div class="container">
        <div class="row gy-4">
            <div class="col-md-3">
                <h5 class="text-danger fw-bold mb-3">Cầm Đồ Nhanh</h5>
                <p class="text-secondary small mb-1">123 Đường Tài Chính, Quận Tiện Lợi, TP. Thủ Đô</p>
                <p class="text-secondary small">Email: info@camdonhanh.vn</p>
                <div class="d-flex gap-3 mt-3">
                    <a href="#" class="text-secondary"><i class="fab fa-facebook-f"></i></a>
                    <a href="#" class="text-secondary"><i class="fab fa-instagram"></i></a>
                    <a href="#" class="text-secondary"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>
            <div class="col-md-3">
                <h5 class="fw-bold mb-3">Dịch vụ</h5>
                <ul class="list-unstyled small">
                    <li><a href="#" class="text-secondary d-block py-1">Cầm ô tô</a></li>
                    <li><a href="#" class="text-secondary d-block py-1">Cầm xe máy</a></li>
                    <li><a href="#" class="text-secondary d-block py-1">Cầm điện tử</a></li>
                    <li><a href="#" class="text-secondary d-block py-1">Thanh lý tài sản</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5 class="fw-bold mb-3">Thông tin</h5>
                <ul class="list-unstyled small">
                    <li><a href="#" class="text-secondary d-block py-1">Chính sách lãi suất</a></li>
                    <li><a href="#" class="text-secondary d-block py-1">Quy trình giao dịch</a></li>
                    <li><a href="#" class="text-secondary d-block py-1">FAQ</a></li>
                    <li><a href="#" class="text-secondary d-block py-1">Tuyển dụng</a></li>
                </ul>
            </div>
            <div class="col-md-3">
                <h5 class="fw-bold mb-3">Nhận tư vấn độc quyền</h5>
                <p class="text-secondary small mb-3">Đăng ký để nhận ưu đãi tốt nhất.</p>
                <form>
                    <div class="input-group mb-3">
                        <input type="email" class="form-control bg-secondary text-white border-0" placeholder="Email của bạn" required>
                    </div>
                    <button type="submit" class="btn btn-danger w-100 fw-bold">Đăng ký</button>
                </form>
            </div>
        </div>
        <div class="border-top border-secondary pt-3 mt-4 text-center small text-secondary">
            &copy; 2025 Cầm Đồ Nhanh. All rights reserved. | Vay có trách nhiệm.
        </div>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
