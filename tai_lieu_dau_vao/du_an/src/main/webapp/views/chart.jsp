<%--
  Created by IntelliJ IDEA.
  User: ASUS
  Date: 10/5/2025
  Time: 4:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <c:import url="/views/layout/library.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body>
<div class="d-flex h-100 w-100">
    <c:import url="/views/layout/sidebar.jsp"/>
    <div class="col-md-10">
        <canvas id="myChart" width="400" height="200"></canvas>
    </div>
</div>

<script>
    const labels = ${month};
    const dataValues = ${interestRate};
    const ctx = document.getElementById('myChart');
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: labels,   // cần convert thành JSON string
            datasets: [{
                label: 'Interest rate/Month',
                data: dataValues,
                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                borderWidth: 1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
</script>
</body>
</html>
