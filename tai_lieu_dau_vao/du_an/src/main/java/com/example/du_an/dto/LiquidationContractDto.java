package com.example.du_an.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class LiquidationContractDto {
    private int liquidationContractId;
    private String customerName;
    private String citizenNumber;
    private String phoneNumber;
    private String productName;
    private BigDecimal liquidationPrice;
    private LocalDate liquidationDate;
    private String employeeName;

    // Getters & Setters
    public int getLiquidationContractId() {
        return liquidationContractId;
    }

    public void setLiquidationContractId(int liquidationContractId) {
        this.liquidationContractId = liquidationContractId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCitizenNumber() {
        return citizenNumber;
    }

    public void setCitizenNumber(String citizenNumber) {
        this.citizenNumber = citizenNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public BigDecimal getLiquidationPrice() {
        return liquidationPrice;
    }

    public void setLiquidationPrice(BigDecimal liquidationPrice) {
        this.liquidationPrice = liquidationPrice;
    }

    public LocalDate getLiquidationDate() {
        return liquidationDate;
    }

    public void setLiquidationDate(LocalDate liquidationDate) {
        this.liquidationDate = liquidationDate;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }
}
