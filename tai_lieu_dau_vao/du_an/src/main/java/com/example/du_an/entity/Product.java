package com.example.du_an.entity;

public class Product {
    private int iD;
    private String productName;
    private String description;
    private double pawnPrice;
    private String status;

    public Product() {
    }

    public Product(String productName, String description, double pawnPrice, String status) {
        this.productName = productName;
        this.description = description;
        this.pawnPrice = pawnPrice;
        this.status = status;
    }

    public Product(int iD, String productName, String description, double pawnPrice, String status) {
        this.iD = iD;
        this.productName = productName;
        this.description = description;
        this.pawnPrice = pawnPrice;
        this.status = status;
    }

    public int getId() {
        return iD;
    }

    public void setId(int iD) {
        this.iD = iD;
    }

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

    public double getPawnPrice() {
        return pawnPrice;
    }

    public void setPawnPrice(double pawnPrice) {
        this.pawnPrice = pawnPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
