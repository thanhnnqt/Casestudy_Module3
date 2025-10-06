package com.example.du_an.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class LiquidationProductDto {
    private String productName;
    private String description;
    private BigDecimal liquidationPrice;
    private LocalDate liquidationDate;

    public LiquidationProductDto(String productName, String description, BigDecimal liquidationPrice, LocalDate liquidationDate) {
        this.productName = productName;
        this.description = description;
        this.liquidationPrice = liquidationPrice;
        this.liquidationDate = liquidationDate;
    }

    // Getters and Setters
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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
}
