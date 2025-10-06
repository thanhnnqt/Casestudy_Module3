package com.example.du_an.service;


import com.example.du_an.entity.Employee;

import java.util.List;

public interface IEmployeeService {
    List<Employee> getAllEmployees();
    Employee getEmployeeById(int id);
}
