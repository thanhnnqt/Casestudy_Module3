<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Giới Thiệu | Cầm Đồ Nhanh</title>

    <!-- Bootstrap -->
    <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="<%= request.getContextPath() %>/fontawesome-free-7.1.0-web/css/all.min.css" />
    <!-- Google Font -->
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
        body { font-family: 'Inter', sans-serif; background-color: #f7f9fb; }
        .card:hover {
            transform: translateY(-3px);
            transition: all 0.3s ease;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15) !important;
        }
        .text-primary-color { color: #DC2626; }
    </style>
</head>
<body>

<!-- Gọi header -->
<jsp:include page="/views/includes/header.jsp" />

<!-- Hero -->
<section class="bg-dark py-5 text-white text-center">
    <div class="container">
        <h1 class="display-5 fw-bold mb-2">Về Chúng Tôi</h1>
        <p class="lead text-white-50">Trải qua quá trình hình thành và phát triển</p>
    </div>
</section>

<!-- Nội dung chính -->
<section class="py-5 bg-white">
    <div class="container max-w-4xl">
        <div class="text-center mb-5">
            <h2 class="fw-bold text-dark mb-3">Sứ Mệnh và Tầm Nhìn</h2>
            <div class="mx-auto bg-danger" style="height: 4px; width: 60px; border-radius: 50px;"></div>
        </div>

        <p class="mb-4 fs-6 text-gray-600 border-start border-danger border-4 ps-3 fst-italic">
            Cầm Đồ Nhanh được thành lập với tầm nhìn trở thành đối tác tài chính tin cậy hàng đầu...
        </p>

        <p class="mb-3 text-secondary lh-lg">
            Chúng tôi chuyên cung cấp dịch vụ cầm đồ uy tín, nhanh chóng và an toàn...
        </p>

        <p class="text-secondary lh-lg fw-semibold">
            Với đội ngũ chuyên gia tận tâm, chúng tôi cam kết đồng hành cùng khách hàng.
        </p>
    </div>
</section>

<!-- Our Values -->
<section class="py-5 bg-light">
    <div class="container">
        <h2 class="text-center fw-bold text-dark mb-4">Giá Trị Cốt Lõi Của Chúng Tôi</h2>
        <div class="row g-4 text-center">
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow border-0">
                    <i class="fa-solid fa-gem fs-3 text-danger mx-auto mb-3"></i>
                    <h3 class="h5 fw-bold text-dark mb-2">Liêm Chính & Minh Bạch</h3>
                    <p class="text-muted">Giao dịch minh bạch, không phí ẩn.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow border-0">
                    <i class="fa-solid fa-users fs-3 text-danger mx-auto mb-3"></i>
                    <h3 class="h5 fw-bold text-dark mb-2">Đồng Hành Khách Hàng</h3>
                    <p class="text-muted">Luôn lắng nghe và tư vấn giải pháp tài chính tốt nhất.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card p-4 h-100 shadow border-0">
                    <i class="fa-solid fa-bolt fs-3 text-danger mx-auto mb-3"></i>
                    <h3 class="h5 fw-bold text-dark mb-2">Tốc Độ & Hiệu Quả</h3>
                    <p class="text-muted">Ứng dụng công nghệ để giải ngân nhanh nhất.</p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- Gọi footer -->
<jsp:include page="/views/includes/footer.jsp" />

<!-- Bootstrap JS -->
<script src="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
