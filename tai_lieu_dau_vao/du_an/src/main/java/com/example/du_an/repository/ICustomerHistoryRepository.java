package com.example.du_an.repository;

import com.example.du_an.dto.PawnHistoryDto;
import com.example.du_an.dto.PurchaseHistoryDto;

import java.util.List;

public interface ICustomerHistoryRepository {
    List<PawnHistoryDto> findPawnHistoryByCustomerId(int customerId);
    List<PurchaseHistoryDto> findPurchaseHistoryByCustomerId(int customerId);
}
