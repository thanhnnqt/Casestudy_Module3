<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Danh Mục Sản Phẩm | Cầm Đồ Nhanh</title>

  <!-- Tải Bootstrap CSS CỤC BỘ -->
  <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Tải Font Awesome CỤC BỘ -->
  <!-- Đảm bảo thư mục fontawesome-free-7.1.0-web/css và webfonts đã có trong dự án -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/fontawesome-free-7.1.0-web/css/all.min.css" />

  <!-- Custom Style (Đồng bộ font và padding cho ảnh sản phẩm) -->
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
    body {
      font-family: 'Inter', sans-serif;
      background-color: #f7f9fb;
    }
    .product-img {
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
        <li class="nav-item"><a class="nav-link active fw-bold text-danger" href="<%= request.getContextPath() %>/views/products.jsp">Sản phẩm</a></li>
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/about.jsp">Giới thiệu</a></li>
        <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/contact.jsp">Liên hệ</a></li>
        <li class="nav-item"><a class="btn btn-danger ms-2" href="<%= request.getContextPath() %>/views/login.jsp">Đăng nhập</a></li>
      </ul>
    </div>
  </div>
</nav>

<!-- Hero/Breadcrumb Section for Products Page -->
<section class="bg-dark py-5 text-white">
  <div class="container text-center">
    <h1 class="display-5 fw-bold mb-2">Danh Mục Tài Sản Cầm Cố</h1>
    <p class="lead text-white-50">Xem các loại tài sản mà chúng tôi chấp nhận định giá và cầm cố.</p>
  </div>
</section>

<!-- Products Section (Sử dụng cấu trúc card Bootstrap 5) -->
<section class="py-5 bg-white">
  <div class="container">
    <h2 class="text-center fw-bold text-dark mb-5">Giải pháp tài chính cho mọi tài sản</h2>

    <div class="row g-4">

      <!-- Card 1: Ô tô -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0">
          <img src="<%=request.getContextPath()%>/img/car.png" class="card-img-top product-img" alt="Cầm Ô tô">
          <div class="card-body text-center">
            <i class="fa-solid fa-car fs-4 text-danger mb-3"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Ô Tô</h5>
            <p class="card-text text-muted text-sm">Hỗ trợ các dòng xe con, xe tải nhẹ. Định giá tối đa.</p>
            <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-sm btn-outline-danger mt-2">
              Chi tiết <i class="fa-solid fa-chevron-right fa-sm align-middle ms-1"></i>
            </a>
          </div>
        </div>
      </div>

      <!-- Card 2: Xe máy -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0">
          <img src="<%=request.getContextPath()%>/img/bike.png" class="card-img-top product-img" alt="Cầm Xe máy">
          <div class="card-body text-center">
            <i class="fa-solid fa-motorcycle fs-4 text-danger mb-3"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Xe Máy</h5>
            <p class="card-text text-muted text-sm">Thủ tục nhanh, giữ giấy tờ hoặc giữ xe. Bảo quản an toàn.</p>
            <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-sm btn-outline-danger mt-2">
              Chi tiết <i class="fa-solid fa-chevron-right fa-sm align-middle ms-1"></i>
            </a>
          </div>
        </div>
      </div>

      <!-- Card 3: Điện thoại -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0">
          <img src="<%=request.getContextPath()%>/img/phone.png" class="card-img-top product-img" alt="Cầm Điện thoại">
          <div class="card-body text-center">
            <i class="fa-solid fa-mobile-alt fs-4 text-danger mb-3"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Điện Thoại</h5>
            <p class="card-text text-muted text-sm">Chấp nhận iPhone, Samsung và các thương hiệu lớn. Niêm phong tuyệt đối.</p>
            <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-sm btn-outline-danger mt-2">
              Chi tiết <i class="fa-solid fa-chevron-right fa-sm align-middle ms-1"></i>
            </a>
          </div>
        </div>
      </div>

      <!-- Card 4: Laptop -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0">
          <img src="<%=request.getContextPath()%>/img/laptop.png" class="card-img-top product-img" alt="Cầm Laptop">
          <div class="card-body text-center">
            <i class="fa-solid fa-laptop fs-4 text-danger mb-3"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Laptop & Tablet</h5>
            <p class="card-text text-muted text-sm">Laptop gaming, đồ họa, máy tính bảng. Định giá theo cấu hình.</p>
            <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-sm btn-outline-danger mt-2">
              Chi tiết <i class="fa-solid fa-chevron-right fa-sm align-middle ms-1"></i>
            </a>
          </div>
        </div>
      </div>

      <!-- Card 5: Trang sức -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0">
          <img src="<%=request.getContextPath()%>/img/gem.png" class="card-img-top product-img" alt="Cầm Trang sức">
          <div class="card-body text-center">
            <i class="fa-solid fa-gem fs-4 text-danger mb-3"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Trang Sức</h5>
            <p class="card-text text-muted text-sm">Vàng, kim cương, đá quý. Định giá chính xác bằng máy chuyên dụng.</p>
            <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-sm btn-outline-danger mt-2">
              Chi tiết <i class="fa-solid fa-chevron-right fa-sm align-middle ms-1"></i>
            </a>
          </div>
        </div>
      </div>

      <!-- Card 6: Đồng hồ -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0">
          <img src="<%=request.getContextPath()%>/img/watch.png" class="card-img-top product-img" alt="Cầm Đồng hồ" onerror="this.onerror=null; this.src='https://placehold.co/400x180/E5E7EB/A1A1AA?text=Watch+Placeholder';">
          <div class="card-body text-center">
            <i class="fa-solid fa-clock fs-4 text-danger mb-3"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Đồng Hồ</h5>
            <p class="card-text text-muted text-sm">Các thương hiệu cao cấp. Đảm bảo quy trình thẩm định nghiêm ngặt.</p>
            <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-sm btn-outline-danger mt-2">
              Chi tiết <i class="fa-solid fa-chevron-right fa-sm align-middle ms-1"></i>
            </a>
          </div>
        </div>
      </div>

      <!-- Card 7: Máy ảnh -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0">
          <img src="<%=request.getContextPath()%>/img/camera.png" class="card-img-top product-img" alt="Cầm Máy ảnh" onerror="this.onerror=null; this.src='https://placehold.co/400x180/E5E7EB/A1A1AA?text=Camera+Placeholder';">
          <div class="card-body text-center">
            <i class="fa-solid fa-camera fs-4 text-danger mb-3"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Máy Ảnh & Ống Kính</h5>
            <p class="card-text text-muted text-sm">Thiết bị quay chụp chuyên nghiệp. Định giá cao, bảo quản tiêu chuẩn.</p>
            <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-sm btn-outline-danger mt-2">
              Chi tiết <i class="fa-solid fa-chevron-right fa-sm align-middle ms-1"></i>
            </a>
          </div>
        </div>
      </div>

      <!-- Card 8: Bất động sản (Dịch vụ đặc biệt) -->
      <div class="col-sm-6 col-md-4 col-lg-3">
        <div class="card h-100 shadow-sm overflow-hidden border-0">
          <img src="<%=request.getContextPath()%>/img/house.png" class="card-img-top product-img" alt="Cầm Bất động sản" onerror="this.onerror=null; this.src='https://placehold.co/400x180/E5E7EB/A1A1AA?text=Real+Estate+Placeholder';">
          <div class="card-body text-center">
            <i class="fa-solid fa-city fs-4 text-danger mb-3"></i>
            <h5 class="card-title fw-bold text-dark mb-2">Bất Động Sản</h5>
            <p class="card-text text-muted text-sm">Dịch vụ cầm cố đặc biệt. Vui lòng liên hệ để được tư vấn riêng tư.</p>
            <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-sm btn-outline-danger mt-2">
              Chi tiết <i class="fa-solid fa-chevron-right fa-sm align-middle ms-1"></i>
            </a>
          </div>
        </div>
      </div>

    </div>

    <!-- CTA Footer for Product Page -->
    <div class="text-center mt-5 py-5 bg-light rounded-3 shadow-sm">
      <h3 class="h4 fw-bold text-dark mb-4">Tài sản của bạn không có trong danh sách?</h3>
      <p class="lead text-muted mb-4">Đừng lo lắng! Hãy liên hệ ngay với chúng tôi để được tư vấn về các loại tài sản có giá trị khác.</p>
      <a href="<%=request.getContextPath()%>/views/contact.jsp" class="btn btn-danger btn-lg shadow-lg">
        <i class="fa-solid fa-phone me-2"></i>
        Yêu cầu tư vấn Cụ thể
      </a>
    </div>

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
