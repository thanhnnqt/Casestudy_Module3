<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html>
<head>
    <title>Chi tiết hợp đồng</title>
    <link href="${pageContext.request.contextPath}/bootstrap520/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: "Times New Roman", serif;
            line-height: 1.6;
            color: #000;
            background: #f0f2f5;
        }

        .contract-container {
            max-width: 850px;
            margin: 40px auto;
            padding: 50px 60px;
            background: #fff;
            border-radius: 12px;
            border: 2px solid #1a73e8;
            box-shadow: 0 0 15px rgba(0,0,0,0.15);
            position: relative;
        }

        .contract-container::before {
            content: "C0625G1";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-25deg);
            font-size: 100px;
            color: rgba(128, 128, 128, 0.08);
            z-index: 0;
            pointer-events: none;
        }

        .contract-header {
            text-align: center;
            margin-bottom: 35px;
            position: relative;
            z-index: 1;
        }

        .contract-header h2 {
            color: #1a73e8;
            font-weight: bold;
            text-transform: uppercase;
            margin-bottom: 5px;
        }

        .contract-section {
            background: #fafbff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px 20px;
            margin-bottom: 20px;
            position: relative;
            z-index: 1;
        }

        .section-title {
            font-weight: bold;
            color: #1a73e8;
            border-bottom: 2px solid #1a73e8;
            margin-bottom: 12px;
            padding-bottom: 4px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .contract-label {
            width: 220px;
            font-weight: bold;
            display: inline-block;
            vertical-align: top;
            color: #333;
        }

        .contract-value {
            display: inline-block;
            color: #000;
        }

        /* Đồng bộ màu thanh toán với các phần khác */
        .payment-section {
            background: #fafbff;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 15px 20px;
            margin-bottom: 20px;
        }

        .signature-section {
            display: flex;
            justify-content: space-between;
            margin-top: 60px;
            text-align: center;
        }

        .signature {
            width: 45%;
        }

        .signature p {
            margin-bottom: 60px;
        }

        .signature-line {
            border-top: 1px solid #000;
            margin-top: 60px;
        }

        .footer {
            text-align: center;
            font-size: 12px;
            color: #777;
            margin-top: 40px;
            position: relative;
            z-index: 1;
        }

        .back-button {
            display: inline-block;
            margin: 25px auto;
            padding: 8px 16px;
            background-color: #1a73e8;
            color: #fff;
            text-decoration: none;
            border-radius: 6px;
            font-weight: bold;
        }

        .back-button:hover {
            background-color: #155ab6;
            color: #fff;
        }

        @media print {
            body { background: #fff; }
            .contract-container { box-shadow: none; border: none; }
            a.back-button { display: none; }
        }
    </style>
</head>
<body>

<a href="${pageContext.request.contextPath}/pawn-contracts" class="back-button">← Quay lại danh sách</a>

<div class="contract-container">
    <div class="contract-header">
        <h2>📄 HỢP ĐỒNG CẦM ĐỒ</h2>
        <p>Mã hợp đồng: <strong>${contract.pawnContractId}</strong></p>
    </div>

    <div class="contract-section">
        <div class="section-title">Thông tin khách hàng</div>
        <div><span class="contract-label">Họ và tên:</span> <span class="contract-value">${contract.customerName}</span></div>
        <div><span class="contract-label">Ngày sinh:</span> <span class="contract-value">${contract.customerDobFormatted}</span></div>
        <div><span class="contract-label">CCCD:</span> <span class="contract-value">${contract.customerCccd}</span></div>
        <div><span class="contract-label">Email:</span> <span class="contract-value">${contract.customerEmail}</span></div>
    </div>

    <div class="contract-section">
        <div class="section-title">Nhân viên phụ trách</div>
        <div><span class="contract-label">Tên nhân viên:</span> <span class="contract-value">${contract.employeeName}</span></div>
    </div>

    <div class="contract-section">
        <div class="section-title">Thông tin sản phẩm</div>
        <div><span class="contract-label">Tên sản phẩm:</span> <span class="contract-value">${contract.productName}</span></div>
        <div><span class="contract-label">Mô tả:</span> <span class="contract-value">${contract.productDescription}</span></div>
        <div><span class="contract-label">Định giá:</span>
            <span class="contract-value"><fmt:formatNumber value="${contract.productValue}" type="number" groupingUsed="true"/>₫</span>
        </div>
        <div><span class="contract-label">Bằng chữ:</span> <span class="contract-value">${contract.productValueInWords}</span></div>
    </div>

    <div class="contract-section">
        <div class="section-title">Thông tin hợp đồng</div>
        <div><span class="contract-label">Ngày cầm:</span> <span class="contract-value">${contract.pawnDateFormatted}</span></div>
        <div><span class="contract-label">Ngày đáo hạn:</span> <span class="contract-value">${contract.dueDateFormatted}</span></div>
        <div><span class="contract-label">Ngày chuộc:</span> <span class="contract-value">${contract.returnDateFormatted}</span></div>
        <div><span class="contract-label">Số tiền cầm:</span>
            <span class="contract-value"><fmt:formatNumber value="${contract.pawnPrice}" type="number" groupingUsed="true"/>₫</span>
        </div>
        <div><span class="contract-label">Bằng chữ:</span> <span class="contract-value">${contract.pawnPriceInWords}</span></div>
        <div><span class="contract-label">Lãi suất:</span> <span class="contract-value">${contract.interestRate}%</span></div>
    </div>

    <!-- 🔹 Phần thanh toán - đồng màu -->
    <div class="payment-section">
        <div class="section-title">Thông tin thanh toán</div>
        <div>
            <span class="contract-label">Tổng tiền khách phải thanh toán:</span>
            <span class="contract-value fw-bold text-dark">
            <fmt:formatNumber value="${totalPayment}" type="number" groupingUsed="true"/>₫
        </span>
        </div>
        <div>
            <span class="contract-label">Bằng chữ:</span>
            <span class="contract-value text-dark">${totalPaymentInWords}</span>
        </div>
    </div>

    <div class="signature-section">
        <div class="signature">
            <p><strong>Khách hàng</strong></p>
            <div class="signature-line"></div>
        </div>
        <div class="signature">
            <p><strong>Nhân viên</strong></p>
            <div class="signature-line"></div>
        </div>
    </div>

    <div class="footer">© C0625G1 - Cầm đồ uy tín số 1 CodeGym</div>
</div>

<a href="#" id="downloadPdf" class="back-button">⬇️ Tải file PDF</a>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<script>
    document.getElementById("downloadPdf").addEventListener("click", function (e) {
        e.preventDefault();
        const element = document.querySelector(".contract-container");
        const opt = {
            margin: 0.5,
            filename: 'hop_dong_cam_do_${contract.pawnContractId}.pdf',
            image: { type: 'jpeg', quality: 1 },
            html2canvas: { scale: 2, useCORS: true, scrollY: 0 },
            jsPDF: { unit: 'in', format: 'a4', orientation: 'portrait' }
        };
        html2pdf().set(opt).from(element).save();
    });
</script>
</body>
</html>
