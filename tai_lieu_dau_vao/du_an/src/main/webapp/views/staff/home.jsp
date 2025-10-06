<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Employee Home</title></head>
<body>
<h2>Chào nhân viên: ${account.username}</h2>
<p>Vai trò: ${account.role}</p>
<a href="${pageContext.request.contextPath}/pawn-contracts">Quản lý hợp đồng cầm đồ</a><br>
<a href="${pageContext.request.contextPath}/liquidation-contract">Quản lý hợp đồng thanh lý</a><br>
<a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</body>
</html>
