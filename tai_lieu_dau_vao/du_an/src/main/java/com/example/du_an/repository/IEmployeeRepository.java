package com.example.du_an.repository;

import com.example.du_an.dto.EmployeeDto;
import com.example.du_an.entity.Account;
import com.example.du_an.entity.Employee;

import java.util.List;

public interface IEmployeeRepository {
    List<EmployeeDto> findAll();
    boolean add(Employee employee, Account account);
    boolean update(Employee employee);
    boolean delete(int employeeId);
    Employee findById(int employeeId);
    List<EmployeeDto> search(String keyword);
}
