package com.example.du_an.controller;

import com.example.du_an.entity.LiquidationContract;
import com.example.du_an.service.ILiquidationContractService;
import com.example.du_an.service.LiquidationContractService;
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
    ILiquidationContractService liquidationService = new LiquidationContractService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "create":
                showCreateForm(req, resp);
                break;
            case "delete":
                deleteProduct(req, resp);
                break;
            default:
                listProducts(req, resp);
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
            case "create":
                createProduct(req, resp);
                break;
            default:
                listProducts(req, resp);
                break;
        }
    }

    private void listProducts(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String customerName = req.getParameter("full_name");
        String productName = req.getParameter("product_name");

        List<LiquidationContract> liquidationContracts;
        if ((customerName != null && !customerName.isEmpty()) ||
                (productName != null && !productName.isEmpty())) {
            liquidationContracts = liquidationService.search(customerName, productName);
        } else {
            liquidationContracts = liquidationService.findAll();
        }
        req.setAttribute("liquidationContracts", liquidationContracts);
        req.setAttribute("customerName", customerName);
        req.setAttribute("productName", productName);
        req.getRequestDispatcher("views/liquidation_contract/list.jsp").forward(req, resp);
    }

    private void showCreateForm(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<LiquidationContract> liquidationContracts = liquidationService.findAll();
        req.setAttribute("liquidationContracts", liquidationContracts);
        req.getRequestDispatcher("views/liquidation_contract/add.jsp").forward(req, resp);
    }

    private void createProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        LocalDate liquidationDate = LocalDate.parse(req.getParameter("liquidation_date"));
        double liquidationPrice = Double.parseDouble(req.getParameter("price"));
        int customerId = Integer.parseInt(req.getParameter("customer_id"));
        int employeeId = Integer.parseInt(req.getParameter("employee_id"));
        int productId = Integer.parseInt(req.getParameter("product_id"));
        LiquidationContract liquidationContract = new LiquidationContract(liquidationDate, liquidationPrice, customerId, employeeId, productId);
        liquidationService.add(liquidationContract);
        resp.sendRedirect("/liquidation-contract");
    }

    private void deleteProduct(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        int id = Integer.parseInt(req.getParameter("liquidation_contract_id").trim());
        liquidationService.delete(id);
        resp.sendRedirect("/liquidation-contract");
    }
}
