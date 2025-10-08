package com.example.du_an.dto;

import com.example.du_an.util.NumberToWords;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class PawnContractDto {
    private int pawnContractId;

    // Thông tin khách hàng
    private int customerId;
    private String customerName;
    private String customerEmail;
    private String customerCccd;
    private LocalDate customerDob;

    // Thông tin nhân viên
    private int employeeId;
    private String employeeName;

    // Thông tin sản phẩm
    private int productId;
    private String productName;
    private String productDescription;
    private BigDecimal productValue;
    private String productStatus;

    // Thông tin hợp đồng
    private LocalDate pawnDate;
    private LocalDate dueDate;
    private LocalDate returnDate;
    private BigDecimal pawnPrice;
    private BigDecimal interestRate;
    private String status;


    private String pawnPriceInWords; // Số tiền bằng chữ
    private String productValueInWords; // Giá trị sản phẩm bằng chữ

    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public PawnContractDto() {}

    public PawnContractDto(int pawnContractId, String customerName, String employeeName, String productName, LocalDate pawnDate,
                           BigDecimal pawnPrice, BigDecimal interestRate, LocalDate dueDate, LocalDate returnDate, String status) {
        this.pawnContractId = pawnContractId;
        this.customerName = customerName;
        this.employeeName = employeeName;
        this.productName = productName;
        this.pawnDate = pawnDate;
        this.pawnPrice = pawnPrice;
        this.interestRate = interestRate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
        this.status = status;
    }

    // ======= Getter / Setter =======
    public int getPawnContractId() { return pawnContractId; }
    public void setPawnContractId(int pawnContractId) { this.pawnContractId = pawnContractId; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }

    public String getCustomerCccd() { return customerCccd; }
    public void setCustomerCccd(String customerCccd) { this.customerCccd = customerCccd; }

    public LocalDate getCustomerDob() { return customerDob; }
    public void setCustomerDob(LocalDate customerDob) { this.customerDob = customerDob; }

    public int getEmployeeId() { return employeeId; }
    public void setEmployeeId(int employeeId) { this.employeeId = employeeId; }

    public String getEmployeeName() { return employeeName; }
    public void setEmployeeName(String employeeName) { this.employeeName = employeeName; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getProductDescription() { return productDescription; }
    public void setProductDescription(String productDescription) { this.productDescription = productDescription; }

    public BigDecimal getProductValue() { return productValue; }
    public void setProductValue(BigDecimal productValue) { this.productValue = productValue; }

    public String getProductStatus() { return productStatus; }
    public void setProductStatus(String productStatus) { this.productStatus = productStatus; }

    public LocalDate getPawnDate() { return pawnDate; }
    public void setPawnDate(LocalDate pawnDate) { this.pawnDate = pawnDate; }

    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }

    public LocalDate getReturnDate() { return returnDate; }
    public void setReturnDate(LocalDate returnDate) { this.returnDate = returnDate; }

    public BigDecimal getPawnPrice() { return pawnPrice; }
    public void setPawnPrice(BigDecimal pawnPrice) { this.pawnPrice = pawnPrice; }

    public BigDecimal getInterestRate() { return interestRate; }
    public void setInterestRate(BigDecimal interestRate) { this.interestRate = interestRate; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // ======= Phương thức định dạng ngày =======
    public String getPawnDateFormatted() { return pawnDate == null ? null : pawnDate.format(FORMATTER); }
    public String getDueDateFormatted() { return dueDate == null ? null : dueDate.format(FORMATTER); }
    public String getReturnDateFormatted() { return returnDate == null ? null : returnDate.format(FORMATTER); }
    public String getCustomerDobFormatted() { return customerDob == null ? null : customerDob.format(FORMATTER); }
    public String getPawnPriceInWords() { return pawnPriceInWords; }

    public void setPawnPriceInWords(BigDecimal pawnPrice) {
        this.pawnPriceInWords = NumberToWords.convert(pawnPrice);
    }
    public String getProductValueInWords() { return productValueInWords; }

    public void setProductValueInWords(BigDecimal productValue) {
        this.productValueInWords = NumberToWords.convert(productValue);
    }
}
