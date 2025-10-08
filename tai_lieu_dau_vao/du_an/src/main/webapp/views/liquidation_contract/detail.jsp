<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
  <title>Chi tiết hợp đồng thanh lý</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css">
</head>
<body class="bg-light">

<div class="container mt-5">
  <div class="card shadow">
    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
      <h4 class="mb-0">Chi tiết hợp đồng thanh lý #${contract.liquidationContractId}</h4>
      <a href="${pageContext.request.contextPath}/liquidation-contract" class="btn btn-light btn-sm">⬅ Quay lại</a>
    </div>
    <div class="card-body">
      <h5 class="mb-3 text-primary">Thông tin khách hàng</h5>
      <p><strong>Họ tên:</strong> ${contract.customerName}</p>
      <p><strong>CCCD:</strong> ${contract.citizenNumber}</p>
      <p><strong>SĐT:</strong> ${contract.phoneNumber}</p>

      <h5 class="mt-4 mb-3 text-primary">Thông tin sản phẩm</h5>
      <p><strong>Tên sản phẩm:</strong> ${contract.productName}</p>
      <p><strong>Giá trị thanh lý:</strong> ${contract.liquidationPrice} ₫</p>
      <p><strong>Ngày thanh lý:</strong> ${contract.liquidationDate}</p>

      <h5 class="mt-4 mb-3 text-primary">Thông tin nhân viên xử lý</h5>
      <p><strong>Tên nhân viên:</strong> ${contract.employeeName}</p>

      <div class="text-center mt-4">
        <a href="${pageContext.request.contextPath}/liquidation-contract?action=print&id=${contract.liquidationContractId}"
           class="btn btn-success">🖨️ In hợp đồng PDF</a>
      </div>
    </div>
  </div>
</div>

</body>
</html>
