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
import java.io.IOException;
import java.time.LocalDate;

@WebServlet(name = "CheckCustomerController", urlPatterns = "/check-customer")
public class CheckCustomerController extends HttpServlet {

    private final ICustomerService customerService = new CustomerService();
    private final IAccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || !action.equals("check")) {
            request.getRequestDispatcher("views/customer/check_customer.jsp").forward(request, response);
            return;
        }

        String phoneOrCCCD = request.getParameter("phoneOrCCCD");
        if (phoneOrCCCD == null || phoneOrCCCD.trim().isEmpty()) {
            request.setAttribute("error", "Số điện thoại hoặc CCCD bắt buộc");
            request.getRequestDispatcher("views/customer/check_customer.jsp").forward(request, response);
            return;
        }

        try {
            Customer customer = customerService.findByPhoneOrCCCD(phoneOrCCCD.trim());
            request.setAttribute("existingCustomer", customer);
            request.getRequestDispatcher("views/customer/check_customer.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Lỗi khi kiểm tra khách hàng: " + e.getMessage());
            request.getRequestDispatcher("views/customer/check_customer.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null || !action.equals("create")) {
            request.getRequestDispatcher("views/customer/check_customer.jsp").forward(request, response);
            return;
        }

        try {
            String phoneOrCCCD = request.getParameter("phoneOrCCCD");
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String fullName = request.getParameter("fullName");
            String citizenNumber = request.getParameter("citizenNumber");
            String phoneNumber = request.getParameter("phoneNumber");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String dobStr = request.getParameter("dob");

            System.out.println("Received username: " + username);
            System.out.println("Received password: [HIDDEN]");
            System.out.println("Received fullName: " + fullName);
            System.out.println("Received citizenNumber: " + citizenNumber);
            System.out.println("Received phoneNumber: " + phoneNumber);

            // Kiểm tra các trường bắt buộc
            if (username == null || username.trim().isEmpty()) {
                throw new IllegalArgumentException("Username không được để trống");
            }
            if (password == null || password.trim().isEmpty()) {
                throw new IllegalArgumentException("Mật khẩu không được để trống");
            }
            if (password.trim().length() < 6) {
                throw new IllegalArgumentException("Mật khẩu phải có ít nhất 6 ký tự");
            }
            if (fullName == null || fullName.trim().isEmpty()) {
                throw new IllegalArgumentException("Họ tên không được để trống");
            }
            if (citizenNumber == null || citizenNumber.trim().isEmpty()) {
                throw new IllegalArgumentException("CCCD không được để trống");
            }
            if (phoneNumber == null || phoneNumber.trim().isEmpty()) {
                throw new IllegalArgumentException("Số điện thoại không được để trống");
            }

            // Tạo tài khoản
            Account account = new Account(username.trim(), password.trim(), Account.Role.USER);
            System.out.println("Account created with username: " + account.getUsername() + ", passwordHash: [HIDDEN], role: " + account.getRole());
            accountService.createAccount(account);
            if (account.getAccountId() <= 0) {
                throw new RuntimeException("Không thể lấy ID tài khoản sau khi tạo");
            }
            System.out.println("Created accountId: " + account.getAccountId());

            // Tạo khách hàng
            Customer customer = new Customer(
                    account.getAccountId(),
                    fullName.trim(),
                    citizenNumber.trim(),
                    phoneNumber.trim(),
                    address != null && !address.trim().isEmpty() ? address.trim() : null,
                    email != null && !email.trim().isEmpty() ? email.trim() : null,
                    dobStr != null && !dobStr.isEmpty() ? LocalDate.parse(dobStr) : null
            );
            customerService.createCustomer(customer);
            if (customer.getCustomerId() <= 0) {
                throw new RuntimeException("Không thể lấy ID khách hàng sau khi tạo");
            }
            System.out.println("Created customerId: " + customer.getCustomerId());

            // Chuyển hướng đến trang tạo hợp đồng
            response.sendRedirect(request.getContextPath() + "/pawn-contracts?action=create&customerId=" + customer.getCustomerId());
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi tạo khách hàng: " + e.getMessage());
            request.setAttribute("phoneOrCCCD", request.getParameter("phoneOrCCCD"));
            request.setAttribute("username", request.getParameter("username"));
            request.setAttribute("fullName", request.getParameter("fullName"));
            request.setAttribute("citizenNumber", request.getParameter("citizenNumber"));
            request.setAttribute("phoneNumber", request.getParameter("phoneNumber"));
            request.setAttribute("address", request.getParameter("address"));
            request.setAttribute("email", request.getParameter("email"));
            request.setAttribute("dob", request.getParameter("dob"));
            request.getRequestDispatcher("views/customer/check_customer.jsp").forward(request, response);
        }
    }
}