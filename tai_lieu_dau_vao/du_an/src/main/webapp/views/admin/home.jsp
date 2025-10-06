<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Admin Home</title></head>
<body>
<h2>Chào mừng Admin: ${account.username}</h2>
<p>Vai trò của bạn: ${account.role}</p>
<a href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
</body>
</html>
