package com.example.du_an.controller;


import com.example.du_an.dto.CustomerDto;

import com.example.du_an.service.CustomerAutoDeleteService;
import com.example.du_an.service.CustomerDtoService;
import com.example.du_an.service.ICustomerDtoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerController", value = "/customer")
public class CustomerController extends HttpServlet {
    ICustomerDtoService customerDtoService = new CustomerDtoService();


    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "list":
                CustomerAutoDeleteService.deleteOldCustomers();
                List<CustomerDto> customerDtoList = customerDtoService.findAll();

                request.setAttribute("customerDtoList", customerDtoList);

                try {
                    request.getRequestDispatcher("views/customer/list.jsp").forward(request, response);
                } catch (ServletException e) {
                    e.printStackTrace();
                }
                break;
        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "search":
                String infoSearch = req.getParameter("infoSearch");
                String citizenNumber = req.getParameter("citizenNumber");
                List<CustomerDto> customerDtoList = customerDtoService.findByName(infoSearch, citizenNumber);
                if (infoSearch == null && citizenNumber == null) {
                    try {
                        resp.sendRedirect("/customer?action=list");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else {
                    req.setAttribute("customerDtoList", customerDtoList);
                    req.setAttribute("infoSearch", infoSearch);
                    req.setAttribute("citizenNumber", citizenNumber);
                    req.getRequestDispatcher("views/customer/list.jsp").forward(req, resp);
                }


                break;
        }
    }
}
