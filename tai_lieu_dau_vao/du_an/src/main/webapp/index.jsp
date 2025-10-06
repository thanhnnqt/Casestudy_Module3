<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.du_an.entity.Login" %>
<%
    Login acc = (Login) session.getAttribute("account");

    if (acc == null) {
        // Nếu chưa đăng nhập → đến login
        response.sendRedirect("views/login/login.jsp");
        return;
    }
%>
