package com.example.du_an.controller;

import com.example.du_an.dto.CustomerHistoryDto;
import com.example.du_an.entity.Customer;
import com.example.du_an.repository.CustomerRepository;
import com.example.du_an.repository.ICustomerRepository;
import com.example.du_an.service.CustomerHistoryService;
import com.example.du_an.service.ICustomerHistoryService;
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

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);



        if (session == null || session.getAttribute("loggedInCustomer") == null) {
            resp.sendRedirect("/login");
            return;
        }

        Customer customer = (Customer) session.getAttribute("loggedInCustomer");
        CustomerHistoryDto history = historyService.getCustomerHistory(customer);

        req.setAttribute("history", history);
        req.getRequestDispatcher("views/customer/history.jsp").forward(req, resp);
    }
}