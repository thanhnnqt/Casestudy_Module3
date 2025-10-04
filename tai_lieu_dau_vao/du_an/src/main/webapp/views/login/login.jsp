<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head><title>Đăng nhập</title></head>
<body>
<h2>Đăng nhập</h2>
<form method="post" action="login">
    Username: <input type="text" name="username"/><br/>
    Password: <input type="password" name="password"/><br/>
    <button type="submit">Login</button>
</form>
<p style="color:red">${error}</p>
</body>
</html>