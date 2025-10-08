package com.example.du_an.controller;

import com.example.du_an.dto.PawnContractDto;
import com.example.du_an.entity.Customer;
import com.example.du_an.entity.Employee;
import com.example.du_an.entity.PawnContract;
import com.example.du_an.entity.Product;
import com.example.du_an.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "PawnContractController", urlPatterns = "/pawn-contracts")
public class PawnContractController extends HttpServlet {

    private final IPawnContractService pawnContractService = new PawnContractService();
    private final ICustomerService customerService = new CustomerService();
    private final IEmployeeService employeeService = new EmployeeService();
    private final IProductService productService = new ProductService();
    private final IAccountService accountService = new AccountService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deletePawnContract(request, response);
                break;
            case "confirmLiquidation":
                confirmLiquidation(request, response);
                break;
            case "detail":
                showDetailPawnContract(request, response);
                break;
            default:
                listPawnContracts(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "";

        switch (action) {
            case "create":
                createPawnContract(request, response);
                break;
            case "edit":
                updatePawnContract(request, response);
                break;
            default:
                listPawnContracts(request, response);
                break;
        }
    }

    private void listPawnContracts(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        productService.updateProductStatusForOverdueContracts();

        String customerName = request.getParameter("customerName");
        String employeeName = request.getParameter("employeeName");
        String productName = request.getParameter("productName");
        String status = request.getParameter("status");

        int page = 1;
        int recordsPerPage = 5;
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.trim().isEmpty()) {
            try {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        List<PawnContractDto> contracts;
        int totalRecords;

        boolean hasSearch = (customerName != null && !customerName.trim().isEmpty()) ||
                (employeeName != null && !employeeName.trim().isEmpty()) ||
                (productName != null && !productName.trim().isEmpty()) ||
                (status != null && !status.trim().isEmpty());

        if (hasSearch) {
            contracts = pawnContractService.search(customerName, employeeName, productName, status);
            totalRecords = contracts.size();
        } else {
            totalRecords = pawnContractService.countPawnContract();
            int offset = (page - 1) * recordsPerPage;
            contracts = pawnContractService.findAll(offset, recordsPerPage);
        }

        int totalPages = (int) Math.ceil((double) totalRecords / recordsPerPage);

        request.setAttribute("pawnContracts", contracts);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("customerName", customerName);
        request.setAttribute("employeeName", employeeName);
        request.setAttribute("productName", productName);
        request.setAttribute("status", status);

        request.getRequestDispatcher("views/pawn_contract/list.jsp").forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Employee> employees = employeeService.getAllEmployees();
        request.setAttribute("employees", employees);

        String customerIdStr = request.getParameter("customerId");
        if (customerIdStr != null && !customerIdStr.trim().isEmpty()) {
            try {
                int customerId = Integer.parseInt(customerIdStr);
                Customer customer = customerService.findById(customerId);
                if (customer != null) {
                    request.setAttribute("existingCustomer", customer);
                } else {
                    request.setAttribute("error", "Không tìm thấy khách hàng với ID: " + customerId);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Mã khách hàng không hợp lệ");
            }
        }

        request.getRequestDispatcher("views/pawn_contract/add.jsp").forward(request, response);
    }

    // Trong file PawnContractController.java
    private void createPawnContract(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> errors = new ArrayList<>();
        // Lấy trước các tham số để có thể gửi lại form nếu lỗi
        String customerIdStr = request.getParameter("customerId");
        String employeeIdStr = request.getParameter("employeeId");
        String productName = request.getParameter("productName");
        String description = request.getParameter("description");
        String productValueStr = request.getParameter("productValue");
        String pawnAmountStr = request.getParameter("pawnAmount");
        String interestRateStr = request.getParameter("interestRate");
        String pawnDateStr = request.getParameter("pawnDate");
        String dueDateStr = request.getParameter("dueDate");

        try {
            // --- Bắt đầu Parse và Validate ---
            int employeeId = parseIntParameter(employeeIdStr, "Mã nhân viên không hợp lệ");
            int customerId = parseIntParameter(customerIdStr, "Mã khách hàng không hợp lệ");
            BigDecimal productValue = parseBigDecimalParameter(productValueStr, "Giá trị định giá không hợp lệ");
            BigDecimal pawnAmount = parseBigDecimalParameter(pawnAmountStr, "Số tiền cầm không hợp lệ");
            LocalDate pawnDate = parseLocalDateParameter(pawnDateStr, "Ngày cầm không hợp lệ");
            LocalDate dueDate = parseLocalDateParameter(dueDateStr, "Ngày đến hạn không hợp lệ");

            if (productName == null || productName.trim().isEmpty()) {
                errors.add("Tên sản phẩm không được để trống.");
            }
            if (pawnAmount.compareTo(productValue) > 0) {
                errors.add("Số tiền cầm không được lớn hơn giá trị định giá của sản phẩm.");
            }
            if (pawnAmount.compareTo(BigDecimal.ZERO) <= 0) {
                errors.add("Số tiền cầm phải lớn hơn 0.");
            }
            if (dueDate.isBefore(pawnDate)) {
                errors.add("Ngày đến hạn phải sau ngày cầm đồ.");
            }

            // --- Kiểm tra nếu có lỗi thì quay lại form ---
            if (!errors.isEmpty()) {
                throw new IllegalArgumentException(errors.get(0)); // Ném lỗi đầu tiên để catch block xử lý
            }

            // --- Nếu không có lỗi, tiến hành tạo mới ---
            Customer customer = customerService.findById(customerId);
            if (customer == null) {
                throw new IllegalArgumentException("Khách hàng không tồn tại với ID: " + customerId);
            }

            // 1. Tạo sản phẩm với giá trị định giá
            Product product = new Product();
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : null);
            product.setPawnPrice(productValue); // Lưu giá trị định giá
            product.setStatus(Product.Status.DANG_CAM);
            productService.create(product);

            if (product.getProductId() <= 0) {
                throw new RuntimeException("Không thể tạo sản phẩm mới.");
            }

            // 2. Tạo hợp đồng với số tiền cầm
            PawnContract contract = new PawnContract();
            contract.setCustomerId(customerId);
            contract.setEmployeeId(employeeId);
            contract.setProductId(product.getProductId());
            contract.setPawnDate(pawnDate);
            contract.setDueDate(dueDate);
            contract.setPawnPrice(pawnAmount); // Lưu số tiền cầm
            contract.setInterestRate(parseBigDecimalParameter(interestRateStr, "Lãi suất không hợp lệ"));

            pawnContractService.add(contract);

            request.getSession().setAttribute("flashSuccess", "🎉 Tạo hợp đồng thành công!");
            response.sendRedirect(request.getContextPath() + "/pawn-contracts?action=create");

        } catch (Exception e) {
            e.printStackTrace();
            // Nếu có lỗi, gửi lại toàn bộ dữ liệu người dùng đã nhập
            request.setAttribute("error", e.getMessage());
            request.setAttribute("errors", errors); // Gửi cả danh sách lỗi chi tiết

            request.setAttribute("customerId", customerIdStr);
            request.setAttribute("employeeId", employeeIdStr);
            request.setAttribute("productName", productName);
            request.setAttribute("description", description);
            request.setAttribute("productValue", productValueStr);
            request.setAttribute("pawnAmount", pawnAmountStr);
            request.setAttribute("interestRate", interestRateStr);
            request.setAttribute("pawnDate", pawnDateStr);
            request.setAttribute("dueDate", dueDateStr);

            showCreateForm(request, response);
        }
    }
    // Trong file: PawnContractController.java
    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));

            // Lấy thông tin hợp đồng chính (đã có tên khách hàng, nhân viên, sản phẩm)
            PawnContractDto contract = pawnContractService.findById(id);
            if (contract == null) {
                response.sendRedirect(request.getContextPath() + "/pawn-contracts");
                return;
            }

            // Lấy thông tin chi tiết của sản phẩm để sửa mô tả, giá trị...
            Product product = productService.findById(contract.getProductId());

            // Lấy danh sách nhân viên để làm dropdown
            List<Employee> employees = employeeService.getAllEmployees();

            // Gửi tất cả dữ liệu cần thiết qua JSP
            request.setAttribute("contract", contract);
            request.setAttribute("product", product);
            request.setAttribute("employees", employees);

            request.getRequestDispatcher("views/pawn_contract/update.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pawn-contracts");
        }
    }
    private void updatePawnContract(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // --- Cập nhật thông tin sản phẩm ---
            int productId = parseIntParameter(request.getParameter("productId"), "Mã sản phẩm không hợp lệ");
            Product product = productService.findById(productId);
            if (product != null) {
                // ✅ LẤY THÊM TÊN SẢN PHẨM TỪ FORM
                product.setProductName(request.getParameter("productName"));
                product.setDescription(request.getParameter("description"));
                product.setPawnPrice(parseBigDecimalParameter(request.getParameter("productValue"), "Giá trị định giá không hợp lệ"));
                productService.update(product);
            } else {
                throw new IllegalArgumentException("Không tìm thấy sản phẩm để cập nhật.");
            }

            // --- Cập nhật thông tin hợp đồng (giữ nguyên) ---
            int contractId = parseIntParameter(request.getParameter("id"), "Mã hợp đồng không hợp lệ");
            PawnContract contract = new PawnContract();
            contract.setPawnContractId(contractId);
            contract.setCustomerId(parseIntParameter(request.getParameter("customerId"), "Mã khách hàng không hợp lệ"));
            contract.setEmployeeId(parseIntParameter(request.getParameter("employeeId"), "Mã nhân viên không hợp lệ"));
            contract.setProductId(productId);
            contract.setPawnPrice(parseBigDecimalParameter(request.getParameter("pawnAmount"), "Số tiền cầm không hợp lệ"));
            contract.setInterestRate(parseBigDecimalParameter(request.getParameter("interestRate"), "Lãi suất không hợp lệ"));
            contract.setPawnDate(parseLocalDateParameter(request.getParameter("pawnDate"), "Ngày cầm không hợp lệ"));
            contract.setDueDate(parseLocalDateParameter(request.getParameter("dueDate"), "Ngày đến hạn không hợp lệ"));
            String returnDateStr = request.getParameter("returnDate");
            if(returnDateStr != null && !returnDateStr.isEmpty()){
                contract.setReturnDate(LocalDate.parse(returnDateStr));
            }

            pawnContractService.update(contract);

            request.getSession().setAttribute("flashSuccess", "Cập nhật hợp đồng thành công!");
            response.sendRedirect(request.getContextPath() + "/pawn-contracts");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi cập nhật: " + e.getMessage());
            showEditForm(request, response);
        }
    }
    private void deletePawnContract(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            pawnContractService.delete(id);
            request.getSession().setAttribute("flashSuccess", "Xóa hợp đồng thành công!");
        } catch (Exception e) {
            request.getSession().setAttribute("flashError", "Lỗi khi xóa hợp đồng.");
        }
        response.sendRedirect(request.getContextPath() + "/pawn-contracts");
    }

    private void confirmLiquidation(HttpServletRequest request, HttpServletResponse response)
            throws IOException, ServletException {
        try {
            int contractId = Integer.parseInt(request.getParameter("id"));
            PawnContractDto contract = pawnContractService.findById(contractId);

            if (contract == null) {
                throw new IllegalArgumentException("Hợp đồng không tồn tại");
            }

            if ("CO_THE_THANH_LY".equals(contract.getStatus())) {
                if (productService.updateStatusToLiquidated(contract.getProductId())) {
                    request.getSession().setAttribute("flashSuccess", "✅ Sản phẩm đã được chuyển sang trạng thái Thanh lý!");
                } else {
                    throw new RuntimeException("Không thể cập nhật trạng thái sản phẩm.");
                }
            } else {
                request.getSession().setAttribute("flashError", "Sản phẩm không ở trạng thái 'Có thể thanh lý'.");
            }
            response.sendRedirect(request.getContextPath() + "/pawn-contracts");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("flashError", "Lỗi khi thanh lý: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/pawn-contracts");
        }
    }

    private void showDetailPawnContract(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            PawnContractDto contract = pawnContractService.getDetail(id);
            request.setAttribute("contract", contract);
            request.getRequestDispatcher("views/pawn_contract/detail.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Không tìm thấy chi tiết hợp đồng.");
            request.getRequestDispatcher("views/pawn_contract/detail.jsp").forward(request, response);
        }
    }

    private int parseIntParameter(String value, String errorMessage) {
        if (value == null || value.trim().isEmpty()) throw new IllegalArgumentException(errorMessage);
        try {
            return Integer.parseInt(value.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(errorMessage);
        }
    }

    private BigDecimal parseBigDecimalParameter(String value, String errorMessage) {
        if (value == null || value.trim().isEmpty()) throw new IllegalArgumentException(errorMessage);
        try {
            return new BigDecimal(value.trim());
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException(errorMessage);
        }
    }

    private LocalDate parseLocalDateParameter(String value, String errorMessage) {
        if (value == null || value.trim().isEmpty()) throw new IllegalArgumentException(errorMessage);
        try {
            return LocalDate.parse(value.trim());
        } catch (Exception e) {
            throw new IllegalArgumentException(errorMessage);
        }
    }

}