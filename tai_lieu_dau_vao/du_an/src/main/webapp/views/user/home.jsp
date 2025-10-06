<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Customer Home</title></head>
<body>
<h2>Chào khách hàng: ${account.username}</h2>
<p>Vai trò: ${account.role}</p>
<a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</body>
</html>
