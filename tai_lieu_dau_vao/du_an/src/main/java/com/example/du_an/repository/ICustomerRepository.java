package com.example.du_an.repository;

import com.example.du_an.dto.CustomerDto;
import com.example.du_an.entity.Customer;

import java.util.List;

public interface ICustomerRepository {
    boolean update(Customer customer);

}
