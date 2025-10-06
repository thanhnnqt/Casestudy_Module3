package com.example.du_an.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class PawnContractDto {
    private int pawnContractId;
    private String customerName;  // lấy từ bảng customer
    private String employeeName;  // lấy từ bảng employee
    private String productName;   // lấy từ bảng product
    private LocalDate pawnDate;
    private BigDecimal pawnPrice;
    private BigDecimal interestRate;
    private LocalDate dueDate;
    private LocalDate returnDate;
    private String status;
    private int customerId;
    private int employeeId;
    private int productId;
    private String customerEmail;
    public PawnContractDto() {
    }

    public PawnContractDto(int pawnContractId, String customerName, String employeeName, String productName, LocalDate pawnDate, BigDecimal pawnPrice, BigDecimal interestRate, LocalDate dueDate, LocalDate returnDate, String status) {
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

    public int getPawnContractId() {
        return pawnContractId;
    }

    public void setPawnContractId(int pawnContractId) {
        this.pawnContractId = pawnContractId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public LocalDate getPawnDate() {
        return pawnDate;
    }

    public void setPawnDate(LocalDate pawnDate) {
        this.pawnDate = pawnDate;
    }

    public BigDecimal getPawnPrice() {
        return pawnPrice;
    }

    public void setPawnPrice(BigDecimal pawnPrice) {
        this.pawnPrice = pawnPrice;
    }

    public BigDecimal getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(BigDecimal interestRate) {
        this.interestRate = interestRate;
    }

    public LocalDate getDueDate() {
        return dueDate;
    }

    public void setDueDate(LocalDate dueDate) {
        this.dueDate = dueDate;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    private static final DateTimeFormatter FORMATTER = DateTimeFormatter.ofPattern("dd/MM/yyyy");

    public String getPawnDateFormatted() {
        return pawnDate == null ? null : pawnDate.format(FORMATTER);
    }

    public String getDueDateFormatted() {
        return dueDate == null ? null : dueDate.format(FORMATTER);
    }

    public String getReturnDateFormatted() {
        return returnDate == null ? null : returnDate.format(FORMATTER);
    }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public int getEmployeeId() { return employeeId; }
    public void setEmployeeId(int employeeId) { this.employeeId = employeeId; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }
}
