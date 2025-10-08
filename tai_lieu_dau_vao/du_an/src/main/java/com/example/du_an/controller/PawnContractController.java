package com.example.du_an.controller;

import com.example.du_an.dto.PawnContractDto;
import com.example.du_an.entity.Customer;
import com.example.du_an.entity.Employee;
import com.example.du_an.entity.PawnContract;
import com.example.du_an.entity.Product;
import com.example.du_an.service.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.util.ArrayList;

import java.util.List;
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import org.apache.hc.client5.http.classic.methods.HttpPost;
import org.apache.hc.client5.http.impl.classic.CloseableHttpClient;
import org.apache.hc.client5.http.impl.classic.HttpClients;
import org.apache.hc.client5.http.entity.mime.MultipartEntityBuilder;
import org.apache.hc.core5.http.ContentType;
import org.apache.hc.core5.http.HttpEntity;
import org.apache.hc.core5.http.io.entity.EntityUtils;

@WebServlet(name = "PawnContractController", urlPatterns = "/pawn-contracts")
@MultipartConfig
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

    // Trong file PawnContractController.java
    private void createPawnContract(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<String> errors = new ArrayList<>();
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
            int employeeId = parseIntParameter(employeeIdStr, "Mã nhân viên không hợp lệ");
            int customerId = parseIntParameter(customerIdStr, "Mã khách hàng không hợp lệ");
            BigDecimal productValue = parseBigDecimalParameter(productValueStr, "Giá trị định giá không hợp lệ");
            BigDecimal pawnAmount = parseBigDecimalParameter(pawnAmountStr, "Số tiền cầm không hợp lệ");
            LocalDate pawnDate = parseLocalDateParameter(pawnDateStr, "Ngày cầm không hợp lệ");
            LocalDate dueDate = parseLocalDateParameter(dueDateStr, "Ngày đến hạn không hợp lệ");

            // ✅ Validate dữ liệu
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

            if (!errors.isEmpty()) {
                throw new IllegalArgumentException(String.join("<br>", errors));
            }

            // ✅ Upload ảnh lên ImgBB
            String imageUrl = null;
            Part filePart = request.getPart("productImage");
            if (filePart != null && filePart.getSize() > 0) {
                String originalFileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                String apiKey = "2ee83bdf97e704463f4a9fa268b24bb6";

                try (CloseableHttpClient httpClient = HttpClients.createDefault()) {
                    HttpPost uploadFile = new HttpPost("https://api.imgbb.com/1/upload?key=" + apiKey);

                    MultipartEntityBuilder builder = MultipartEntityBuilder.create();
                    builder.addBinaryBody("image", filePart.getInputStream(), ContentType.DEFAULT_BINARY, originalFileName);
                    HttpEntity multipart = builder.build();
                    uploadFile.setEntity(multipart);

                    imageUrl = httpClient.execute(uploadFile, httpResponse -> {
                        HttpEntity responseEntity = httpResponse.getEntity();
                        String responseString = EntityUtils.toString(responseEntity);

                        System.out.println("ImgBB response: " + responseString);

                        Gson gson = new Gson();
                        JsonObject jsonObject = gson.fromJson(responseString, JsonObject.class);
                        if (jsonObject.get("success").getAsBoolean()) {
                            return jsonObject.getAsJsonObject("data").get("url").getAsString();
                        } else {
                            throw new IOException("ImgBB upload failed: " +
                                    jsonObject.getAsJsonObject("error").get("message").getAsString());
                        }
                    });

                    System.out.println("Uploaded to ImgBB: " + imageUrl);
                }
            }

            // ✅ Tạo product và lưu DB (đã có imageUrl)
            Product product = new Product();
            product.setProductName(productName.trim());
            product.setDescription(description != null ? description.trim() : null);
            product.setPawnPrice(productValue);
            product.setStatus(Product.Status.DANG_CAM);
            product.setImageUrl(imageUrl); // 💾 link ảnh ImgBB

            boolean created = productService.create(product);
            if (!created || product.getProductId() <= 0) {
                throw new RuntimeException("Không thể tạo sản phẩm mới.");
            }

            // ✅ Tạo hợp đồng cầm đồ
            PawnContract contract = new PawnContract(
                    customerId,
                    employeeId,
                    product.getProductId(),
                    pawnDate,
                    pawnAmount,
                    parseBigDecimalParameter(interestRateStr, "Lãi suất không hợp lệ"),
                    dueDate,
                    null
            );
            pawnContractService.add(contract);

            request.getSession().setAttribute("flashSuccess", "🎉 Tạo hợp đồng thành công!");
            response.sendRedirect(request.getContextPath() + "/pawn-contracts");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi thêm hợp đồng: " + e.getMessage());
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

    // --- CÁC PHƯƠNG THỨC CÒN LẠI GIỮ NGUYÊN 100% NHƯ CỦA BẠN ---
    private void listPawnContracts(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
        boolean hasSearch = (customerName != null && !customerName.trim().isEmpty()) || (employeeName != null && !employeeName.trim().isEmpty()) || (productName != null && !productName.trim().isEmpty()) || (status != null && !status.trim().isEmpty());
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

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            PawnContractDto contract = pawnContractService.findById(id);
            if (contract == null) {
                response.sendRedirect(request.getContextPath() + "/pawn-contracts");
                return;
            }
            Product product = productService.findById(contract.getProductId());
            List<Employee> employees = employeeService.getAllEmployees();
            request.setAttribute("contract", contract);
            request.setAttribute("product", product);
            request.setAttribute("employees", employees);
            request.getRequestDispatcher("views/pawn_contract/update.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/pawn-contracts");
        }
    }

    private void updatePawnContract(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int productId = parseIntParameter(request.getParameter("productId"), "Mã sản phẩm không hợp lệ");
            Product product = productService.findById(productId);
            if (product != null) {
                product.setProductName(request.getParameter("productName"));
                product.setDescription(request.getParameter("description"));
                product.setPawnPrice(parseBigDecimalParameter(request.getParameter("productValue"), "Giá trị định giá không hợp lệ"));
                productService.update(product);
            } else {
                throw new IllegalArgumentException("Không tìm thấy sản phẩm để cập nhật.");
            }
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
            if (returnDateStr != null && !returnDateStr.isEmpty()) {
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

    private void deletePawnContract(HttpServletRequest request, HttpServletResponse response) throws IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            pawnContractService.delete(id);
            request.getSession().setAttribute("flashSuccess", "Xóa hợp đồng thành công!");
        } catch (Exception e) {
            request.getSession().setAttribute("flashError", "Lỗi khi xóa hợp đồng.");
        }
        response.sendRedirect(request.getContextPath() + "/pawn-contracts");
    }

    private void confirmLiquidation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
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

    private void showDetailPawnContract(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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