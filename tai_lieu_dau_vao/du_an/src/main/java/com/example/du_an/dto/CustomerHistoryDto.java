package com.example.du_an.dto;

import com.example.du_an.entity.Customer;

import java.util.List;

public class CustomerHistoryDto {
    private Customer customer;
    private List<PawnHistoryDto> pawnedItems;
    private List<PurchaseHistoryDto> purchasedItems;

    public CustomerHistoryDto(Customer customer, List<PawnHistoryDto> pawnedItems, List<PurchaseHistoryDto> purchasedItems) {
        this.customer = customer;
        this.pawnedItems = pawnedItems;
        this.purchasedItems = purchasedItems;
    }

    // Getters and Setters
    public Customer getCustomer() { return customer; }
    public void setCustomer(Customer customer) { this.customer = customer; }
    public List<PawnHistoryDto> getPawnedItems() { return pawnedItems; }
    public void setPawnedItems(List<PawnHistoryDto> pawnedItems) { this.pawnedItems = pawnedItems; }
    public List<PurchaseHistoryDto> getPurchasedItems() { return purchasedItems; }
    public void setPurchasedItems(List<PurchaseHistoryDto> purchasedItems) { this.purchasedItems = purchasedItems; }
}
