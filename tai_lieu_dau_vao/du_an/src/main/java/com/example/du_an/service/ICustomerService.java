package com.example.du_an.service;


import com.example.du_an.entity.Customer;

import java.util.List;

public interface ICustomerService {
    boolean createCustomer(Customer customer);

    Customer getCustomerById(int id);

    Customer getCustomerByCitizenNumber(String citizenNumber);

    Customer findByPhoneOrCCCD(String value);

    List<Customer> getAllCustomers();
    Customer findById(int id);
    Customer findByAccountId(int accountId);

}
