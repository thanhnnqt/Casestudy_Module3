package com.example.du_an.controller;

import com.example.du_an.dto.EmployeeDto;
import com.example.du_an.entity.Account;
import com.example.du_an.entity.Employee;
import com.example.du_an.service.EmployeeService;
import com.example.du_an.service.IEmployeeService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "EmployeeController", value = "/employees")
public class EmployeeController extends HttpServlet {
    private final IEmployeeService employeeService = new EmployeeService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                showAddForm(req, resp);
                break;
            case "edit":
                showEditForm(req, resp);
                break;
            case "delete":
                deleteEmployee(req, resp);
                break;
            default:
                listEmployees(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "";
        }
        switch (action) {
            case "add":
                addEmployee(req, resp);
                break;
            case "edit":
                updateEmployee(req, resp);
                break;
            default:
                listEmployees(req, resp);
        }
    }

    private void listEmployees(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchKeyword = req.getParameter("searchKeyword");
        List<EmployeeDto> employeeList;

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {

            employeeList = employeeService.search(searchKeyword.trim());
        } else {

            employeeList = employeeService.findAll();
        }

        req.setAttribute("employeeList", employeeList);
        req.setAttribute("searchKeyword", searchKeyword); // Gửi lại từ khóa để hiển thị trên ô tìm kiếm
        req.getRequestDispatcher("views/employee/list.jsp").forward(req, resp);
    }

    private void showAddForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("views/employee/add.jsp").forward(req, resp);
    }

    private void showEditForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Employee employee = employeeService.findById(id);
        req.setAttribute("employee", employee);
        req.getRequestDispatcher("views/employee/edit.jsp").forward(req, resp);
    }

    private void addEmployee(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String fullName = req.getParameter("fullName");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        String phoneNumber = req.getParameter("phoneNumber");
        BigDecimal salary = new BigDecimal(req.getParameter("salary"));
        String email = req.getParameter("email");
        String citizenNumber = req.getParameter("citizenNumber");
        String userName = req.getParameter("userName");
        String password = req.getParameter("password");

        Account account = new Account(userName, password, "STAFF");
        Employee employee = new Employee(0, fullName, dob, phoneNumber, salary, email, citizenNumber);

        employeeService.add(employee, account);
        resp.sendRedirect("/employees");
    }

    private void updateEmployee(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("employeeId"));
        String fullName = req.getParameter("fullName");
        LocalDate dob = LocalDate.parse(req.getParameter("dob"));
        String phoneNumber = req.getParameter("phoneNumber");
        BigDecimal salary = new BigDecimal(req.getParameter("salary"));
        String email = req.getParameter("email");
        String citizenNumber = req.getParameter("citizenNumber");

        Employee employee = employeeService.findById(id);
        if (employee != null) {
            employee.setFullName(fullName);
            employee.setDob(dob);
            employee.setPhoneNumber(phoneNumber);
            employee.setSalary(salary);
            employee.setEmail(email);
            employee.setCitizenNumber(citizenNumber);
            employeeService.update(employee);
        }
        resp.sendRedirect("/employees");
    }

    private void deleteEmployee(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        employeeService.delete(id);
        resp.sendRedirect("/employees");
    }
}
