<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="d-flex flex-column flex-shrink-0 p-3 bg-dark text-white" style="width: 220px; min-height: 100vh;">
    <a href="/" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
        <i class="bi bi-speedometer2 fs-4 me-2"></i>
        <span class="fs-5 fw-semibold">Dashboard</span>
    </a>
    <hr class="border-light">

    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="/customer?action=list" class="nav-link text-white d-flex align-items-center gap-2">
                <i class="bi bi-people-fill"></i>
                Khách hàng
            </a>
        </li>
        <li>
            <a href="/chart" class="nav-link text-white d-flex align-items-center gap-2">
                <i class="bi bi-bar-chart-line-fill"></i>
                Biểu đồ
            </a>
        </li>
    </ul>

    <hr class="border-light">
    <div class="dropdown">
            <strong>Admin</strong>
    </div>
</div>
