<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Biểu đồ Lãi suất theo tháng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* ==== Toàn trang ==== */
        body {
            background: linear-gradient(135deg, #eef2f7, #dce7f3);
            min-height: 100vh;
            font-family: "Poppins", sans-serif;
            color: #212529;
            overflow-x: hidden;
        }

        .d-flex {
            height: 100vh;
        }

        /* ==== Vùng chứa nội dung bên phải ==== */
        .col-md-10 {
            padding: 1.5rem;
            display: flex;
            flex-direction: column;
            align-items: center;
        }

        h6 {
            font-weight: 600;
            letter-spacing: 0.5px;
            text-shadow: 0 0.5px 1px rgba(0,0,0,0.2);
            margin-bottom: 1rem;
        }

        /* ==== Thẻ chứa biểu đồ ==== */
        #chartCard {
            background: #ffffff;
            border-radius: 1.2rem;
            padding: 1.5rem;
            width: 100%;
            max-width: 100%;
            height: 82vh; /* chiếm gần hết chiều cao màn hình */
            box-shadow: 0 8px 20px rgba(13,110,253,0.1);
            border: 1px solid rgba(13,110,253,0.15);
            transition: all 0.35s ease;
            animation: fadeInUp 0.8s ease;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        #chartCard:hover {
            transform: translateY(-5px);
            box-shadow: 0 12px 28px rgba(13,110,253,0.18);
            border-color: rgba(13,110,253,0.35);
        }

        /* ==== Canvas ==== */
        #myChart {
            width: 95% !important;    /* full gần hết chiều ngang màn hình */
            height: 100% !important;  /* tự co cho vừa khung */
            background: linear-gradient(180deg, #f9fbff, #eef5ff);
            border-radius: 1rem;
            padding: 1rem;
            border: 1px solid rgba(13,110,253,0.1);
            box-shadow: inset 0 0 8px rgba(13,110,253,0.08);
            transition: all 0.4s ease;
        }

        #chartCard:hover #myChart {
            box-shadow: inset 0 0 12px rgba(13,110,253,0.2);
            background: linear-gradient(180deg, #f0f6ff, #e3edff);
        }

        /* ==== Scrollbar ==== */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-thumb {
            background: linear-gradient(180deg, #0d6efd, #74b9ff);
            border-radius: 6px;
        }

        ::-webkit-scrollbar-track {
            background: #f1f1f1;
        }

        /* ==== Animation ==== */
        @keyframes fadeInUp {
            from {
                transform: translateY(20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }

        /* ==== Tiêu đề ==== */
        .text-primary {
            color: #0d6efd !important;
            text-transform: uppercase;
            letter-spacing: 0.7px;
        }
    </style>

</head>
<body>

<div class="d-flex w-100">
    <c:import url="/views/layout/sidebar.jsp"/>
    <div class="col-md-10 p-2">
        <h6 class="mb-2 text-center text-primary mt-0">Lãi suất theo tháng</h6>
        <div id="chartCard">
            <canvas id="myChart" height="150"></canvas>
        </div>
    </div>
</div>

<script>
    const labels = ${month};
    const dataValues = ${interestRate};

    const chartContainer = document.getElementById('chartCard');
    const canvas = document.getElementById('myChart');
    let ctx = canvas.getContext('2d');

    function createGradient(ctx) {
        const gradient = ctx.createLinearGradient(0, 0, 0, 400);
        gradient.addColorStop(0, 'rgba(13,110,253,0.9)');
        gradient.addColorStop(0.5, 'rgba(13,110,253,0.6)');
        gradient.addColorStop(1, 'rgba(13,110,253,0.15)');
        return gradient;
    }

    let chartType = 'bar';
    let chart;

    const baseConfig = {
        data: {
            labels,
            datasets: [{
                label: 'Lãi suất (%)',
                data: dataValues,
                backgroundColor: createGradient(ctx),         // màu bình thường
                borderColor: '#0d6efd',
                borderWidth: 2,
                borderRadius: 12,
                tension: 0.4,
                fill: true,
                hoverBackgroundColor: 'rgba(13,110,253,0.8)', // màu nổi bật khi hover
                hoverBorderColor: '#ffc107',                   // viền khi hover
                hoverBorderWidth: 3,
                pointBackgroundColor: '#0d6efd',
                pointHoverRadius: 8,
                pointHoverBackgroundColor: '#ffc107'
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            animation: {
                duration: 1000,
                easing: 'easeOutQuart'
            },
            plugins: {
                legend: {
                    display: true,
                    labels: { color: '#0d6efd', font: { size: 13, weight: 'bold' } }
                },
                tooltip: {
                    backgroundColor: 'rgba(13,110,253,0.9)',
                    titleFont: { weight: 'bold', size: 13 },
                    bodyFont: { size: 12 },
                    cornerRadius: 10,
                    callbacks: {
                        title: ctx => 'Tháng: ' + ctx[0].label,
                        label: ctx => 'Lãi suất: ' + ctx.formattedValue + ' đ'
                    }
                }
            },
            hover: {
                mode: 'nearest',
                intersect: true
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { color: 'rgba(13,110,253,0.05)' },
                    ticks: { color: '#0d6efd', font: { size: 11, weight: 'bold' } }
                },
                x: {
                    grid: { color: 'rgba(13,110,253,0.05)' },
                    ticks: { color: '#0d6efd', font: { size: 11, weight: 'bold' } }
                }
            }
        }
    };


    // Tạo chart ban đầu
    chart = new Chart(ctx, { ...baseConfig, type: chartType });

    // === Dropdown chọn loại biểu đồ ===
    const controlWrapper = document.createElement('div');
    controlWrapper.className = "chart-control";
    controlWrapper.innerHTML = `
        <select id="chartSelect" class="chart-select">
            <option value="bar" selected>📊 Biểu đồ cột</option>
            <option value="line">📈 Biểu đồ đường</option>
            <option value="pie">🥧 Biểu đồ tròn</option>
            <option value="doughnut">🍩 Biểu đồ vòng</option>
        </select>
    `;
    chartContainer.appendChild(controlWrapper);

    const style = document.createElement('style');
    style.innerHTML = `
        .chart-control {
            position: absolute;
            top: 15px;
            right: 25px;
            z-index: 10;
            background: rgba(255,255,255,0.95);
            border-radius: 12px;
            padding: 8px 12px;
            box-shadow: 0 4px 12px rgba(13,110,253,0.15);
        }
        .chart-select {
            border: 2px solid #0d6efd;
            background: white;
            color: #0d6efd;
            font-weight: 600;
            border-radius: 10px;
            padding: 8px 12px;
            font-size: 14px;
            cursor: pointer;
            box-shadow: 0 2px 6px rgba(13,110,253,0.15);
            transition: all 0.25s ease;
        }
        .chart-select:hover {
            background: #0d6efd;
            color: white;
            transform: translateY(-1px);
        }
        .chart-select option {
            color: #0d6efd;
            font-weight: 500;
            font-size: 14px;
            background: white;
        }
        .chart-select:focus {
            outline: none;
            box-shadow: 0 0 0 3px rgba(13,110,253,0.3);
        }
        #chartCard {
            position: relative;
        }
        @keyframes fadeInChart {
            from { opacity: 0; transform: scale(0.98); }
            to { opacity: 1; transform: scale(1); }
        }
        canvas.fade-in {
            animation: fadeInChart 0.6s ease;
        }
    `;
    document.head.appendChild(style);

    // === Xử lý đổi loại biểu đồ ===
    document.getElementById('chartSelect').addEventListener('change', (e) => {
        const newType = e.target.value;
        if (chart) chart.destroy();

        ctx.clearRect(0, 0, canvas.width, canvas.height);

        canvas.classList.remove('fade-in');
        void canvas.offsetWidth; // reset animation
        canvas.classList.add('fade-in');

        chartType = newType;
        baseConfig.data.datasets[0].backgroundColor = createGradient(ctx);
        chart = new Chart(ctx, { ...baseConfig, type: chartType });
    });
</script>








<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
