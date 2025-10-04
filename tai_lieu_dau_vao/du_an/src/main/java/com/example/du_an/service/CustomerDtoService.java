package com.example.du_an.service;

import com.example.du_an.dto.CustomerDto;
import com.example.du_an.repository.CustomerDtoRepository;
import com.example.du_an.repository.ICustomerRepositoryDto;

import java.util.List;

public class CustomerDtoService implements ICustomerDtoService {
    ICustomerRepositoryDto customerRepositoryDto = new CustomerDtoRepository();

    @Override
    public List<CustomerDto> findAll() {
        return customerRepositoryDto.findAll();
    }
}
