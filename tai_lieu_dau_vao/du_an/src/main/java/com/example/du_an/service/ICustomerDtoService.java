package com.example.du_an.service;

import com.example.du_an.dto.CustomerDto;

import java.util.List;

public interface ICustomerDtoService {
    List<CustomerDto> findAll();
}
