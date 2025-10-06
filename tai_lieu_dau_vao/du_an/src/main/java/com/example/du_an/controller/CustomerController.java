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

import java.io.IOException;
import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
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
                for (int i = 0; i < customerDtoList.size(); i++) {
                    LocalDate start = customerDtoList.get(i).getPawn_date();
                    LocalDate end = LocalDate.now();
                    long monthsBetween = ChronoUnit.MONTHS.between(start, end);
                    if(monthsBetween >=6){
                        customerDtoList.remove(i);
                    }
                }
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
