<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Header / Navigation Bar -->
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
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/views/contact.jsp">Liên hệ</a></li>
                <li class="nav-item">
                    <a class="btn btn-danger ms-2" href="<%= request.getContextPath() %>/views/login/login.jsp">Đăng nhập</a>
                </li>
            </ul>
        </div>
    </div>
</nav>
