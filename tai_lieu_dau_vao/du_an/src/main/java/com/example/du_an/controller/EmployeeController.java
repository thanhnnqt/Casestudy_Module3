package com.example.du_an.controller;

import com.example.du_an.dto.EmployeeDto;
import com.example.du_an.entity.Account;
import com.example.du_an.entity.Employee;
import com.example.du_an.entity.Login;
import com.example.du_an.repository.ILoginRepository;
import com.example.du_an.repository.LoginRepository;
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
import java.time.Period;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "EmployeeController", value = "/employees")
public class EmployeeController extends HttpServlet {
    private final IEmployeeService employeeService = new EmployeeService();
    private final LoginRepository loginRepository = new LoginRepository();

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

            employeeList = employeeService.findAlls();
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

        // Lấy thêm thông tin account để hiển thị username
        Login account = loginRepository.findById(employee.getAccountId());

        req.setAttribute("employee", employee);
        req.setAttribute("account", account); // Gửi cả account sang view
        req.getRequestDispatcher("views/employee/edit.jsp").forward(req, resp);
    }

    private void addEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();

        String fullName = req.getParameter("fullName");
        String dobStr = req.getParameter("dob");
        String salaryStr = req.getParameter("salary");
        String username = req.getParameter("userName");

        // 1. Kiểm tra Lương > 0
        BigDecimal salary = BigDecimal.ZERO;
        try {
            salary = new BigDecimal(salaryStr);
            if (salary.compareTo(BigDecimal.ZERO) <= 0) {
                errors.add("Lương phải là một số lớn hơn 0.");
            }
        } catch (NumberFormatException e) {
            errors.add("Lương phải là một con số hợp lệ.");
        }

        // 2. Kiểm tra Tuổi >= 18
        LocalDate dob = null;
        try {
            dob = LocalDate.parse(dobStr);
            if (Period.between(dob, LocalDate.now()).getYears() < 18) {
                errors.add("Nhân viên phải đủ 18 tuổi.");
            }
        } catch (Exception e) {
            errors.add("Ngày sinh không hợp lệ.");
        }

        // 3. Kiểm tra Tên đăng nhập đã tồn tại
        if (username != null && !username.trim().isEmpty()) {
            if (loginRepository.findByUsername(username.trim()) != null) {
                errors.add("Tên đăng nhập '" + username + "' đã tồn tại.");
            }
        } else {
            errors.add("Tên đăng nhập không được để trống.");
        }

        // Nếu có lỗi, trả về form add với thông báo lỗi và dữ liệu đã nhập
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("fullName_val", fullName);
            req.setAttribute("dob_val", dobStr);
            req.setAttribute("phoneNumber_val", req.getParameter("phoneNumber"));
            req.setAttribute("salary_val", salaryStr);
            req.setAttribute("email_val", req.getParameter("email"));
            req.setAttribute("citizenNumber_val", req.getParameter("citizenNumber"));
            req.setAttribute("username_val", username);
            req.getRequestDispatcher("views/employee/add.jsp").forward(req, resp);
            return;
        }

        // Nếu không có lỗi, tiến hành thêm mới
        String phoneNumber = req.getParameter("phoneNumber");
        String email = req.getParameter("email");
        String citizenNumber = req.getParameter("citizenNumber");
        String password = req.getParameter("password");

        Login login = new Login();
        login.setUsername(username);
        login.setPassword(password); // Nên mã hóa (hash) mật khẩu trước khi lưu
        login.setRole("STAFF");

        Employee employee = new Employee(0, fullName, dob, phoneNumber, salary, email, citizenNumber);

        employeeService.add(employee, login);

        resp.sendRedirect("/employees");
    }

    private void updateEmployee(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<String> errors = new ArrayList<>();
        int employeeId = Integer.parseInt(req.getParameter("employeeId"));

        String dobStr = req.getParameter("dob");
        String salaryStr = req.getParameter("salary");

        // --- Bắt đầu Validation ---

        // 1. Kiểm tra Lương > 0
        BigDecimal salary = BigDecimal.ZERO;
        try {
            salary = new BigDecimal(salaryStr);
            if (salary.compareTo(BigDecimal.ZERO) <= 0) {
                errors.add("Lương phải là một số lớn hơn 0.");
            }
        } catch (NumberFormatException e) {
            errors.add("Lương phải là một con số hợp lệ.");
        }

        // 2. Kiểm tra Tuổi >= 18
        LocalDate dob = null;
        try {
            dob = LocalDate.parse(dobStr);
            if (Period.between(dob, LocalDate.now()).getYears() < 18) {
                errors.add("Nhân viên phải đủ 18 tuổi.");
            }
        } catch (Exception e) {
            errors.add("Ngày sinh không hợp lệ.");
        }

        // --- Kết thúc Validation ---

        String fullName = req.getParameter("fullName");
        String phoneNumber = req.getParameter("phoneNumber");
        String email = req.getParameter("email");
        String citizenNumber = req.getParameter("citizenNumber");

        // Tạo đối tượng Employee tạm từ dữ liệu người dùng nhập để gửi lại form nếu có lỗi
        Employee submittedEmployee = new Employee();
        submittedEmployee.setEmployeeId(employeeId);
        submittedEmployee.setFullName(fullName);
        submittedEmployee.setDob(dob);
        submittedEmployee.setPhoneNumber(phoneNumber);
        submittedEmployee.setSalary(salary);
        submittedEmployee.setEmail(email);
        submittedEmployee.setCitizenNumber(citizenNumber);

        // Nếu có lỗi, trả về form edit với thông báo lỗi và dữ liệu đã nhập
        if (!errors.isEmpty()) {
            req.setAttribute("errors", errors);
            req.setAttribute("employee", submittedEmployee);

            Employee originalEmployee = employeeService.findById(employeeId);
            Login account = loginRepository.findById(originalEmployee.getAccountId());
            req.setAttribute("account", account);

            req.getRequestDispatcher("views/employee/edit.jsp").forward(req, resp);
            return;
        }

        // Nếu không có lỗi, tiến hành cập nhật
        employeeService.update(submittedEmployee);
        resp.sendRedirect("/employees");
    }

    private void deleteEmployee(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        employeeService.delete(id);
        resp.sendRedirect("/employees");
    }
}
