package com.example.du_an.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class LiquidationProductDto {
    private String productName;
    private String description;
    private BigDecimal liquidationPrice;
    private LocalDate liquidationDate;
    private int productId;
    private String imageUrl;

    public LiquidationProductDto(int productId, String productName) {
        this.productId = productId;
        this.productName = productName;
    }

    public LiquidationProductDto(double price) {
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public LiquidationProductDto(String productName, String description, BigDecimal liquidationPrice, LocalDate liquidationDate) {
        this.productName = productName;
        this.description = description;
        this.liquidationPrice = liquidationPrice;
        this.liquidationDate = liquidationDate;
    }

    public LiquidationProductDto(String productName, String description, BigDecimal liquidationPrice, LocalDate liquidationDate, int productId) {
        this.productName = productName;
        this.description = description;
        this.liquidationPrice = liquidationPrice;
        this.liquidationDate = liquidationDate;
        this.productId = productId;
    }
    public LiquidationProductDto(String productName, String description, java.math.BigDecimal liquidationPrice, LocalDate liquidationDate, String imageUrl) {
        this.productName = productName;
        this.description = description;
        this.liquidationPrice = liquidationPrice;
        this.liquidationDate = liquidationDate;
        this.imageUrl = imageUrl;
    }

    // Getters and Setters
    public String getProductName() {
        return productName;
    }

    public String getImageUrl() {
        return imageUrl;
    }
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
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
