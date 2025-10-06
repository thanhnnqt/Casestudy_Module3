package com.example.du_an.sevice;

import com.example.du_an.dto.CustomerHistoryDto;
import com.example.du_an.entity.Customer;

public interface ICustomerHistoryService {
    CustomerHistoryDto getCustomerHistory(Customer customer);
}