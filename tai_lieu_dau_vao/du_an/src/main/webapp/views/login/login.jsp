<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Đăng nhập hệ thống</title>
  <style>
    /* Reset mặc định */
    * {
      box-sizing: border-box;
      margin: 0;
      padding: 0;
    }

    body {
      font-family: "Segoe UI", Arial, sans-serif;
      background: #f3f6fa;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    /* HEADER */
    header {
      background: linear-gradient(90deg, #dc3545, #dc3545);
      color: white;
      padding: 16px 40px;
      text-align: center;
      font-size: 22px;
      font-weight: bold;
      letter-spacing: 0.5px;
      box-shadow: 0 2px 5px rgba(0,0,0,0.15);
    }

    /* Nút quay lại trang chủ */
    .home-btn {
      display: inline-block;
      background: #dc3545;
      color: #fff;
      padding: 10px 20px;
      border-radius: 50px;
      font-size: 15px;
      font-weight: 500;
      text-decoration: none;
      margin: 20px auto 0;
      transition: all 0.3s ease;
      box-shadow: 0 2px 5px rgba(0,0,0,0.15);
    }

    .home-btn:hover {
      background: #0056b3;
      transform: translateY(-2px);
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
    }

    .home-container {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 10px;
    }

    /* MAIN LOGIN FORM */
    main {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      padding: 40px 0;
    }

    .login-container {
      background: white;
      padding: 40px 35px;
      border-radius: 12px;
      box-shadow: 0 5px 15px rgba(0,0,0,0.1);
      width: 340px;
      transition: 0.3s;
    }

    .login-container:hover {
      transform: translateY(-3px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.15);
    }

    h2 {
      text-align: center;
      color: #333;
      margin-bottom: 20px;
    }

    input[type=text], input[type=password] {
      width: 100%;
      padding: 12px;
      margin: 8px 0 18px;
      border: 1px solid #ccc;
      border-radius: 8px;
      font-size: 15px;
    }

    input:focus {
      outline: none;
      border-color: #0099ff;
      box-shadow: 0 0 5px rgba(0,153,255,0.3);
    }

    button {
      width: 100%;
      padding: 12px;
      background: #007bff;
      color: white;
      border: none;
      border-radius: 8px;
      cursor: pointer;
      font-size: 16px;
      font-weight: bold;
      transition: 0.3s;
    }

    button:hover {
      background: #198754;
    }

    .error {
      color: red;
      text-align: center;
      margin-top: 10px;
      font-size: 14px;
    }

    /* FOOTER */
    footer {
      background: #dc3545;
      color: #fff;
      text-align: center;
      padding: 12px;
      font-size: 14px;
    }

    footer a {
      color: #66ccff;
      text-decoration: none;
    }

    footer a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>

<header>
  💼 CẦM ĐỒ NHANH — GIẢI PHÁP TÀI CHÍNH TIN CẬY
</header>

<div class="home-container">
  <a href="${pageContext.request.contextPath}/index.jsp" class="home-btn">🏠 Quay về Trang chủ</a>
</div>

<main>
  <div class="login-container">
    <h2>Đăng nhập hệ thống</h2>
    <form method="post" action="${pageContext.request.contextPath}/login">
      <input type="text" name="username" placeholder="Tên đăng nhập" required />
      <input type="password" name="password" placeholder="Mật khẩu" required />
      <button type="submit">Đăng nhập</button>
    </form>
    <div class="error">${error}</div>
  </div>
</main>

<footer>
  © 2025 Cầm Đồ Nhanh. Mọi quyền được bảo lưu. |
  <a href="#">Chính sách bảo mật</a> |
  <a href="#">Liên hệ hỗ trợ</a>
</footer>

</body>
</html>
