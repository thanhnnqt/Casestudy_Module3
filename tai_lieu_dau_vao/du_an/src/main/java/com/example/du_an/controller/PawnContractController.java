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
    import java.util.List;

    @WebServlet(name = "PawnContractController", urlPatterns = "/pawn-contracts")
    public class PawnContractController extends HttpServlet {

        private final IPawnContractService pawnContractService = new PawnContractService();
        private final IAccountService accountService = new AccountService();
        private final ICustomerService customerService = new CustomerService();
        private final IEmployeeService employeeService = new EmployeeService();
        private final IProductService productService = new ProductService();

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
            String customerName = request.getParameter("customerName");
            String employeeName = request.getParameter("employeeName");
            String productName = request.getParameter("productName");

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
                    (productName != null && !productName.trim().isEmpty());

            if (hasSearch) {
                contracts = pawnContractService.search(customerName, employeeName, productName);
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

        private void createPawnContract(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            try {
                int employeeId = parseIntParameter(request.getParameter("employeeId"), "Mã nhân viên không hợp lệ");
                int customerId = parseIntParameter(request.getParameter("customerId"), "Mã khách hàng không hợp lệ");

                // Lưu các tham số để hiển thị lại nếu có lỗi
                request.setAttribute("employeeId", request.getParameter("employeeId"));
                request.setAttribute("pawnAmount", request.getParameter("pawnAmount"));
                request.setAttribute("interestRate", request.getParameter("interestRate"));
                request.setAttribute("pawnDate", request.getParameter("pawnDate"));
                request.setAttribute("dueDate", request.getParameter("dueDate"));
                request.setAttribute("productName", request.getParameter("productName"));
                request.setAttribute("description", request.getParameter("description"));
                request.setAttribute("productValue", request.getParameter("productValue"));

                // Kiểm tra khách hàng
                Customer customer = customerService.findById(customerId);
                if (customer == null) {
                    throw new IllegalArgumentException("Khách hàng không tồn tại");
                }

                // Tạo sản phẩm
                String productName = request.getParameter("productName");
                String description = request.getParameter("description");
                BigDecimal productValue = parseBigDecimalParameter(request.getParameter("productValue"), "Giá trị sản phẩm không hợp lệ");

                if (productName == null || productName.trim().isEmpty()) {
                    throw new IllegalArgumentException("Tên sản phẩm không được để trống");
                }

                Product product = new Product();
                product.setProductName(productName.trim());
                product.setDescription(description != null ? description.trim() : null);
                product.setPawnPrice(productValue);
                product.setStatus(Product.Status.DANG_CAM);

                productService.create(product);
                if (product.getProductId() <= 0) {
                    throw new RuntimeException("Không lấy được ID của sản phẩm vừa tạo");
                }

                // Lấy thông tin hợp đồng
                BigDecimal pawnPrice = parseBigDecimalParameter(request.getParameter("pawnAmount"), "Số tiền cầm không hợp lệ");
                BigDecimal interestRate = parseBigDecimalParameter(request.getParameter("interestRate"), "Lãi suất không hợp lệ");
                LocalDate pawnDate = parseLocalDateParameter(request.getParameter("pawnDate"), "Ngày cầm không hợp lệ");
                LocalDate dueDate = parseLocalDateParameter(request.getParameter("dueDate"), "Ngày đến hạn không hợp lệ");

                if (pawnPrice.compareTo(BigDecimal.ZERO) <= 0) {
                    throw new IllegalArgumentException("Số tiền cầm phải lớn hơn 0");
                }
                if (pawnDate.isBefore(LocalDate.now())) {
                    throw new IllegalArgumentException("Ngày cầm không được trước hôm nay");
                }
                if (!dueDate.isAfter(pawnDate)) {
                    throw new IllegalArgumentException("Ngày đến hạn phải sau ngày cầm");
                }

                // Tạo hợp đồng
                PawnContract contract = new PawnContract(
                        customer.getCustomerId(),
                        employeeId,
                        product.getProductId(),
                        pawnDate,
                        pawnPrice,
                        interestRate,
                        dueDate,
                        null
                );

                boolean success = pawnContractService.add(contract);
                if (!success) {
                    throw new RuntimeException("Không thể thêm hợp đồng cầm");
                }

                response.sendRedirect(request.getContextPath() + "/pawn-contracts?message=created");
            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi khi thêm hợp đồng: " + e.getMessage());
                showCreateForm(request, response);
            }
        }

        private void showEditForm(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            try {
                String idParam = request.getParameter("id");
                if (idParam == null || idParam.trim().isEmpty()) {
                    throw new IllegalArgumentException("Thiếu ID hợp đồng");
                }

                int id = Integer.parseInt(idParam);
                PawnContractDto contract = pawnContractService.findById(id);

                if (contract == null) {
                    request.setAttribute("error", "Không tìm thấy hợp đồng với ID: " + id);
                    // ✅ Quay về danh sách nhưng không mất dữ liệu
                    listPawnContracts(request, response);
                    return;
                }

                // ✅ Đưa đầy đủ dữ liệu cho JSP update
                List<Employee> employees = employeeService.getAllEmployees();
                request.setAttribute("employees", employees);
                request.setAttribute("contract", contract);

                // ✅ Forward sang đúng trang update.jsp
                request.getRequestDispatcher("views/pawn_contract/update.jsp").forward(request, response);

            } catch (Exception e) {
                e.printStackTrace();
                request.setAttribute("error", "Lỗi khi tải form chỉnh sửa: " + e.getMessage());
                listPawnContracts(request, response);
            }
            System.out.println("🟡 [DEBUG] showEditForm() - ID = " + request.getParameter("id"));
        }

        private void updatePawnContract(HttpServletRequest request, HttpServletResponse response)
                throws ServletException, IOException {
            try {
                PawnContract contract = new PawnContract();
                contract.setPawnContractId(parseIntParameter(request.getParameter("id"), "Mã hợp đồng không hợp lệ"));
                contract.setCustomerId(parseIntParameter(request.getParameter("customerId"), "Mã khách hàng không hợp lệ"));
                contract.setEmployeeId(parseIntParameter(request.getParameter("employeeId"), "Mã nhân viên không hợp lệ"));
                contract.setProductId(parseIntParameter(request.getParameter("productId"), "Mã sản phẩm không hợp lệ"));
                contract.setPawnPrice(parseBigDecimalParameter(request.getParameter("pawnPrice"), "Giá cầm không hợp lệ"));
                contract.setInterestRate(parseBigDecimalParameter(request.getParameter("interestRate"), "Lãi suất không hợp lệ"));
                contract.setPawnDate(parseLocalDateParameter(request.getParameter("pawnDate"), "Ngày cầm không hợp lệ"));
                contract.setDueDate(parseLocalDateParameter(request.getParameter("dueDate"), "Ngày đến hạn không hợp lệ"));
                String returnDateStr = request.getParameter("returnDate");
                contract.setReturnDate(returnDateStr != null && !returnDateStr.trim().isEmpty() ?
                        LocalDate.parse(returnDateStr) : null);

                boolean success = pawnContractService.update(contract);
                if (!success) throw new RuntimeException("Không thể cập nhật hợp đồng cầm");

                response.sendRedirect(request.getContextPath() + "/pawn-contracts?message=updated");
            } catch (Exception e) {
                request.setAttribute("error", "Lỗi khi cập nhật hợp đồng: " + e.getMessage());
                showEditForm(request, response);
            }
        }

        private void deletePawnContract(HttpServletRequest request, HttpServletResponse response)
                throws IOException {
            try {
                int id = parseIntParameter(request.getParameter("id"), "Mã hợp đồng không hợp lệ");
                boolean success = pawnContractService.delete(id);
                if (!success) throw new RuntimeException("Không thể xóa hợp đồng cầm");
                response.sendRedirect(request.getContextPath() + "/pawn-contracts?message=deleted");
            } catch (Exception e) {
                response.sendRedirect(request.getContextPath() + "/pawn-contracts?error=" + e.getMessage());
            }
        }

        private int parseIntParameter(String value, String errorMessage) {
            if (value == null || value.trim().isEmpty()) throw new IllegalArgumentException(errorMessage);
            try {
                int result = Integer.parseInt(value);
                if (result <= 0) throw new IllegalArgumentException(errorMessage);
                return result;
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException(errorMessage);
            }
        }

        private BigDecimal parseBigDecimalParameter(String value, String errorMessage) {
            if (value == null || value.trim().isEmpty()) throw new IllegalArgumentException(errorMessage);
            try {
                return new BigDecimal(value);
            } catch (NumberFormatException e) {
                throw new IllegalArgumentException(errorMessage);
            }
        }

        private LocalDate parseLocalDateParameter(String value, String errorMessage) {
            if (value == null || value.trim().isEmpty()) throw new IllegalArgumentException(errorMessage);
            try {
                return LocalDate.parse(value);
            } catch (Exception e) {
                throw new IllegalArgumentException(errorMessage);
            }
        }
    }