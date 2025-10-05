package com.example.du_an.controller;

import com.example.du_an.dto.ChartDto;
import com.example.du_an.service.ChartDtoService;
import com.example.du_an.service.IChartDtoService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "ChartController", value = "/chart")
public class ChartController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        IChartDtoService chartDtoService = new ChartDtoService();
        List<ChartDto> chartDtoList = chartDtoService.findAll();
        req.setAttribute("chartDtoList", chartDtoList);
        req.getRequestDispatcher("views/chart.jsp").forward(req, resp);
    }
}
