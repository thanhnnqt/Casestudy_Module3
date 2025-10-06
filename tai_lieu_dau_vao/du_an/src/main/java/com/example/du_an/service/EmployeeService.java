package com.example.du_an.service;



import com.example.du_an.entity.Employee;
import com.example.du_an.repository.EmployeeRepository;

import java.util.List;

public class EmployeeService implements IEmployeeService {

    private final EmployeeRepository employeeRepository = new EmployeeRepository();

    @Override
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    @Override
    public Employee getEmployeeById(int id) {
        return employeeRepository.findById(id);
    }

}
