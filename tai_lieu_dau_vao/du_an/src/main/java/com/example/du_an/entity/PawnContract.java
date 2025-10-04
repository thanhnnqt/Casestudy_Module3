package com.example.du_an.entity;

import java.time.LocalDate;

public class PawnContract {
    private int iD;
    private int customerId;
    private int employeeId;
    private int productId;
    LocalDate pawnDate;
    private double pawnPrice;
    private double interest_rate;
    private LocalDate due_date;
    private LocalDate return_date;

    public PawnContract() {
    }

    public PawnContract(int customerId, int employeeId, int productId, LocalDate pawnDate, double pawnPrice, double interest_rate, LocalDate due_date, LocalDate return_date) {
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.productId = productId;
        this.pawnDate = pawnDate;
        this.pawnPrice = pawnPrice;
        this.interest_rate = interest_rate;
        this.due_date = due_date;
        this.return_date = return_date;
    }

    public PawnContract(int iD, int customerId, int employeeId, int productId, LocalDate pawnDate, double pawnPrice, double interest_rate, LocalDate due_date, LocalDate return_date) {
        this.iD = iD;
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.productId = productId;
        this.pawnDate = pawnDate;
        this.pawnPrice = pawnPrice;
        this.interest_rate = interest_rate;
        this.due_date = due_date;
        this.return_date = return_date;
    }

    public int getId() {
        return iD;
    }

    public void setId(int iD) {
        this.iD = iD;
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

    public LocalDate getPawnDate() {
        return pawnDate;
    }

    public void setPawnDate(LocalDate pawnDate) {
        this.pawnDate = pawnDate;
    }

    public double getPawnPrice() {
        return pawnPrice;
    }

    public void setPawnPrice(double pawnPrice) {
        this.pawnPrice = pawnPrice;
    }

    public double getInterest_rate() {
        return interest_rate;
    }

    public void setInterest_rate(double interest_rate) {
        this.interest_rate = interest_rate;
    }

    public LocalDate getDue_date() {
        return due_date;
    }

    public void setDue_date(LocalDate due_date) {
        this.due_date = due_date;
    }

    public LocalDate getReturn_date() {
        return return_date;
    }

    public void setReturn_date(LocalDate return_date) {
        this.return_date = return_date;
    }
}
