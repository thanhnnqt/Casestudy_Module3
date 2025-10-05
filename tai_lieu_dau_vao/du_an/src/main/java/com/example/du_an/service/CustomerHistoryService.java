package com.example.du_an.service;

import com.example.du_an.dto.CustomerHistoryDto;
import com.example.du_an.dto.PawnHistoryDto;
import com.example.du_an.dto.PurchaseHistoryDto;
import com.example.du_an.entity.Customer;
import com.example.du_an.repository.CustomerHistoryRepository;
import com.example.du_an.repository.ICustomerHistoryRepository;

import java.util.List;

public class CustomerHistoryService implements ICustomerHistoryService {
    private final ICustomerHistoryRepository historyRepository = new CustomerHistoryRepository();

    @Override
    public CustomerHistoryDto getCustomerHistory(Customer customer) {
        if (customer == null) {
            return null;
        }
        List<PawnHistoryDto> pawnHistory = historyRepository.findPawnHistoryByCustomerId(customer.getId());
        List<PurchaseHistoryDto> purchaseHistory = historyRepository.findPurchaseHistoryByCustomerId(customer.getId());

        return new CustomerHistoryDto(customer, pawnHistory, purchaseHistory);
    }
}
