package com.example.du_an.entity;

import java.math.BigDecimal;
import java.time.LocalDate;

public class PawnContract {
    private int pawnContractId;
    private int customerId;
    private int employeeId;
    private int productId;
    private LocalDate pawnDate;
    private BigDecimal pawnPrice;
    private BigDecimal interestRate;
    private LocalDate dueDate;
    private LocalDate returnDate;

    public PawnContract() {
    }

    public PawnContract(int pawnContractId, int customerId, int employeeId, int productId, LocalDate pawnDate, BigDecimal pawnPrice, BigDecimal interestRate, LocalDate dueDate, LocalDate returnDate) {
        this.pawnContractId = pawnContractId;
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.productId = productId;
        this.pawnDate = pawnDate;
        this.pawnPrice = pawnPrice;
        this.interestRate = interestRate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
    }
    public PawnContract( int customerId, int employeeId, int productId, LocalDate pawnDate, BigDecimal pawnPrice, BigDecimal interestRate, LocalDate dueDate, LocalDate returnDate) {
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.productId = productId;
        this.pawnDate = pawnDate;
        this.pawnPrice = pawnPrice;
        this.interestRate = interestRate;
        this.dueDate = dueDate;
        this.returnDate = returnDate;
    }
    public int getPawnContractId() {
        return pawnContractId;
    }

    public void setPawnContractId(int pawnContractId) {
        this.pawnContractId = pawnContractId;
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
}
