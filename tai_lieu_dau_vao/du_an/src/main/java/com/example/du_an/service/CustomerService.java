package com.example.du_an.service;



import com.example.du_an.entity.Customer;
import com.example.du_an.repository.CustomerRepository;

import java.util.List;

public class CustomerService implements ICustomerService {

    private final CustomerRepository customerRepository = new CustomerRepository();

    @Override
    public boolean createCustomer(Customer customer) {
        // Validate CMND đã tồn tại
        if (customerRepository.findByCitizenNumber(customer.getCitizenNumber()) != null) {
            throw new RuntimeException("CMND đã tồn tại");
        }
        return customerRepository.add(customer);
    }

    @Override
    public Customer getCustomerById(int id) {
        return customerRepository.findById(id);
    }

    @Override
    public Customer getCustomerByCitizenNumber(String citizenNumber) {
        return customerRepository.findByCitizenNumber(citizenNumber);
    }

    @Override
    public Customer findByPhoneOrCCCD(String value) {
        return customerRepository.findByPhoneOrCCCD(value);
    }

    @Override
    public List<Customer> getAllCustomers() {
        return customerRepository.findAll();
    }
    public Customer findById(int id) {
        return customerRepository.findById(id);
    }
    @Override
    public Customer findByAccountId(int accountId) {
        return customerRepository.findByAccountId(accountId);
    }

}
