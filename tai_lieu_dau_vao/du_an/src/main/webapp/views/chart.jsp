<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Biểu đồ Lãi suất theo tháng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <c:import url="/views/layout/library.jsp"/>
    <style>
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
        .chart-page {
            background: linear-gradient(135deg, #eef2f7, #dce7f3);
            min-height: 100vh;
            font-family: "Poppins", sans-serif;
        }
        .chart-container {
            display: flex;
            width: 100%;
            height: 100vh;
        }
        .chart-content {
            flex: 1;
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        h6 {
            color: #0d6efd;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 1rem;
        }
        #chartCard {
            background: #fff;
            border-radius: 1rem;
            box-shadow: 0 4px 20px rgba(13,110,253,0.2);
            padding: 1rem;
            height: 82vh;
            width: 100%;
            position: relative;
        }
        #myChart {
            width: 100% !important;
            height: 100% !important;
        }
        .chart-control {
            position: absolute;
            top: 10px;
            right: 15px;
        }
        .chart-select {
            border: 1px solid #0d6efd;
            border-radius: 8px;
            padding: 5px 10px;
            color: #0d6efd;
            font-weight: 600;
            cursor: pointer;
            background: #fff;
        }
        .chart-select:hover {
            background-color: #0d6efd;
            color: white;
        }
        @media (max-width: 768px) {
            .chart-container { flex-direction: column; }
        }
    </style>
</head>

<body class="chart-page">
<div class="chart-container">
    <c:import url="/views/layout/sidebar.jsp"/>
    <div class="chart-content col-md-10">
        <div class="page-header d-flex justify-content-between align-items-center w-100">
            <h3 class="mb-0">Doanh thu theo tháng</h3>
            <a href="/views/admin/home.jsp" type="button" class="btn btn-back">
                ⬅ Quay lại
            </a>
        </div>
        <div id="chartCard">
            <canvas id="myChart"></canvas>
        </div>
    </div>
</div>

<script>
    // Chuyển month từ backend thành "Tháng X"
    const labels = ${month}.map(m => 'Tháng ' + parseInt(m, 10));
    const dataValues = ${interestRate};
    const ctx = document.getElementById('myChart').getContext('2d');

    const gradient = ctx.createLinearGradient(0,0,0,400);
    gradient.addColorStop(0,'rgba(13,110,253,0.85)');
    gradient.addColorStop(0.5,'rgba(0,123,255,0.6)');
    gradient.addColorStop(1,'rgba(0,123,255,0.2)');

    const multiColors = [
        '#0d6efd','#6610f2','#6f42c1','#d63384','#fd7e14','#198754','#20c997','#0dcaf0','#ffc107','#fd7e14'
    ];

    let chartType = 'bar';

    function createDataset(type) {
        if(type==='bar'||type==='line') {
            return {
                label: 'Doanh thu (VNĐ)',
                data: dataValues,
                backgroundColor: gradient,
                borderColor: '#0d6efd',
                borderWidth: 2,
                borderRadius: 10,
                hoverBackgroundColor: '#ffc107'
            };
        } else {
            return {
                label: 'Doanh thu (VNĐ)',
                data: dataValues,
                backgroundColor: multiColors,
                borderColor: '#fff',
                borderWidth: 2
            };
        }
    }

    // Tạo chart ban đầu
    let chart = new Chart(ctx, {
        type: chartType,
        data: { labels, datasets: [createDataset(chartType)] },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                tooltip: {
                    backgroundColor: '#0d6efd',
                    titleColor: '#fff',
                    bodyColor: '#fff',
                    borderRadius: 8,
                    padding: 10,
                    callbacks: {
                        label: context => 'Doanh thu: ' + context.formattedValue + ' VNĐ'
                    }
                },
                legend: { labels: { color: '#0d6efd', font: { weight: 'bold', size: 13 } } }
            },
            scales: chartType==='bar'||chartType==='line'? {
                y: { ticks: { color: '#0d6efd', font: { weight: 'bold' } } },
                x: { ticks: { color: '#0d6efd', font: { weight: 'bold' } } }
            } : {}
        }
    });

    // Dropdown chọn type biểu đồ
    const control = document.createElement("div");
    control.className = "chart-control";
    control.innerHTML = `
        <select class="chart-select" id="chartTypeSelect">
            <option value="bar">📊 Cột</option>
            <option value="line">📈 Đường</option>
            <option value="pie">🥧 Tròn</option>
            <option value="doughnut">🍩 Vòng</option>
            <option value="radar">📡 Radar</option>
            <option value="polarArea">🔵 Polar</option>
        </select>`;
    document.getElementById("chartCard").appendChild(control);

    document.getElementById("chartTypeSelect").addEventListener("change", e=>{
        chart.destroy();
        chartType = e.target.value;
        chart = new Chart(ctx,{
            type: chartType,
            data: { labels, datasets: [createDataset(chartType)] },
            options: {
                responsive: true,
                maintainAspectRatio: false,
                plugins: {
                    tooltip: {
                        backgroundColor: '#0d6efd',
                        titleColor: '#fff',
                        bodyColor: '#fff',
                        borderRadius: 8,
                        padding: 10,
                        callbacks: { label: context => 'Doanh thu: ' + context.formattedValue + ' VNĐ' }
                    },
                    legend: { labels: { color: '#0d6efd', font: { weight: 'bold', size: 13 } } }
                },
                scales: chartType==='bar'||chartType==='line'? {
                    y: { ticks: { color: '#0d6efd', font: { weight: 'bold' } } },
                    x: { ticks: { color: '#0d6efd', font: { weight: 'bold' } } }
                } : {}
            }
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
