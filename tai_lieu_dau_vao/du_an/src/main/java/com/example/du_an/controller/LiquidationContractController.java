package com.example.du_an.controller;

import com.example.du_an.dto.LiquidationContractDto;
import com.example.du_an.dto.LiquidationProductDto;
import com.example.du_an.entity.Customer;
import com.example.du_an.entity.Employee; // Thêm import Employee
import com.example.du_an.entity.LiquidationContract;
import com.example.du_an.entity.Product; // Thêm import Product
import com.example.du_an.service.*;
import com.itextpdf.text.Paragraph;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
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
            case "detail":
                showContractDetail(req, resp);
                break;
            case "print":
                exportContractToPdf(req, resp);
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

        List<Employee> employeeList2 = employeeService.getAllEmployees();
        List<LiquidationProductDto> contractList2 = liquidationService.findProduct();
        List<Product> productPrice = liquidationService.findProductPrice();

        req.setAttribute("employees2", employeeList2);
        req.setAttribute("products2", contractList2);
        req.setAttribute("productPrice", productPrice);
        String customerIdStr = req.getParameter("customerId");
        if (customerIdStr != null && !customerIdStr.trim().isEmpty()) {
            try {
                int customerId = Integer.parseInt(customerIdStr);
                Customer customer = customerService.findById(customerId);
                if (customer != null) {
                    req.setAttribute("existingCustomer", customer);
                } else {
                    req.setAttribute("error", "Không tìm thấy khách hàng với ID: " + customerId);
                }
            } catch (NumberFormatException e) {
                req.setAttribute("error", "Mã khách hàng không hợp lệ");
            }
        }

        req.getRequestDispatcher("views/liquidation_contract/add.jsp").forward(req, resp);
    }

    private void checkCustomerAndShowForm(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String phoneOrCCCD = req.getParameter("phoneOrCCCD");
        Customer customer = null;
        if (phoneOrCCCD != null && !phoneOrCCCD.trim().isEmpty()) {
            customer = customerService.findByPhoneOrCCCD(phoneOrCCCD.trim());
        }

        // Vẫn cần gửi danh sách nhân viên và sản phẩm khi kiểm tra xong
        List<Employee> employeeList1 = employeeService.getAllEmployees();
        List<LiquidationProductDto> contractList1 = liquidationService.findProduct();

        req.setAttribute("existingCustomer", customer);
        req.setAttribute("phoneOrCCCD", phoneOrCCCD);
        req.setAttribute("employees1", employeeList1);
        req.setAttribute("products1", contractList1);
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

//            resp.sendRedirect("/liquidation-contract");
            resp.sendRedirect(req.getContextPath() + "/liquidation-contract?success=true");
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

    private void showContractDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        LiquidationContractDto contract = liquidationService.findByIdDto(id);

        if (contract == null) {
            resp.sendRedirect(req.getContextPath() + "/liquidation-contract?error=notfound");
            return;
        }

        req.setAttribute("contract", contract);
        req.getRequestDispatcher("views/liquidation_contract/detail.jsp").forward(req, resp);
    }

    private void exportContractToPdf(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        LiquidationContractDto contract = liquidationService.findByIdDto(id);

        if (contract == null) {
            resp.sendRedirect(req.getContextPath() + "/liquidation-contract?error=notfound");
            return;
        }

        resp.setContentType("application/pdf");
        resp.setHeader("Content-Disposition", "attachment; filename=hopdong_thanhly_" + id + ".pdf");

        try (OutputStream out = resp.getOutputStream()) {
            com.itextpdf.text.Document document = new com.itextpdf.text.Document(com.itextpdf.text.PageSize.A4, 50, 50, 50, 50);
            com.itextpdf.text.pdf.PdfWriter writer = com.itextpdf.text.pdf.PdfWriter.getInstance(document, out);
            document.open();

            // ======= FONT & STYLE =======

            // ======= FONT & STYLE =======
// Dùng font có sẵn trong Windows (Arial Unicode MS hoặc Times New Roman)
            String fontPath = "C:/Windows/Fonts/arial.ttf";  // hoặc "C:/Windows/Fonts/times.ttf"
            com.itextpdf.text.pdf.BaseFont baseFont = com.itextpdf.text.pdf.BaseFont.createFont(
                    fontPath,
                    com.itextpdf.text.pdf.BaseFont.IDENTITY_H, // hỗ trợ Unicode (tiếng Việt)
                    com.itextpdf.text.pdf.BaseFont.EMBEDDED
            );

            com.itextpdf.text.Font titleFont = new com.itextpdf.text.Font(baseFont, 20, com.itextpdf.text.Font.BOLD);
            com.itextpdf.text.Font sectionTitleFont = new com.itextpdf.text.Font(baseFont, 14, com.itextpdf.text.Font.BOLD);
            com.itextpdf.text.Font normalFont = new com.itextpdf.text.Font(baseFont, 12);
            com.itextpdf.text.Font boldFont = new com.itextpdf.text.Font(baseFont, 12, com.itextpdf.text.Font.BOLD);


            // ======= HEADER (Logo + Công ty) =======
//            com.itextpdf.text.pdf.PdfPTable header = new com.itextpdf.text.pdf.PdfPTable(2);
//            header.setWidthPercentage(100);
//            header.setWidths(new float[]{1, 3});
//
//            // Logo (tùy bạn thay đường dẫn)
//            try {
//                com.itextpdf.text.Image logo = com.itextpdf.text.Image.getInstance(req.getServletContext().getRealPath("/images/logo.png"));
//                logo.scaleAbsolute(60, 60);
//                com.itextpdf.text.pdf.PdfPCell logoCell = new com.itextpdf.text.pdf.PdfPCell(logo);
//                logoCell.setBorder(com.itextpdf.text.Rectangle.NO_BORDER);
//                logoCell.setHorizontalAlignment(com.itextpdf.text.Element.ALIGN_LEFT);
//                header.addCell(logoCell);
//            } catch (Exception e) {
//                // Nếu không có logo, để trống
//                com.itextpdf.text.pdf.PdfPCell empty = new com.itextpdf.text.pdf.PdfPCell(new com.itextpdf.text.Phrase(""));
//                empty.setBorder(com.itextpdf.text.Rectangle.NO_BORDER);
//                header.addCell(empty);
//            }
//
//            com.itextpdf.text.pdf.PdfPCell companyCell = new com.itextpdf.text.pdf.PdfPCell();
//            companyCell.setBorder(com.itextpdf.text.Rectangle.NO_BORDER);
//            companyCell.addElement(new com.itextpdf.text.Paragraph("CÔNG TY TNHH ABC", boldFont));
//            companyCell.addElement(new com.itextpdf.text.Paragraph("Địa chỉ: 123 Nguyễn Trãi, Hà Nội", normalFont));
//            companyCell.addElement(new com.itextpdf.text.Paragraph("SĐT: 0123 456 789", normalFont));
//            header.addCell(companyCell);
//
//            document.add(header);
//            document.add(new com.itextpdf.text.Paragraph(" "));

            // ======= TIÊU ĐỀ =======
            com.itextpdf.text.Paragraph title = new com.itextpdf.text.Paragraph("HỢP ĐỒNG THANH LÝ", titleFont);
            title.setAlignment(com.itextpdf.text.Element.ALIGN_CENTER);
            document.add(title);

            com.itextpdf.text.Paragraph subTitle = new com.itextpdf.text.Paragraph("Số hợp đồng: #" + contract.getLiquidationContractId(), normalFont);
            subTitle.setAlignment(com.itextpdf.text.Element.ALIGN_CENTER);
            document.add(subTitle);

            document.add(new com.itextpdf.text.Paragraph("Ngày lập: " + contract.getLiquidationDate(), normalFont));
            document.add(new com.itextpdf.text.Paragraph(" "));
            document.add(new Paragraph("----------------------------------------------"));

            document.add(new com.itextpdf.text.Paragraph(" "));

            // ======= KHÁCH HÀNG =======
            document.add(new com.itextpdf.text.Paragraph("I. THÔNG TIN KHÁCH HÀNG", sectionTitleFont));
            document.add(new com.itextpdf.text.Paragraph("Tên khách hàng: " + contract.getCustomerName(), normalFont));
            document.add(new com.itextpdf.text.Paragraph("CCCD: " + contract.getCitizenNumber(), normalFont));
            document.add(new com.itextpdf.text.Paragraph("Số điện thoại: " + contract.getPhoneNumber(), normalFont));
            document.add(new com.itextpdf.text.Paragraph(" "));
            document.add(new Paragraph("----------------------------------------------"));

            document.add(new com.itextpdf.text.Paragraph(" "));

            // ======= SẢN PHẨM =======
            document.add(new com.itextpdf.text.Paragraph("II. THÔNG TIN SẢN PHẨM", sectionTitleFont));
            document.add(new com.itextpdf.text.Paragraph("Tên sản phẩm: " + contract.getProductName(), normalFont));
            document.add(new com.itextpdf.text.Paragraph("Giá trị thanh lý: " + contract.getLiquidationPrice() + " ₫", normalFont));
            document.add(new com.itextpdf.text.Paragraph(" "));
            document.add(new Paragraph("----------------------------------------------"));

            document.add(new com.itextpdf.text.Paragraph(" "));

            // ======= NHÂN VIÊN =======
            document.add(new com.itextpdf.text.Paragraph("III. NHÂN VIÊN LẬP HỢP ĐỒNG", sectionTitleFont));
            document.add(new com.itextpdf.text.Paragraph("Họ tên nhân viên: " + contract.getEmployeeName(), normalFont));
            document.add(new com.itextpdf.text.Paragraph(" "));
            document.add(new Paragraph("----------------------------------------------"));

            document.add(new com.itextpdf.text.Paragraph(" "));

            // ======= CHỮ KÝ =======
            com.itextpdf.text.pdf.PdfPTable signatureTable = new com.itextpdf.text.pdf.PdfPTable(2);
            signatureTable.setWidthPercentage(100);
            signatureTable.setSpacingBefore(50f);
            signatureTable.setWidths(new float[]{1, 1});

            com.itextpdf.text.pdf.PdfPCell leftSig = new com.itextpdf.text.pdf.PdfPCell();
            leftSig.setBorder(com.itextpdf.text.Rectangle.NO_BORDER);
            leftSig.addElement(new com.itextpdf.text.Paragraph("KHÁCH HÀNG", boldFont));
            leftSig.addElement(new com.itextpdf.text.Paragraph("(Ký và ghi rõ họ tên)", normalFont));
            leftSig.setHorizontalAlignment(com.itextpdf.text.Element.ALIGN_CENTER);

            com.itextpdf.text.pdf.PdfPCell rightSig = new com.itextpdf.text.pdf.PdfPCell();
            rightSig.setBorder(com.itextpdf.text.Rectangle.NO_BORDER);
            rightSig.addElement(new com.itextpdf.text.Paragraph("NHÂN VIÊN LẬP HỢP ĐỒNG", boldFont));
            rightSig.addElement(new com.itextpdf.text.Paragraph("(Ký và ghi rõ họ tên)", normalFont));
            rightSig.setHorizontalAlignment(com.itextpdf.text.Element.ALIGN_CENTER);

            signatureTable.addCell(leftSig);
            signatureTable.addCell(rightSig);

            document.add(signatureTable);

            // ======= GHI CHÚ =======
            document.add(new com.itextpdf.text.Paragraph(" "));
            com.itextpdf.text.Paragraph footer = new com.itextpdf.text.Paragraph(
                    "",
                    new com.itextpdf.text.Font(com.itextpdf.text.Font.FontFamily.HELVETICA, 10, com.itextpdf.text.Font.ITALIC)
            );
            footer.setAlignment(com.itextpdf.text.Element.ALIGN_CENTER);
            document.add(footer);

            document.close();
            writer.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}