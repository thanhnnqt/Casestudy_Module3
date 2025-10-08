<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 10/4/2025
  Time: 11:17 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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

        /* ==== Bảng sáng ==== */
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

        /* Bo góc */
        table.dataTable tbody tr:first-child td:first-child {
            border-top-left-radius: 10px;
        }

        table.dataTable tbody tr:first-child td:last-child {
            border-top-right-radius: 10px;
        }

        table.dataTable tbody tr:last-child td:first-child {
            border-bottom-left-radius: 10px;
        }

        table.dataTable tbody tr:last-child td:last-child {
            border-bottom-right-radius: 10px;
        }

        /* Pagination sáng, phẳng */
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

        .dataTables_paginate .paginate_button:disabled {
            /*background: #f1f3f5 !important;*/
            /*color: #adb5bd !important;*/
            border-color: #f1f3f5 !important;
            cursor: not-allowed;
            box-shadow: none;
            transform: none;
        }

        /* Length select box */
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

        /* Responsive */
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
    <div class="col-md-10 table-light">
        <h3 class="text-md-center text-light">Danh sách khách hàng</h3>
        <!-- Search Box -->
        <form id="searchForm" action="/customer?action=search" method="post" class="d-flex mb-3">
            <input name="infoSearch" value="${infoSearch}" id="searchInput" class="form-control me-2" type="search" placeholder="Tìm kiếm tên..." aria-label="Tìm kiếm">
            <input name="citizenNumber" value="${citizenNumber}" id="searchInput" class="form-control me-2" type="search" placeholder="Tìm kiếm căn cước công dân" aria-label="Tìm kiếm">

            <button class="btn btn-primary" type="submit" onclick="searchTable()">
                <i class="fas fa-search"></i> Tìm
            </button>
        </form>
        <table id="tableCustomer" class="table table-striped">
            <thead>
            <tr>
                <th>
                    STT
                </th>

                <th>
                    Họ và tên
                </th>

                <th>
                    Số CCCD
                </th>

                <th>
                    Địa chỉ
                </th>

                <th>
                    Email
                </th>

                <th>
                    Ngày sinh
                </th>

                <th>
                    Số điện thoại
                </th>

                <th>
                    Tên tài khoản
                </th>
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
