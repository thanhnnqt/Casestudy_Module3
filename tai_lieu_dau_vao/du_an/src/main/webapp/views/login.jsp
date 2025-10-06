<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Đăng Nhập | Cầm Đồ Nhanh</title>

  <!-- Tải Bootstrap CSS CỤC BỘ -->
  <link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/css/bootstrap.min.css" rel="stylesheet">

  <!-- Tải Font Awesome CỤC BỘ -->
  <!-- Đảm bảo thư mục fontawesome-free-7.1.0-web/css và webfonts đã có trong dự án -->
  <link rel="stylesheet" href="<%= request.getContextPath() %>/fontawesome-free-7.1.0-web/css/all.min.css" />

  <!-- Custom Style (Đồng bộ font, màu sắc và layout căn giữa) -->
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap');
    body {
      font-family: 'Inter', sans-serif;
      background-color: #f7f9fb;
    }
    /* Cấu trúc căn giữa màn hình cho Bootstrap */
    .login-wrapper {
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 1.5rem;
    }
    .text-primary-color { color: #DC2626; } /* Định nghĩa lại màu đỏ */
  </style>
</head>
<body class="antialiased">

<div class="login-wrapper">
  <div class="w-100 bg-white p-4 p-md-5 rounded-3 shadow-lg" style="max-width: 450px;">

    <div class="text-center mb-4">
      <h1 class="fs-2 fw-bolder text-dark mb-1">
        <span class="text-danger">CẦM ĐỒ NHANH</span>
      </h1>
      <h2 class="h4 fw-bold text-dark">Chào Mừng Trở Lại</h2>
      <p class="text-muted text-sm mt-1">Vui lòng đăng nhập để tiếp tục.</p>
    </div>

    <form id="loginForm" class="row g-4">

      <!-- Tên đăng nhập -->
      <div class="col-12">
        <label for="username" class="form-label fw-semibold">Tên đăng nhập / Email</label>
        <input type="text" id="username" name="username"
               class="form-control form-control-lg"
               placeholder="Nhập tên đăng nhập hoặc email" required>
      </div>

      <!-- Mật khẩu -->
      <div class="col-12">
        <label for="password" class="form-label fw-semibold">Mật khẩu</label>
        <input type="password" id="password" name="password"
               class="form-control form-control-lg"
               placeholder="Nhập mật khẩu của bạn" required>
      </div>

      <!-- Nút Đăng nhập -->
      <div class="col-12 pt-2">
        <button type="submit"
                class="btn btn-danger btn-lg w-100 fw-bold shadow">
          Đăng Nhập Hệ Thống
        </button>
      </div>

    </form>

    <!-- Nút Quay lại Trang chủ -->
    <div class="mt-4 text-center">
      <a href="<%= request.getContextPath() %>/index.jsp"
         class="text-decoration-none text-secondary fw-semibold">
        <i class="fa-solid fa-arrow-left me-2"></i>
        Quay lại Trang chủ
      </a>
    </div>

  </div>
</div>

<!-- Tải Bootstrap JS -->
<link href="<%= request.getContextPath() %>/bootstrap-5.3.8-dist/js/bootstrap.bundle.min.js" rel="stylesheet">
</body>
</html>
