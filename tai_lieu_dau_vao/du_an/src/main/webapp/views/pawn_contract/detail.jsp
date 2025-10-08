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
            max-width: 800px;
            margin: 20px auto;
            padding: 40px 50px;
            background: #fff;
            border-radius: 10px;
            border: 3px solid #1a73e8;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
            position: relative;
        }
        .contract-container::before {
            content: "C0625G1";
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%) rotate(-30deg);
            font-size: 80px;
            color: rgba(128, 128, 128, 0.1);
            z-index: 0;
            pointer-events: none;
        }
        .contract-header {
            text-align: center;
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }
        .contract-header h2 { color: #1a73e8; margin-bottom: 5px; }
        .contract-section { margin-bottom: 20px; position: relative; z-index: 1; }
        .section-title {
            font-weight: bold;
            color: #1a73e8;
            border-bottom: 1px solid #ccc;
            margin-bottom: 10px;
            padding-bottom: 5px;
        }
        .contract-label { width: 200px; font-weight: bold; display: inline-block; vertical-align: top; color: #333; }
        .contract-value { display: inline-block; }
        .signature-section { display: flex; justify-content: space-between; margin-top: 50px; }
        .signature { text-align: center; width: 45%; }
        .signature-line { border-top: 1px solid #000; margin-top: 60px; }
        .footer { text-align: center; font-size: 12px; color: #888; margin-top: 30px; position: relative; z-index: 1; }
        .back-button {
            display: inline-block;
            margin: 20px auto;
            padding: 8px 15px;
            background-color: #1a73e8;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }
        .back-button:hover { background-color: #155ab6; color: #fff; }
        @media print { body { background: #fff; } .contract-container { box-shadow: none; } a.back-button { display: none; } }
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
        <div>
            <span class="contract-label">Định giá:</span>
            <span class="contract-value">
                <fmt:formatNumber value="${contract.productValue}" type="number" groupingUsed="true"/>₫
            </span>
        </div>
        <div>
            <span class="contract-label">Bằng chữ:</span>
            <span class="contract-value">${contract.productValueInWords}</span>
        </div>
    </div>

    <div class="contract-section">
        <div class="section-title">Thông tin hợp đồng</div>
        <div><span class="contract-label">Ngày cầm:</span> <span class="contract-value">${contract.pawnDateFormatted}</span></div>
        <div><span class="contract-label">Ngày đáo hạn:</span> <span class="contract-value">${contract.dueDateFormatted}</span></div>
        <div><span class="contract-label">Ngày chuộc:</span> <span class="contract-value">${contract.returnDateFormatted}</span></div>
        <div>
            <span class="contract-label">Số tiền cầm:</span>
            <span class="contract-value">
                <fmt:formatNumber value="${contract.pawnPrice}" type="number" groupingUsed="true"/>₫
            </span>
        </div>
        <div>
            <span class="contract-label">Bằng chữ:</span>
            <span class="contract-value">${contract.pawnPriceInWords}</span>
        </div>
        <div><span class="contract-label">Lãi suất:</span> <span class="contract-value">${contract.interestRate}%</span></div>
    </div>

    <div class="signature-section">
        <div class="signature">
            <p>Khách hàng</p>
            <div class="signature-line"></div>
        </div>
        <div class="signature">
            <p>Nhân viên</p>
            <div class="signature-line"></div>
        </div>
    </div>

    <div class="footer">C0625G1</div>
</div>

<script src="${pageContext.request.contextPath}/bootstrap520/js/bootstrap.bundle.min.js"></script>
</body>
</html>
