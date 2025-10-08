package com.example.du_an.entity;

import java.math.BigDecimal;

public class Product {
    public Product(int productId, String productName) {
    }

    public Product(BigDecimal price) {
        this.pawnPrice = price;
    }

    public enum Status {
        DANG_CAM("Đang cầm"),
        DA_CHUOC("Đã chuộc"),
        THANH_LY("Thanh lý");

        private final String label;

        Status(String label) {
            this.label = label;
        }

        public String getLabel() {
            return label;
        }
    }

    private int productId;
    private String productName;
    private String description;
    private BigDecimal pawnPrice;
    private Status status;

    public Product() {}

    public Product(int productId, String productName, String description, BigDecimal pawnPrice, Status status) {
        this.productId = productId;
        this.productName = productName;
        this.description = description;
        this.pawnPrice = pawnPrice;
        this.status = status;
    }

    // Getter / Setter
    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public BigDecimal getPawnPrice() { return pawnPrice; }
    public void setPawnPrice(BigDecimal pawnPrice) { this.pawnPrice = pawnPrice; }
    public Status getStatus() { return status; }
    public void setStatus(Status status) { this.status = status; }
}
