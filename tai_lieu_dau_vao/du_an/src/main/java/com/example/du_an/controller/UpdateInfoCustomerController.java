package com.example.du_an.controller;

import com.example.du_an.entity.Account;
import com.example.du_an.entity.Customer;
import com.example.du_an.service.AccountService;
import com.example.du_an.service.CustomerService;
import com.example.du_an.service.IAccountService;
import com.example.du_an.service.ICustomerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.time.LocalDate;
import java.time.Period;

@WebServlet(name = "UpdateInfoCustomerController", value = "/update")
public class UpdateInfoCustomerController extends HttpServlet {
    ICustomerService customerService = new CustomerService();
    IAccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idAccount = Integer.parseInt(req.getParameter("id"));
        Account account = accountService.getAccountById(idAccount);
        Customer customer = customerService.findByAccountId(idAccount);
        req.setAttribute("customer", customer);
        req.setAttribute("account", account);
        req.getRequestDispatcher("views/user/update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int accountId = Integer.parseInt(req.getParameter("accountId"));
        int customerId = Integer.parseInt(req.getParameter("customerId"));
        String fullName = req.getParameter("fullName");
        String citizenNumber = req.getParameter("citizenNumber");
        String phoneNumber = req.getParameter("phoneNumber");
        String address = req.getParameter("address");
        String email = req.getParameter("email");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        Customer customer = new Customer(accountId, customerId, fullName, citizenNumber, phoneNumber, address, email, dob);
        String password = req.getParameter("password");
        String username = req.getParameter("username");
        Account.Role role = Account.Role.valueOf(req.getParameter("role"));
        LocalDate currentDate = LocalDate.now();
        int years = Period.between(dob, currentDate).getYears();

        req.setAttribute("customer", customer);
        Account account = new Account(accountId, username, password, role);
        req.setAttribute("account", account);

        if (years < 18) {
            req.setAttribute("errorMessageAge", "Ngày sinh phải đủ 18 tuổi");
            req.getRequestDispatcher("views/user/update.jsp").forward(req, resp);
            return;
        } else if(password.length() < 6) {
            req.setAttribute("errorMessage", "Mật khẩu phải đủ 6 ký tự");
            req.getRequestDispatcher("views/user/update.jsp").forward(req, resp);
            return;
        }

        boolean updateCustomer = customerService.update(customer);
        boolean updateAccount = accountService.update(account);
        HttpSession session = req.getSession();

        if (updateCustomer && updateAccount) {
            session.setAttribute("toastMessage", "Cập nhật thông tin thành công!");
            session.setAttribute("toastType", "success");
        } else {
            session.setAttribute("toastMessage", "Cập nhật thất bại. Vui lòng thử lại!");
            session.setAttribute("toastType", "danger");
        }

        try {
            resp.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();

        }


    }
}
