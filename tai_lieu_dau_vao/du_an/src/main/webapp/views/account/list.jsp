<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 10/4/2025
  Time: 11:28 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <c:import url="/views/layout/library.jsp"/>
</head>
<body>
<div class="d-flex w-100">
    <c:import url="/views/layout/sidebar.jsp"/>
    <div class="col-md-10 bg-dark">
        <h3>Admin</h3>
        <h3 class="text-md-center text-light">Account list</h3>
        <table class="table table-striped table-dark">
            <thead>
            <tr>
                <th>
                    Ordinal number
                </th>

                <th>
                    User name
                </th>

                <th>
                    Password
                </th>

                <th>
                    Role
                </th>

            </tr>
            </thead>
            <tbody>
            <c:forEach var="account" items="${accountList}" varStatus="status">
                <tr>
                    <td>
                        <c:out value="${status.index + 1}"/>
                    </td>
                    <td><c:out value="${account.userName}"/></td>
                    <td><c:out value="${account.password}"/></td>
                    <td><c:out value="${account.role}"/></td>

                </tr>


            </c:forEach>
            </tbody>
        </table>
    </div>

</div>
</body>
</html>
