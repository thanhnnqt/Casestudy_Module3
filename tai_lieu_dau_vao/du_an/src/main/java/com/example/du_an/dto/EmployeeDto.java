package com.example.du_an.dto;

import java.math.BigDecimal;
import java.time.LocalDate;

public class EmployeeDto {
    private int employeeId;
    private int accountId;
    private String fullName;
    private LocalDate dob;
    private String phoneNumber;
    private BigDecimal salary;
    private String email;
    private String citizenNumber;
    private String userName; // Thêm userName

    public EmployeeDto(int employeeId, int accountId, String fullName, LocalDate dob, String phoneNumber, BigDecimal salary, String email, String citizenNumber, String userName) {
        this.employeeId = employeeId;
        this.accountId = accountId;
        this.fullName = fullName;
        this.dob = dob;
        this.phoneNumber = phoneNumber;
        this.salary = salary;
        this.email = email;
        this.citizenNumber = citizenNumber;
        this.userName = userName;
    }

    // Getters and Setters cho tất cả các trường
    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public BigDecimal getSalary() {
        return salary;
    }

    public void setSalary(BigDecimal salary) {
        this.salary = salary;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCitizenNumber() {
        return citizenNumber;
    }

    public void setCitizenNumber(String citizenNumber) {
        this.citizenNumber = citizenNumber;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
