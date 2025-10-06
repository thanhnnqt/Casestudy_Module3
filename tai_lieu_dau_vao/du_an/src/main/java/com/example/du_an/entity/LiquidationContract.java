package com.example.du_an.entity;

import java.time.LocalDate;

public class LiquidationContract {

    private int liquidationContractId;
    private LocalDate liquidationDate;
    private double liquidationPrice;
    private int customerId;
    private int employeeId;
    private int productId;
    private String customerName;
    private String employeeName;
    private String productName;

    public LiquidationContract() {
    }

    public LiquidationContract(int liquidationContractId, LocalDate liquidationDate, double liquidationPrice, int customerId, int employeeId, int productId) {
        this.liquidationContractId = liquidationContractId;
        this.liquidationDate = liquidationDate;
        this.liquidationPrice = liquidationPrice;
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.productId = productId;
    }

    public LiquidationContract(int liquidationContractId, String customerName, LocalDate liquidationDate, double liquidationPrice, String productName) {
        this.liquidationContractId = liquidationContractId;
        this.customerName = customerName;
        this.liquidationDate = liquidationDate;
        this.liquidationPrice = liquidationPrice;
        this.productName = productName;
    }
    public LiquidationContract(int liquidationContractId, LocalDate liquidationDate, double liquidationPrice) {
        this.liquidationContractId = liquidationContractId;
        this.liquidationDate = liquidationDate;
        this.liquidationPrice = liquidationPrice;
    }

    public LiquidationContract(LocalDate liquidationDate, double liquidationPrice, int customerId, int employeeId, int productId) {
        this.liquidationDate = liquidationDate;
        this.liquidationPrice = liquidationPrice;
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.productId = productId;
    }

    public int getLiquidationContractId() {
        return liquidationContractId;
    }

    public void setLiquidationContractId(int liquidationContractId) {
        this.liquidationContractId = liquidationContractId;
    }

    public LocalDate getLiquidationDate() {
        return liquidationDate;
    }

    public void setLiquidationDate(LocalDate liquidationDate) {
        this.liquidationDate = liquidationDate;
    }

    public double getLiquidationPrice() {
        return liquidationPrice;
    }

    public void setLiquidationPrice(double liquidationPrice) {
        this.liquidationPrice = liquidationPrice;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
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
}
