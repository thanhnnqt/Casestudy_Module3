package com.example.du_an.controller;

import com.example.du_an.dto.CustomerHistoryDto;
import com.example.du_an.entity.Customer;
import com.example.du_an.entity.Login;
import com.example.du_an.sevice.CustomerHistoryService;
import com.example.du_an.service.CustomerService;
import com.example.du_an.sevice.ICustomerHistoryService;
import com.example.du_an.service.ICustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "CustomerHistoryController", value = "/customer-history")
public class CustomerHistoryController extends HttpServlet {
    private final ICustomerHistoryService historyService = new CustomerHistoryService();
    private final ICustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);

        if (session == null || session.getAttribute("account") == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        Login account = (Login) session.getAttribute("account");

        Customer customer = customerService.findByAccountId(account.getId());

        if (customer == null) {
            resp.getWriter().println("<h1>Tài khoản này không phải là khách hàng.</h1>");
            return;
        }

        CustomerHistoryDto history = historyService.getCustomerHistory(customer);
        req.setAttribute("history", history);
        req.getRequestDispatcher("views/customer/history.jsp").forward(req, resp);
    }
}