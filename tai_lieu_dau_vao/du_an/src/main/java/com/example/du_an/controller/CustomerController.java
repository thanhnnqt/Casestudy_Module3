package com.example.du_an.controller;

import com.example.du_an.HelloServlet;
import com.example.du_an.dto.CustomerDto;
import com.example.du_an.service.CustomerDtoService;
import com.example.du_an.service.ICustomerDtoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "CustomerController", value = "/customer")
public class CustomerController extends HelloServlet {
    ICustomerDtoService customerDtoService = new CustomerDtoService();

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "list":
                List<CustomerDto> customerDtoList = customerDtoService.findAll();
                System.out.println(customerDtoList);
                request.setAttribute("customerDtoList", customerDtoList);
                try {
                    request.getRequestDispatcher("views/customer/list.jsp").forward(request, response);
                } catch (ServletException e) {
                    e.printStackTrace();
                }
                break;
        }

    }
}
