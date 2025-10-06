package com.example.du_an.controller;

import com.example.du_an.entity.Login;
import com.example.du_an.repository.LoginRepository;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    private final LoginRepository accountRepository = new LoginRepository();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("views/login/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Login acc = accountRepository.login(username, password);
        if (acc != null) {
            HttpSession session = req.getSession();
            session.setAttribute("account", acc);

            // Điều hướng theo role
            switch (acc.getRole()) {
                case "ADMIN":
                    resp.sendRedirect("/admin-home");
                    break;
                case "STAFF":
                    resp.sendRedirect("/employee-home");
                    break;
                case "USER":
                    resp.sendRedirect("/customer-home");
                    break;
                default:
                    resp.sendRedirect("views/login/login.jsp");
                    break;
            }
        } else {
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            req.getRequestDispatcher("views/login/login.jsp").forward(req, resp);
        }
    }
}
