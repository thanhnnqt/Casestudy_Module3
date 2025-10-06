package com.example.du_an.controller;

import com.example.du_an.dto.LiquidationProductDto;
import com.example.du_an.service.ILiquidationProductService;
import com.example.du_an.service.LiquidationProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "LiquidationProductController", value = "/liquidation-products")
public class LiquidationProductController extends HttpServlet {
    private final ILiquidationProductService liquidationProductService = new LiquidationProductService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<LiquidationProductDto> productList = liquidationProductService.findAllLiquidationProducts();
        req.setAttribute("productList", productList);
        req.getRequestDispatcher("views/liquition_product/list.jsp").forward(req, resp);
    }
}
