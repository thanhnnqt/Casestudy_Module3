<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>Danh sách hợp đồng cầm đồ</title>
  <link href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css" rel="stylesheet">
  <style>
    .btn-action { transition: transform 0.2s; }
    .btn-action:hover { transform: scale(1.1); }
    .badge-active { background: linear-gradient(90deg, #36D1DC, #5B86E5); color:white; }
    .badge-closed { background: linear-gradient(90deg, #43e97b, #38f9d7); color:white; }
    .badge-liquidated { background: linear-gradient(90deg, #f85032, #e73827); color:white; }
    .badge-liquidatable { background: linear-gradient(90deg, #FFD700, #FFA500); color: black; }
    .badge-liquidating { background: linear-gradient(90deg, #ff6a00, #ee0979); color:white; }
  </style>
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

    table.table {
      border-collapse: collapse !important;
    }

    /* ✅ Giữ bảng đều hàng, không giãn khi nhiều nút */
    .fixed-table td, .fixed-table th {
      padding: 10px 12px !important;
      vertical-align: middle !important;
      font-size: 15px !important;
      line-height: 1.3 !important;
      white-space: nowrap !important;
    }

    .fixed-table td button,
    .fixed-table td a {
      margin: 2px 0 !important;
    }

    .fixed-table tbody tr {
      height: 58px !important;
    }

    .btn-action {
      padding: 4px 8px !important;
      font-size: 13px !important;
      transition: transform 0.2s;
    }
    .btn-action:hover {
      transform: scale(1.1);
    }

    .badge-active { background: linear-gradient(90deg, #36D1DC, #5B86E5); color:white; }
    .badge-closed { background: linear-gradient(90deg, #43e97b, #38f9d7); color:white; }
    .badge-liquidated { background: linear-gradient(90deg, #f85032, #e73827); color:white; }
    .badge-liquidatable { background: linear-gradient(90deg, #FFD700, #FFA500); color: black; }
    .badge-liquidating { background: linear-gradient(90deg, #ff6a00, #ee0979); color:white; }
  </style>
</head>
<body class="container mt-5">
<!-- 🔹 HEADER -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/index.jsp">💼 Cầm Đồ Nhanh</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav ms-auto">
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/index.jsp">Trang chủ</a></li>
        <li class="nav-item"><a class="nav-link" href="/liquidation-contract">Hợp đồng</a></li>
        <%--                <li class="nav-item"><a class="nav-link" href="/product">Sản phẩm</a></li>--%>
        <%--                <li class="nav-item"><a class="nav-link" href="/customer">Khách hàng</a></li>--%>
        <li class="nav-item"><a class="nav-link" href="/logout">Đăng xuất</a></li>
      </ul>
    </div>
  </div>
</nav>

<%
  String success = (String) session.getAttribute("flashSuccess");
  String error = (String) session.getAttribute("flashError");
  session.removeAttribute("flashSuccess");
  session.removeAttribute("flashError");
%>

<div class="d-flex justify-content-between align-items-center mb-4">
  <h2 class="mb-0">📄 Danh sách hợp đồng cầm đồ</h2>
<%--  <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">🏠 Quay về Home</a>--%>
</div>

<% if (success != null) { %>
<div class="alert alert-success"><%= success %></div>
<% } %>
<% if (error != null) { %>
<div class="alert alert-danger"><%= error %></div>
<% } %>

<p class="text-muted">🔎 Số hợp đồng lấy được: <strong>${pawnContracts.size()}</strong></p>

<form action="${pageContext.request.contextPath}/pawn-contracts" method="get" class="row g-3 mb-4">
  <div class="col-md-3"><input type="text" name="customerName" value="${customerName}" class="form-control" placeholder="Tên khách hàng"></div>
  <div class="col-md-3"><input type="text" name="employeeName" value="${employeeName}" class="form-control" placeholder="Tên nhân viên"></div>
  <div class="col-md-2"><input type="text" name="productName" value="${productName}" class="form-control" placeholder="Tên sản phẩm"></div>
  <div class="col-md-2">
    <select name="status" class="form-select">
      <option value="">-- Chọn trạng thái --</option>
      <option value="DANG_CAM" ${status == 'DANG_CAM' ? 'selected' : ''}>Đang cầm</option>
      <option value="DA_CHUOC" ${status == 'DA_CHUOC' ? 'selected' : ''}>Đã chuộc</option>
      <option value="DA_THANH_LY" ${status == 'DA_THANH_LY' ? 'selected' : ''}>Đã thanh lý</option>
      <option value="THANH_LY" ${status == 'THANH_LY' ? 'selected' : ''}>Thanh lý</option>
      <option value="CO_THE_THANH_LY" ${status == 'CO_THE_THANH_LY' ? 'selected' : ''}>Có thể thanh lý</option>
    </select>
  </div>
  <div class="col-md-2"><button type="submit" class="btn btn-primary w-100">🔍 Tìm</button></div>
</form>

<div class="mb-3">
  <a href="${pageContext.request.contextPath}/check-customer" class="btn btn-success">➕ Thêm hợp đồng mới</a>
</div>

<c:choose>
  <c:when test="${not empty pawnContracts}">
    <table class="table table-bordered table-striped table-hover text-center fixed-table">

    <thead class="table-dark">
      <tr>
        <th>STT</th>
        <th>Khách hàng</th>
        <th>Nhân viên</th>
        <th>Sản phẩm</th>
        <th>Giá trị cầm</th>
        <th>Lãi suất</th>
        <th>Ngày cầm</th>
        <th>Ngày đáo hạn</th>
        <th>Ngày chuộc</th>
        <th>Trạng thái</th>
        <th>Thao tác</th>
      </tr>
      </thead>
      <tbody>
      <c:forEach var="c" items="${pawnContracts}" varStatus="loop">
        <tr>
            <%-- ✅ SỬA LẠI CÁCH TÍNH SỐ THỨ TỰ --%>
          <td>${loop.index + 1 + (currentPage - 1) * 5}</td>
          <td>${c.customerName}</td>
          <td>${c.employeeName}</td>
          <td>${c.productName}</td>
          <td><fmt:formatNumber value="${c.pawnPrice}" type="currency" currencySymbol="₫"/></td>
          <td>${c.interestRate != null ? c.interestRate : ''}%</td>

            <%-- GIỮ NGUYÊN CODE HIỂN THỊ NGÀY THÁNG CỦA BẠN --%>
          <td><c:if test="${not empty c.pawnDateFormatted}">${c.pawnDateFormatted}</c:if></td>
          <td><c:if test="${not empty c.dueDateFormatted}">${c.dueDateFormatted}</c:if></td>
          <td><c:if test="${not empty c.returnDateFormatted}">${c.returnDateFormatted}</c:if></td>

          <td>
            <c:choose>
              <c:when test="${c.status == 'DANG_CAM'}"><span class="badge badge-active">Đang cầm</span></c:when>
              <c:when test="${c.status == 'DA_CHUOC'}"><span class="badge badge-closed">Đã chuộc</span></c:when>
              <c:when test="${c.status == 'DA_THANH_LY'}"><span class="badge badge-liquidated">Đã thanh lý</span></c:when>
              <c:when test="${c.status == 'CO_THE_THANH_LY'}"><span class="badge badge-liquidatable">Có thể thanh lý</span></c:when>
              <c:when test="${c.status == 'THANH_LY'}"><span class="badge badge-liquidating">Thanh lý</span></c:when>
              <c:otherwise><span class="badge bg-secondary">${c.status}</span></c:otherwise>
            </c:choose>
          </td>
          <td>
            <c:if test="${c.status == 'DANG_CAM'}">
              <a href="${pageContext.request.contextPath}/pawn-contracts?action=edit&id=${c.pawnContractId}" class="btn btn-sm btn-warning btn-action mb-1">✏️ Sửa</a>
            </c:if>

              <%-- ✅ SỬA LẠI NÚT THANH LÝ ĐỂ GỌI MODAL --%>
            <c:if test="${c.status == 'CO_THE_THANH_LY'}">
              <button type="button" class="btn btn-sm btn-info btn-action mb-1"
                      data-bs-toggle="modal"
                      data-bs-target="#liquidationConfirmModal"
                      data-url="${pageContext.request.contextPath}/pawn-contracts?action=confirmLiquidation&id=${c.pawnContractId}">
                Thanh lý
              </button>
            </c:if>

            <a href="${pageContext.request.contextPath}/pawn-contracts?action=detail&id=${c.pawnContractId}" class="btn btn-sm btn-primary btn-action mb-1">🔍 Chi tiết</a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>

    <nav aria-label="Page navigation">
      <ul class="pagination justify-content-center">
        <c:forEach begin="1" end="${totalPages}" var="i">
          <li class="page-item ${i == currentPage ? 'active' : ''}">
            <a class="page-link" href="${pageContext.request.contextPath}/pawn-contracts?page=${i}&customerName=${customerName}&employeeName=${employeeName}&productName=${productName}&status=${status}">${i}</a>
          </li>
        </c:forEach>
      </ul>
    </nav>

  </c:when>
  <c:otherwise>
    <div class="text-center mt-5">
      <h4>📭 Chưa có hợp đồng cầm đồ nào!</h4>
      <a href="${pageContext.request.contextPath}/check-customer" class="btn btn-success mt-3">➕ Thêm hợp đồng mới</a>
    </div>
  </c:otherwise>
</c:choose>

<div class="modal fade" id="liquidationConfirmModal" tabindex="-1" aria-labelledby="modalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">⚠️ Xác nhận Thanh lý</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        Bạn có chắc chắn muốn thanh lý hợp đồng này không? Hành động này không thể hoàn tác.
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
        <a id="confirmLiquidationBtn" href="#" class="btn btn-danger">Xác nhận Thanh lý</a>
      </div>
    </div>
  </div>
</div>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>
<script>
  // Giữ nguyên script ẩn thông báo của bạn
  window.addEventListener('DOMContentLoaded', () => {
    const alerts = document.querySelectorAll('.alert');
    alerts.forEach(alert => {
      setTimeout(() => {
        alert.style.transition = 'opacity 0.5s, max-height 0.5s';
        alert.style.opacity = '0';
        alert.style.maxHeight = '0';
        setTimeout(() => alert.remove(), 500);
      }, 50000);
    });
  });

  // ✅ THÊM JAVASCRIPT ĐỂ XỬ LÝ MODAL
  const liquidationConfirmModal = document.getElementById('liquidationConfirmModal');
  if (liquidationConfirmModal) {
    liquidationConfirmModal.addEventListener('show.bs.modal', function (event) {
      const button = event.relatedTarget;
      const liquidationUrl = button.getAttribute('data-url');
      const confirmBtn = liquidationConfirmModal.querySelector('#confirmLiquidationBtn');
      confirmBtn.setAttribute('href', liquidationUrl);
    });
  }
</script>
<footer>
  © 2025 Cầm Đồ Nhanh | Thiết kế bởi Nhóm C0625G1
</footer>

<script>
  $(document).ready(function () {


    // ✅ Tự động ẩn toast sau 3 giây
    setTimeout(() => {
      $('.toast').fadeOut('slow');
    }, 3000);
  });
</script>
</body>
</html>