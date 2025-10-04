<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
  HttpSession session = request.getSession();
  String username = (String) session.getAttribute("username");
%>
<h2>Xin chào ADMIN: <%= username %></h2>
<a href="logout.jsp">Đăng xuất</a>
