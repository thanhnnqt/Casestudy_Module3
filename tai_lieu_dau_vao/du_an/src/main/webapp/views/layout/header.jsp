<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
