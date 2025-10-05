package com.example.du_an.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class PurchaseHistoryDto {
    private String productName;
    private LocalDate purchaseDate;
    private BigDecimal purchasePrice;

    public PurchaseHistoryDto(String productName, LocalDate purchaseDate, BigDecimal purchasePrice) {
        this.productName = productName;
        this.purchaseDate = purchaseDate;
        this.purchasePrice = purchasePrice;
    }

    // Getters and Setters
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public LocalDate getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(LocalDate purchaseDate) { this.purchaseDate = purchaseDate; }
    public BigDecimal getPurchasePrice() { return purchasePrice; }
    public void setPurchasePrice(BigDecimal purchasePrice) { this.purchasePrice = purchasePrice; }
}
