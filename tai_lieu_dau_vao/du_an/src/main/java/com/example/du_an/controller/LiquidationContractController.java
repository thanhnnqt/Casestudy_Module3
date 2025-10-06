package com.example.du_an.controller;

import com.example.du_an.dto.LiquidationContractDto;
import com.example.du_an.dto.LiquidationProductDto;
import com.example.du_an.entity.Customer;
import com.example.du_an.entity.Employee; // Thêm import Employee
import com.example.du_an.entity.LiquidationContract;
import com.example.du_an.entity.Product; // Thêm import Product
import com.example.du_an.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "LiquidationContractController", value = "/liquidation-contract")
public class LiquidationContractController extends HttpServlet {

    private final ILiquidationContractService liquidationService = new LiquidationContractService();
    private final ICustomerService customerService = new CustomerService();
    private final IProductService productService = new ProductService();
    private final IEmployeeService employeeService = new EmployeeService(); // Thêm service cho nhân viên
    private final ILiquidationProductService liquidationProductService = new LiquidationProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create":
                showCreateForm(req, resp);
                break;
            case "checkCustomer":
                checkCustomerAndShowForm(req, resp);
                break;
            case "delete":
                deleteContract(req, resp);
                break;
            default:
                listContracts(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create":
                createContract(req, resp);
                break;
            default:
                listContracts(req, resp);
        }
    }

    private void listContracts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String customerName = req.getParameter("full_name");
        String productName = req.getParameter("product_name");

        List<LiquidationContract> contracts;
        if ((customerName != null && !customerName.isEmpty()) || (productName != null && !productName.isEmpty())) {
            contracts = liquidationService.search(customerName, productName);
        } else {
            contracts = liquidationService.findAll();
        }
        req.setAttribute("liquidationContracts", contracts);
        req.setAttribute("customerName", customerName);
        req.setAttribute("productName", productName);
        req.getRequestDispatcher("views/liquidation_contract/list.jsp").forward(req, resp);
    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy danh sách nhân viên và sản phẩm để hiển thị trên form
        List<Employee> employeeList = employeeService.getAllEmployees();
        List<Product> productList = productService.findByStatus("Thanh lý");

        req.setAttribute("employees", employeeList);
        req.setAttribute("products", productList);
        req.getRequestDispatcher("views/liquidation_contract/add.jsp").forward(req, resp);
    }

    private void checkCustomerAndShowForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phoneOrCCCD = req.getParameter("phoneOrCCCD");
        Customer customer = null;
        if (phoneOrCCCD != null && !phoneOrCCCD.trim().isEmpty()) {
            customer = customerService.findByPhoneOrCCCD(phoneOrCCCD.trim());
        }

        // Vẫn cần gửi danh sách nhân viên và sản phẩm khi kiểm tra xong
        List<Employee> employeeList = employeeService.getAllEmployees();
        List<LiquidationProductDto> contractList = liquidationService.findProduct();

        req.setAttribute("existingCustomer", customer);
        req.setAttribute("phoneOrCCCD", phoneOrCCCD);
        req.setAttribute("employees", employeeList);
        req.setAttribute("products", contractList);
        req.getRequestDispatcher("views/liquidation_contract/add.jsp").forward(req, resp);
    }

    private void createContract(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int customerId;

            String customerIdParam = req.getParameter("customerId");
            if (customerIdParam != null && !customerIdParam.isEmpty()) {
                customerId = Integer.parseInt(customerIdParam);
            } else {
                String fullName = req.getParameter("fullName").trim();
                String citizenNumber = req.getParameter("citizenNumber").trim();
                String phoneNumber = req.getParameter("phoneNumber").trim();
                String address = req.getParameter("address");
                String email = req.getParameter("email");
                LocalDate dob = req.getParameter("dob") != null && !req.getParameter("dob").isEmpty()
                        ? LocalDate.parse(req.getParameter("dob"))
                        : null;
                Customer customer = new Customer(0, fullName, citizenNumber, phoneNumber, address, email, dob);
                customerService.createCustomer(customer);
                customerId = customer.getCustomerId();
            }

            LocalDate liquidationDate = LocalDate.parse(req.getParameter("liquidation_date"));
            double liquidationPrice = Double.parseDouble(req.getParameter("price"));
            // Lấy ID từ dropdown list
            int employeeId = Integer.parseInt(req.getParameter("employee_id"));
            int productId = Integer.parseInt(req.getParameter("product_id"));

            LiquidationContract contract = new LiquidationContract(liquidationDate, liquidationPrice, customerId, employeeId, productId);
            liquidationService.add(contract);

            productService.updateStatusToLiquidated(productId);

            resp.sendRedirect("/liquidation-contract");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Lỗi khi tạo hợp đồng: " + e.getMessage());
            req.getRequestDispatcher("views/liquidation_contract/add.jsp").forward(req, resp);
        }
    }

    private void deleteContract(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("liquidation_contract_id").trim());
        liquidationService.delete(id);
        resp.sendRedirect("/liquidation-contract");
    }
}