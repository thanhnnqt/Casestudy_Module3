package com.example.du_an.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/database",
                "root", "codegym"); // sửa user/pass DB của bạn
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        try (Connection conn = getConnection()) {
            String sql = "SELECT * FROM users WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String role = rs.getString("role");

                HttpSession session = req.getSession();
                session.setAttribute("username", username);
                session.setAttribute("role", role);

                // Điều hướng theo role
                if ("ADMIN".equals(role)) {
                    resp.sendRedirect("admin.jsp");
                } else if ("STAFF".equals(role)) {
                    resp.sendRedirect("staff.jsp");
                } else {
                    resp.sendRedirect("user.jsp");
                }
            } else {
                req.setAttribute("error", "Sai tài khoản hoặc mật khẩu!");
                req.getRequestDispatcher("login.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
