package com.example.du_an.service;

import com.example.du_an.entity.Customer;
import com.example.du_an.repository.CustomerRepository;
import com.example.du_an.repository.ICustomerRepository;

import java.util.List;

public class CustomerService implements ICustomerService{
    ICustomerRepository customerRepository = new CustomerRepository();
    @Override
    public List<Customer> findAll() {
        return customerRepository.findAll();
    }
}
