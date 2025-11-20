<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Kết quả thanh toán</title>
  <meta charset="UTF-8"/>
  <link rel="stylesheet" href="<%=request.getContextPath()%>/bootstrap520/css/bootstrap.min.css"/>
</head>
<body class="bg-light">
<div class="container py-5">
  <div class="card shadow-sm">
    <div class="card-body">
      <h3 class="mb-3">Kết quả thanh toán</h3>
      <p class="fs-5"><strong>${result}</strong></p>

      <hr/>
      <h5>Thông tin giao dịch (tham khảo):</h5>
      <ul>
        <li>Mã đơn hàng (vnp_TxnRef): ${param.vnp_TxnRef}</li>
        <li>Mã giao dịch VNPAY (vnp_TransactionNo): ${param.vnp_TransactionNo}</li>
        <li>Ngân hàng (vnp_BankCode): ${param.vnp_BankCode}</li>
        <li>Số tiền (vnp_Amount): ${param.vnp_Amount}</li>
        <li>Mã phản hồi (vnp_ResponseCode): ${param.vnp_ResponseCode}</li>
      </ul>
      <a href="<%=request.getContextPath()%>/" class="btn btn-primary">Về trang hóa đơn</a>
    </div>
  </div>
</div>
</body>
</html>