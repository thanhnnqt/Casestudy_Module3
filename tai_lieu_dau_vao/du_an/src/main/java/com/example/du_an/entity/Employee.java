package com.example.du_an.entity;

import java.time.LocalDate;

public class Employee {
    private int iD;
    private int accountId;
    private String fullName;
    private LocalDate dob;
    private String phoneNumber;
    private double salary;
    private String email;
    private String citizenNumber;

    public Employee() {
    }

    public Employee(int accountId, String fullName, LocalDate dob, String phoneNumber, double salary, String email, String citizenNumber) {
        this.accountId = accountId;
        this.fullName = fullName;
        this.dob = dob;
        this.phoneNumber = phoneNumber;
        this.salary = salary;
        this.email = email;
        this.citizenNumber = citizenNumber;
    }

    public Employee(int iD, int accountId, String fullName, LocalDate dob, String phoneNumber, double salary, String email, String citizenNumber) {
        this.iD = iD;
        this.accountId = accountId;
        this.fullName = fullName;
        this.dob = dob;
        this.phoneNumber = phoneNumber;
        this.salary = salary;
        this.email = email;
        this.citizenNumber = citizenNumber;
    }

    public int getId() {
        return iD;
    }

    public void setId(int iD) {
        this.iD = iD;
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

    public double getSalary() {
        return salary;
    }

    public void setSalary(double salary) {
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
}
