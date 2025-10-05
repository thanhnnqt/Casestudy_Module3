package com.example.du_an.controller;

import com.example.du_an.entity.Account;
import com.example.du_an.service.AccountService;
import com.example.du_an.service.IAccountService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AccountController", value = "/account")
public class AccountController extends HttpServlet {
    IAccountService accountService = new AccountService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //if(role == ""ADMIN)
        req.getRequestDispatcher("views/customer/list.jsp").forward(req, resp);
    }

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "list":
                List<Account> accountList = accountService.findAll();
                req.setAttribute("accountList", accountList);
                req.getRequestDispatcher("views/account/list.jsp").forward(req, resp);
                break;
        }

    }
}
