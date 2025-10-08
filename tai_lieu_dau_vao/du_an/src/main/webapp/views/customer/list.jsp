<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Danh sách khách hàng</title>
    <c:import url="/views/layout/library.jsp"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/datatables/css/dataTables.bootstrap5.min.css"/>
    <script src="${pageContext.request.contextPath}/jquery/jquery-3.5.1.min.js"></script>
    <script src="${pageContext.request.contextPath}/datatables/js/jquery.dataTables.min.js"></script>
    <script src="${pageContext.request.contextPath}/datatables/js/dataTables.bootstrap5.min.js"></script>

    <style>
        body {
            font-family: "Poppins", sans-serif;
            background: #f8f9fa;
            color: #212529;
        }

        .page-header {
            background: linear-gradient(90deg, #0d6efd, #0dcaf0);
            padding: 15px 25px;
            border-radius: 10px;
            color: white;
            margin-bottom: 20px;
            box-shadow: 0 2px 8px rgba(13, 110, 253, 0.3);
        }

        .btn-back {
            background-color: #ffc107;
            border: none;
            color: #212529;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-back:hover {
            background-color: #ffca2c;
            color: black;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }

        table.dataTable {
            border-collapse: separate !important;
            border-spacing: 0 8px;
            border-radius: 12px;
            overflow: hidden;
            background: #ffffff;
        }

        table.dataTable thead th {
            background: #0d6efd;
            color: #fff;
            font-weight: 600;
            text-align: center;
            border: none;
            padding: 14px 10px;
            font-size: 14px;
        }

        table.dataTable tbody td {
            background: #f1f3f5;
            color: #212529;
            text-align: center;
            vertical-align: middle;
            padding: 12px 10px;
            font-size: 13px;
            border: none;
            transition: all 0.25s ease;
        }

        table.dataTable tbody tr:hover td {
            background: #cfe2ff;
            color: #0d6efd;
            transform: scale(1.02);
        }

        .dataTables_paginate .paginate_button {
            margin: 0 3px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.25s ease;
        }

        .dataTables_paginate .paginate_button:hover {
            transform: translateY(-2px);
            box-shadow: 0 2px 8px rgba(13, 110, 253, 0.3);
        }

        .dataTables_paginate .paginate_button.current {
            background: #ffc107 !important;
            color: #000 !important;
            border-color: #ffc107;
            font-weight: 600;
        }

        .dataTables_length select {
            background: #fff;
            color: #212529;
            border: 2px solid #0d6efd;
            border-radius: 10px;
            padding: 4px 12px;
            font-size: 14px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .dataTables_length select:focus {
            outline: none;
            border-color: #ffc107;
            box-shadow: 0 0 8px rgba(255, 193, 7, 0.5);
        }

        @media (max-width: 768px) {
            table.dataTable tbody td,
            table.dataTable thead th {
                font-size: 12px;
                padding: 6px;
            }
        }
    </style>

    <script>
        $(document).ready(function () {
            $('#tableCustomer').DataTable({
                "lengthChange": true,
                "pageLength": 5,
                responsive: true,
                "dom": 'lrtip'
            });
        });
    </script>
</head>

<body>
<div class="d-flex w-100">
    <c:import url="/views/layout/sidebar.jsp"/>

    <div class="col-md-10 table-light p-4">
        <div class="page-header d-flex justify-content-between align-items-center">
            <h3 class="mb-0">Danh sách khách hàng</h3>
            <a href="/views/admin/home.jsp" type="button" class="btn btn-back">
                ⬅ Quay lại
            </a>
        </div>

        <!-- Search Box -->
        <form id="searchForm" action="/customer?action=search" method="post" class="d-flex mb-3">
            <input name="infoSearch" value="${infoSearch}" class="form-control me-2"
                   type="search" placeholder="Tìm kiếm tên..." aria-label="Tìm kiếm">
            <input name="citizenNumber" value="${citizenNumber}" class="form-control me-2"
                   type="search" placeholder="Tìm kiếm căn cước công dân" aria-label="Tìm kiếm">
            <button class="btn btn-primary" type="submit">
                <i class="fas fa-search"></i> Tìm
            </button>
        </form>

        <table id="tableCustomer" class="table table-striped">
            <thead>
            <tr>
                <th>STT</th>
                <th>Họ và tên</th>
                <th>Số CCCD</th>
                <th>Địa chỉ</th>
                <th>Email</th>
                <th>Ngày sinh</th>
                <th>Số điện thoại</th>
                <th>Tên tài khoản</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="customer" items="${customerDtoList}" varStatus="status">
                <tr>
                    <td><c:out value="${status.index + 1}"/></td>
                    <td><c:out value="${customer.fullName}"/></td>
                    <td><c:out value="${customer.citizenNumber}"/></td>
                    <td><c:out value="${customer.address}"/></td>
                    <td><c:out value="${customer.email}"/></td>
                    <td><c:out value="${customer.dob}"/></td>
                    <td><c:out value="${customer.phoneNumber}"/></td>
                    <td><c:out value="${customer.userName}"/></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>
</div>
</body>
</html>
