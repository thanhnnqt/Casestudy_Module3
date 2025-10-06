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
    .btn-action {
      transition: transform 0.2s;
    }
    .btn-action:hover {
      transform: scale(1.1);
    }
    .badge-active { background: linear-gradient(90deg, #36D1DC, #5B86E5); color:white; }
    .badge-closed { background: linear-gradient(90deg, #43e97b, #38f9d7); color:white; }
    .badge-liquidated { background: linear-gradient(90deg, #f85032, #e73827); color:white; }
  </style>
</head>
<body class="container mt-5">
<div class="d-flex justify-content-between align-items-center mb-4">
  <h2 class="mb-0">📄 Danh sách hợp đồng cầm đồ</h2>
  <a href="${pageContext.request.contextPath}/home" class="btn btn-primary">🏠 Quay về Home</a>
</div>

<p class="text-muted">🔎 Số hợp đồng lấy được: <strong>${pawnContracts.size()}</strong></p>

<!-- Form tìm kiếm -->
<form action="${pageContext.request.contextPath}/pawn-contracts" method="get" class="row g-3 mb-4">
  <div class="col-md-3">
    <input type="text" name="customerName" value="${customerName}" class="form-control" placeholder="Tên khách hàng">
  </div>
  <div class="col-md-3">
    <input type="text" name="employeeName" value="${employeeName}" class="form-control" placeholder="Tên nhân viên">
  </div>
  <div class="col-md-3">
    <input type="text" name="productName" value="${productName}" class="form-control" placeholder="Tên sản phẩm">
  </div>
  <div class="col-md-3">
    <button type="submit" class="btn btn-primary w-100">🔍 Tìm</button>
  </div>
</form>
<div class="mb-3">
  <a href="${pageContext.request.contextPath}/pawn-contracts?action=create" class="btn btn-success">➕ Thêm hợp đồng mới</a>
</div>

<c:choose>
  <c:when test="${not empty pawnContracts}">
    <table class="table table-bordered table-striped table-hover align-middle text-center">
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
      <c:forEach var="c" items="${pawnContracts}" varStatus="status">
        <tr>
          <td>${status.index +1}</td>
          <td>${c.customerName}</td>
          <td>${c.employeeName}</td>
          <td>${c.productName}</td>
          <td><fmt:formatNumber value="${c.pawnPrice}" type="currency" currencySymbol="₫"/></td>
          <td>${c.interestRate != null ? c.interestRate : ''}%</td>
          <td><c:if test="${not empty c.pawnDateFormatted}">${c.pawnDateFormatted}</c:if></td>
          <td><c:if test="${not empty c.dueDateFormatted}">${c.dueDateFormatted}</c:if></td>
          <td><c:if test="${not empty c.returnDateFormatted}">${c.returnDateFormatted}</c:if></td>
          <td>
            <c:choose>
              <c:when test="${c.status == 'DANG_CAM'}">
                <span class="badge badge-active">Đang cầm</span>
              </c:when>
              <c:when test="${c.status == 'DA_CHUOC'}">
                <span class="badge badge-closed">Đã chuộc</span>
              </c:when>
              <c:when test="${c.status == 'THANH_LY'}">
                <span class="badge badge-liquidated">Thanh lý</span>
              </c:when>
              <c:otherwise>
                <span class="badge bg-secondary">${c.status}</span>
              </c:otherwise>
            </c:choose>
          </td>
          <td>
            <a href="${pageContext.request.contextPath}/pawn-contracts?action=edit&id=${c.pawnContractId}" class="btn btn-sm btn-warning btn-action mb-1">✏️ Sửa</a>
            <a href="${pageContext.request.contextPath}/pawn-contracts?action=delete&id=${c.pawnContractId}"
               class="btn btn-sm btn-danger btn-action mb-1"
               onclick="return confirm('Bạn có chắc chắn muốn xóa hợp đồng này?');">🗑 Xóa</a>
          </td>
        </tr>
      </c:forEach>
      </tbody>
    </table>

    <nav aria-label="Page navigation">
      <ul class="pagination justify-content-center">
        <c:forEach begin="1" end="${totalPages}" var="i">
          <li class="page-item ${i == currentPage ? 'active' : ''}">
            <a class="page-link" href="${pageContext.request.contextPath}/pawn-contracts?page=${i}&customerName=${customerName}&employeeName=${employeeName}&productName=${productName}">${i}</a>
          </li>
        </c:forEach>
      </ul>
    </nav>

  </c:when>
  <c:otherwise>
    <div class="text-center mt-5">
      <h4>📭 Chưa có hợp đồng cầm đồ nào!</h4>
      <a href="${pageContext.request.contextPath}/pawn-contracts?action=create" class="btn btn-primary mt-3">Thêm hợp đồng mới</a>
    </div>
  </c:otherwise>
</c:choose>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>
</body>
</html>
