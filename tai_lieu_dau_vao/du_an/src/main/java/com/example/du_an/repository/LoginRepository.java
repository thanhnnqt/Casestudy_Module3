package com.example.du_an.repository;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class LoginRepository implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String uri = req.getRequestURI();
        HttpSession session = req.getSession(false);

        // Cho phép truy cập các trang public
        if (uri.endsWith("login.jsp") || uri.endsWith("login") || uri.contains("css")) {
            chain.doFilter(request, response);
            return;
        }

        // Kiểm tra đăng nhập
        if (session == null || session.getAttribute("role") == null) {
            resp.sendRedirect("login.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");

        // Quy định quyền
        if (uri.endsWith("admin.jsp") && !"ADMIN".equals(role)) {
            resp.sendRedirect("403.jsp");
            return;
        }
        if (uri.endsWith("staff.jsp") && !(role.equals("STAFF") || role.equals("ADMIN"))) {
            resp.sendRedirect("403.jsp");
            return;
        }
        if (uri.endsWith("user.jsp") && !(role.equals("USER") || role.equals("ADMIN") || role.equals("STAFF"))) {
            resp.sendRedirect("403.jsp");
            return;
        }

        chain.doFilter(request, response);
    }
}
