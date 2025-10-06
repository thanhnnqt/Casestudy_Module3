package com.example.du_an.repository;

import com.example.du_an.dto.EmployeeDto;
import com.example.du_an.entity.Account;
import com.example.du_an.entity.Employee;
import com.example.du_an.entity.Login;

import java.util.List;

public interface IEmployeeRepository {
    List<EmployeeDto> findAlls();
    List<Employee> findAll();
    boolean add(Employee employee, Login login);
    boolean update(Employee employee);
    boolean delete(int employeeId);
    Employee findById(int employeeId);
    List<EmployeeDto> search(String keyword);

}
