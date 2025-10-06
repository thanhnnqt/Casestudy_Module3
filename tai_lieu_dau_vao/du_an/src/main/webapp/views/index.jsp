<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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

<!-- Header / Navigation Bar (Đồng bộ với các trang khác) -->
<nav class="navbar navbar-expand-lg navbar-light bg-white shadow-sm sticky-top">
  <div class="container">
    <a class="navbar-brand fw-bold text-danger" href="<%= request.getContextPath() %>/index.jsp">CẦM ĐỒ NHANH</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link active fw-bold text-danger" href="<%= request.getContextPath() %>/index.jsp">Trang chủ</a></li>
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/products.jsp">Sản phẩm</a></li>
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/about.jsp">Giới thiệu</a></li>
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/contact.jsp">Liên hệ</a></li>
        <li class="nav-item"><a class="btn btn-danger ms-2" href="<%= request.getContextPath() %>/views/login.jsp">Đăng nhập</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- Hero Section (Phần đầu trang) -->
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
        <a href="<%= request.getContextPath() %>/views/contact.jsp" class="btn btn-danger btn-lg shadow-lg fw-bold px-4">
          <i class="fa-solid fa-handshake me-2"></i>
          Bắt đầu Tư Vấn Ngay
        </a>
      </div>
    </div>
  </div>
</section>

<!-- Trust & Value Proposition (Lý lẽ về sự tin cậy) -->
<section class="py-5 bg-white border-bottom shadow-sm">
  <div class="container">
    <div class="row g-4 text-center">

      <div class="col-md-4">
        <div class="p-4 rounded border hover-shadow bg-light h-100">
          <i class="fa-solid fa-clock fs-3 text-danger mb-3"></i>
          <h3 class="h5 fw-bold text-dark mb-2">Giải Ngân Trong 30'</h3>
          <p class="text-muted text-sm mb-0">Thực hiện quy trình định giá và giải ngân vốn nhanh chóng ngay tại chỗ.</p>
        </div>
      </div>

      <div class="col-md-4">
        <div class="p-4 rounded border hover-shadow bg-light h-100">
          <i class="fa-solid fa-shield-halved fs-3 text-danger mb-3"></i>
          <h3 class="h5 fw-bold text-dark mb-2">Bảo Mật Tuyệt Đối</h3>
          <p class="text-muted text-sm mb-0">Tài sản được niêm phong, bảo quản 24/7. Bảo mật thông tin khách hàng là ưu tiên hàng đầu.</p>
        </div>
      </div>

      <div class="col-md-4">
        <div class="p-4 rounded border hover-shadow bg-light h-100">
          <i class="fa-solid fa-chart-line fs-3 text-danger mb-3"></i>
          <h3 class="h5 fw-bold text-dark mb-2">Định Giá Cao Nhất</h3>
          <p class="text-muted text-sm mb-0">Cam kết định giá tài sản theo sát giá thị trường để tối đa hóa quyền lợi khách hàng.</p>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- Services Section (Dịch vụ - Dùng cấu trúc card 4 cột) -->
<section class="py-5">
  <div class="container text-center">
    <h2 class="fw-bold text-dark mb-2">Danh Mục Tài Sản Thế Chấp Phổ Biến</h2>
    <p class="lead text-muted mb-5">Chúng tôi chấp nhận đa dạng tài sản có giá trị.</p>

    <div class="row g-4">
      <!-- Card 1: Car -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0 hover-shadow">
          <img src="<%= request.getContextPath() %>/img/car.png" alt="Cầm ô tô" class="card-img-top service-img">
          <div class="card-body">
            <i class="fa-solid fa-car fs-4 text-danger mb-2"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Cầm Ô Tô</h5>
            <p class="card-text text-muted text-sm mb-0">Hỗ trợ tất cả các dòng xe. Lãi suất ưu đãi, giữ xe hoặc giữ giấy tờ.</p>
          </div>
        </div>
      </div>

      <!-- Card 2: Motorbike -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0 hover-shadow">
          <img src="<%= request.getContextPath() %>/img/bike.png" alt="Cầm xe máy" class="card-img-top service-img">
          <div class="card-body">
            <i class="fa-solid fa-motorcycle fs-4 text-danger mb-2"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Cầm Xe Máy</h5>
            <p class="card-text text-muted text-sm mb-0">Thủ tục đơn giản, giải ngân nhanh. Hầm giữ xe an toàn.</p>
          </div>
        </div>
      </div>

      <!-- Card 3: Electronics -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0 hover-shadow">
          <img src="<%= request.getContextPath() %>/img/phone.png" alt="Cầm điện tử" class="card-img-top service-img">
          <div class="card-body">
            <i class="fa-solid fa-mobile-alt fs-4 text-danger mb-2"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Cầm Điện Tử</h5>
            <p class="card-text text-muted text-sm mb-0">Laptop, điện thoại, máy ảnh, smartwatch. Niêm phong chống tráo đổi 100%.</p>
          </div>
        </div>
      </div>

      <!-- Card 4: Jewelry -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0 hover-shadow">
          <img src="<%= request.getContextPath() %>/img/trangsuc.jpg" alt="Cầm trang sức" class="card-img-top service-img" onerror="this.onerror=null; this.src='<%=request.getContextPath()%>/img/gem.png';">
          <div class="card-body">
            <i class="fa-solid fa-gem fs-4 text-danger mb-2"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Cầm Trang Sức</h5>
            <p class="card-text text-muted text-sm mb-0">Vàng, bạc, kim cương. Định giá bằng máy móc chính xác cao, đảm bảo giá trị tối đa.</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<!-- CTA Banner (Khu vực kêu gọi hành động) -->
<section class="py-5 bg-danger text-white">
  <div class="container text-center">
    <h2 class="display-6 fw-bold mb-3">Bạn cần vốn khẩn cấp?</h2>
    <p class="lead text-white-50 mb-4 mx-auto" style="max-width: 700px;">
      Hãy để chúng tôi giúp bạn giải quyết các gánh nặng tài chính một cách kín đáo và chuyên nghiệp nhất.
    </p>
    <a href="<%= request.getContextPath() %>/views/contact.jsp" class="btn btn-light btn-lg text-danger fw-bold shadow-lg px-5">
      <i class="fa-solid fa-phone me-2"></i>
      Gọi ngay: 1800-CAMDO
    </a>
  </div>
</section>

<!-- Footer (Đồng bộ với các trang khác) -->
<footer class="bg-dark text-white py-4 mt-0">
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
