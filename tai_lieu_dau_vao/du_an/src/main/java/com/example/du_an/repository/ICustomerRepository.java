package com.example.du_an.repository;

import com.example.du_an.entity.Customer;

import java.util.List;

public interface ICustomerRepository {
    List<Customer> findAll();
}
