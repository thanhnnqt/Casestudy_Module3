<%--
  Created by IntelliJ IDEA.
  User: GAMING-PC
  Date: 30/09/2025
  Time: 9:53 PM
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Danh sách hợp đồng thanh lý</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="bootstrap520/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="datatables/css/dataTables.bootstrap5.min.css"/>
    <style>
        body {
            background-color: #f8f9fa;
        }

        footer {
            background-color: #212529;
            color: #fff;
            text-align: center;
            padding: 15px 0;
            margin-top: 40px;
        }

        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 2000;
        }
    </style>
</head>
<body>

<!-- 🔔 Toast thông báo thành công -->
<c:if test="${param.success == 'true'}">
    <div class="toast-container">
        <div id="successToast" class="toast align-items-center text-white bg-success border-0 show"
             role="alert" aria-live="assertive" aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    ✅ Tạo hợp đồng thanh lý thành công!
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto"
                        data-bs-dismiss="toast" aria-label="Close"></button>
            </div>
        </div>
    </div>
</c:if>

<script>
    // Ẩn toast sau 3 giây
    setTimeout(function () {
        const toastEl = document.getElementById('successToast');
        if (toastEl) {
            const toast = bootstrap.Toast.getOrCreateInstance(toastEl);
            toast.hide();
        }
    }, 3000);
</script>

<!-- 🔹 HEADER -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index.jsp">💼 Cầm Đồ Nhanh</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item"><a class="nav-link" href="/liquidation-contract">Hợp đồng</a></li>
                <li class="nav-item"><a class="nav-link" href="/product">Sản phẩm</a></li>
                <li class="nav-item"><a class="nav-link" href="/customer">Khách hàng</a></li>
                <li class="nav-item"><a class="nav-link" href="/logout">Đăng xuất</a></li>
            </ul>
        </div>
    </div>
</nav>

<!-- 🔔 Toast thông báo thành công -->
<c:if test="${not empty successMessage}">
    <div class="toast-container">
        <div class="toast align-items-center text-white bg-success border-0 show" role="alert" aria-live="assertive"
             aria-atomic="true">
            <div class="d-flex">
                <div class="toast-body">
                    ✅ ${successMessage}
                </div>
                <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast"
                        aria-label="Close"></button>
            </div>
        </div>
    </div>
</c:if>

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">📄 Danh sách hợp đồng thanh lý</h2>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">🏠 Quay về Home</a>
    </div>

    <!-- 🔍 Form tìm kiếm -->
    <form method="get" action="/liquidation-contract" class="row g-2 mb-3">
        <input type="hidden" name="action" value="search"/>
        <div class="col-md-4">
            <input type="text" name="full_name" class="form-control" placeholder="Nhập tên khách hàng"
                   value="${param.customerName}"/>
        </div>
        <div class="col-md-4">
            <input type="text" name="product_name" class="form-control" placeholder="Nhập tên sản phẩm"
                   value="${param.productName}"/>
        </div>
        <div class="col-md-2">
            <button type="submit" class="btn btn-primary w-100">Tìm kiếm</button>
        </div>
        <div class="col-md-2">
            <a href="/liquidation-contract?action=create" class="btn btn-success w-100">+ Tạo hợp đồng</a>
        </div>
    </form>

    <!-- 📋 Bảng danh sách -->
    <table id="tableProduct" class="table table-dark table-striped table-bordered text-center align-middle">
        <thead class="table-primary text-dark">
        <tr>
            <th>STT</th>
            <th>ID hợp đồng</th>
            <th>Khách hàng</th>
            <th>Ngày tạo</th>
            <th>Giá trị</th>
            <th>Sản phẩm</th>
            <th>Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="contract" items="${liquidationContracts}" varStatus="status">
            <tr>
                <td>${status.count}</td>
                <td>${contract.liquidationContractId}</td>
                <td>${contract.customerName}</td>
                <td>${contract.liquidationDate}</td>
                <td><fmt:formatNumber value="${contract.liquidationPrice}" type="currency" currencySymbol="₫"/></td>
                <td>${contract.productName}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/liquidation-contract?action=detail&id=${contract.liquidationContractId}"
                       class="btn btn-sm btn-info">Chi tiết</a>
                </td>
<%--                <td>--%>
<%--                    <a href="${pageContext.request.contextPath}/liquidation-contract?action=detail&id=${contract.liquidationContractId}"--%>
<%--                       class="btn btn-sm btn-info">Chi tiết</a>--%>
<%--                    <a href="${pageContext.request.contextPath}/liquidation-contract?action=print&id=${contract.liquidationContractId}"--%>
<%--                       class="btn btn-sm btn-success">In PDF</a>--%>
<%--                </td>--%>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<!-- 🔹 FOOTER -->
<footer>
    © 2025 Cầm Đồ Nhanh | Thiết kế bởi Nhóm Dự Án Java Web
</footer>

<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="bootstrap520/js/bootstrap.bundle.min.js"></script>
<script src="datatables/js/jquery.dataTables.min.js"></script>
<script src="datatables/js/dataTables.bootstrap5.min.js"></script>

<script>
    $(document).ready(function () {
        $('#tableProduct').DataTable({
            "dom": 'lrtip',
            "lengthChange": false,
            "pageLength": 5,
            "language": {
                "decimal": "",
                "emptyTable": "Không có dữ liệu trong bảng",
                "info": "Hiển thị _START_ đến _END_ trong tổng số _TOTAL_ mục",
                "infoEmpty": "Hiển thị 0 đến 0 của 0 mục",
                "infoFiltered": "(lọc từ tổng số _MAX_ mục)",
                "lengthMenu": "Hiển thị _MENU_ mục",
                "loadingRecords": "Đang tải...",
                "processing": "Đang xử lý...",
                "search": "Tìm kiếm:",
                "zeroRecords": "Không tìm thấy kết quả phù hợp",
                "paginate": {
                    "first": "Đầu",
                    "last": "Cuối",
                    "next": "›",
                    "previous": "‹"
                },
                "aria": {
                    "sortAscending": ": sắp xếp tăng dần",
                    "sortDescending": ": sắp xếp giảm dần"
                }
            }
        });

        // ✅ Tự động ẩn toast sau 3 giây
        setTimeout(() => {
            $('.toast').fadeOut('slow');
        }, 3000);
    });
</script>
</body>
</html>
