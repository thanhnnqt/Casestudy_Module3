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

            // ✅ Quay về trang chủ
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            req.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu!");
            req.getRequestDispatcher("views/login/login.jsp").forward(req, resp);
        }
    }
}
