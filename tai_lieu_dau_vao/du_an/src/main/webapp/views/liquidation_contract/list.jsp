<%--
  Created by IntelliJ IDEA.
  User: GAMING-PC
  Date: 30/09/2025
  Time: 9:53 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<html>
<head>
    <title>Title</title>
    <c:import url="../layout/library.jsp"/>
    <link rel="stylesheet" href="bootstrap520/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="datatables/css/dataTables.bootstrap5.min.css"/>
</head>
<body>
<div class="container mt-4">
    <c:import url="../layout/navbar.jsp"/>
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="mb-0">📄 Danh sách hợp đồng thanh lý</h2>
        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-primary">🏠 Quay về Home</a>
    </div>
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
        <div class="col-md-3">
            <a href="/liquidation-contract?action=create" class="btn btn-success w-100">+ Thêm sản phẩm</a>
        </div>
    </form>
    <table id="tableProduct" class="table table-dark table-striped">
        <thead>
        <tr>
            <th>STT</th>
            <th>Id hợp đồng</th>
            <th>Khách hàng</th>
            <th>Ngày tạo hợp đồng</th>
            <th>Giá trị hợp đồng</th>
            <th>Tên sản phẩm</th>
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
                    <button type="button" class="btn btn-danger btn-sm"
                            data-bs-toggle="modal"
                            data-bs-target="#deleteModal${contract.liquidationContractId}">
                        Xóa
                    </button>

                    <!-- Modal xác nhận -->
                    <div class="modal fade" id="deleteModal${contract.liquidationContractId}" tabindex="-1"
                         aria-labelledby="deleteModalLabel${contract.liquidationContractId}" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" style="color: black"
                                        id="deleteModalLabel${contract.liquidationContractId}">
                                        Xác nhận xóa sản phẩm
                                    </h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>
                                <div class="modal-body text-color-black" style="color: black">
                                    Bạn có chắc muốn xóa <strong>${contract.liquidationContractId}</strong> không?
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        Hủy
                                    </button>
                                    <!-- Nút Xóa thật sự -->
                                    <a href="/liquidation-contract?action=delete&liquidation_contract_id=${contract.liquidationContractId}"
                                       class="btn btn-danger">
                                        Xóa
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
<script src="jquery/jquery-3.5.1.min.js"></script>
<script src="datatables/js/jquery.dataTables.min.js"></script>
<script src="datatables/js/dataTables.bootstrap5.min.js"></script>
<script>
    $(document).ready(function () {
        $('#tableProduct').dataTable({
            "dom": 'lrtip',
            "lengthChange": false,
            "pageLength": 5
        });
    });
</script>
</body>
</html>
