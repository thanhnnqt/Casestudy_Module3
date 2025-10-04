package com.example.du_an.repository;

import com.example.du_an.dto.CustomerDto;

import java.util.List;

public interface ICustomerRepositoryDto {
    List<CustomerDto> findAll();
}
