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
    <script>
        $(document).ready(function () {
            $('#tableCustomer').DataTable({
                "dom": 'lrtip',
                "lengthChange": false,
                "pageLength": 5,
            });
        });

    </script>
</head>
<body>

<div class="d-flex w-100">
    <c:import url="/views/layout/sidebar.jsp"/>
    <div class="col-md-10 bg-dark">
        <h3>Admin</h3>
        <h3 class="text-md-center text-light">Customer list</h3>
        <table id="tableCustomer" class="table table-striped table-dark">
            <thead>
            <tr>
                <th>
                    Ordinal number
                </th>

                <th>
                    Full name
                </th>

                <th>
                    Citizen number
                </th>

                <th>
                    Address
                </th>

                <th>
                    Email
                </th>

                <th>
                    Date of birth
                </th>

                <th>
                    Phone number
                </th>

                <th>
                    User name
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="customer" items="${customerDtoList}" varStatus="status">
                <tr>
                    <td>
                        <c:out value="${status.index + 1}"/>
                    </td>
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
