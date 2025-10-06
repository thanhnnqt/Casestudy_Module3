package com.example.du_an.service;

import com.example.du_an.dto.CustomerDto;
import com.example.du_an.repository.CustomerDtoRepository;
import com.example.du_an.repository.ICustomerDtoRepository;

import java.util.List;

public class CustomerDtoService implements ICustomerDtoService
{
    ICustomerDtoRepository customerDtoRepository = new CustomerDtoRepository();
    @Override
    public List<CustomerDto> findAll() {
        return customerDtoRepository.findAll();
    }
}
