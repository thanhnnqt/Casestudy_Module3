package com.example.du_an.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class PawnHistoryDto {
    private String productName;
    private LocalDate pawnDate;
    private BigDecimal pawnPrice;
    private LocalDate dueDate;
    private String status;

    public PawnHistoryDto(String productName, LocalDate pawnDate, BigDecimal pawnPrice, LocalDate dueDate, String status) {
        this.productName = productName;
        this.pawnDate = pawnDate;
        this.pawnPrice = pawnPrice;
        this.dueDate = dueDate;
        this.status = status;
    }

    // Getters and Setters
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public LocalDate getPawnDate() { return pawnDate; }
    public void setPawnDate(LocalDate pawnDate) { this.pawnDate = pawnDate; }
    public BigDecimal getPawnPrice() { return pawnPrice; }
    public void setPawnPrice(BigDecimal pawnPrice) { this.pawnPrice = pawnPrice; }
    public LocalDate getDueDate() { return dueDate; }
    public void setDueDate(LocalDate dueDate) { this.dueDate = dueDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
