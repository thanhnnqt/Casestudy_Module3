package com.example.du_an.entity;

import java.time.LocalDate;

public class LiquidationContract {
    private int iD;
    private LocalDate liquidationDate;
    private double liquidationPrice;
    private int customerId;
    private int employeeId;
    private int productId;

    public LiquidationContract() {
    }

    public LiquidationContract(LocalDate liquidationDate, double liquidationPrice, int customerId, int employeeId, int productId) {
        this.liquidationDate = liquidationDate;
        this.liquidationPrice = liquidationPrice;
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.productId = productId;
    }

    public LiquidationContract(int iD, LocalDate liquidationDate, double liquidationPrice, int customerId, int employeeId, int productId) {
        this.iD = iD;
        this.liquidationDate = liquidationDate;
        this.liquidationPrice = liquidationPrice;
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.productId = productId;
    }

    public int getId() {
        return iD;
    }

    public void setId(int iD) {
        this.iD = iD;
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
}
