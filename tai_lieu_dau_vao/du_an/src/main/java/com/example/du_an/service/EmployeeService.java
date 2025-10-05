package com.example.du_an.service;

import com.example.du_an.dto.EmployeeDto;
import com.example.du_an.entity.Account;
import com.example.du_an.entity.Employee;
import com.example.du_an.repository.EmployeeRepository;
import com.example.du_an.repository.IEmployeeRepository;

import java.util.List;

public class EmployeeService implements IEmployeeService {
    private final IEmployeeRepository employeeRepository = new EmployeeRepository();

    @Override
    public List<EmployeeDto> findAll() {
        return employeeRepository.findAll();
    }

    @Override
    public boolean add(Employee employee, Account account) {
        return employeeRepository.add(employee, account);
    }

    @Override
    public boolean update(Employee employee) {
        return employeeRepository.update(employee);
    }

    @Override
    public boolean delete(int employeeId) {
        return employeeRepository.delete(employeeId);
    }

    @Override
    public Employee findById(int employeeId) {
        return employeeRepository.findById(employeeId);
    }
    @Override
    public List<EmployeeDto> search(String keyword) {
        return employeeRepository.search(keyword);
    }
}
