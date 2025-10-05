package com.example.du_an.controller;

import com.example.du_an.entity.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "TestLoginController", value = "/test-login")
public class TestLoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Lấy customerId bạn muốn test từ URL
            int customerIdToTest = Integer.parseInt(req.getParameter("customerId"));

            // THAY THẾ CHO VIỆC GỌI REPOSITORY:
            // Tự tạo một đối tượng Customer giả với thông tin mẫu để test.
            Customer testCustomer = new Customer();
            testCustomer.setId(customerIdToTest);
            testCustomer.setAccountId(customerIdToTest + 10); // ID tài khoản giả
            testCustomer.setFullName("Khách Hàng Test " + customerIdToTest);
            testCustomer.setCitizenNumber("1234567890" + customerIdToTest);
            testCustomer.setPhoneNumber("0987654321");
            testCustomer.setAddress("Địa chỉ Test");
            testCustomer.setEmail("test" + customerIdToTest + "@example.com");
            testCustomer.setDob(LocalDate.of(1995, 5, 20));

            // Tạo session và lưu đối tượng Customer giả vào
            HttpSession session = req.getSession();
            session.setAttribute("loggedInCustomer", testCustomer);

            // Chuyển hướng đến trang cần test
            resp.sendRedirect("/customer-history");

        } catch (NumberFormatException e) {
            resp.getWriter().println("<h1>Vui lòng cung cấp customerId hợp lệ. Ví dụ: /test-login?customerId=1</h1>");
        }
    }
}