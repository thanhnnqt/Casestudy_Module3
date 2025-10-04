package com.example.du_an.dto;

import java.time.LocalDate;

public class CustomerDto {
    private int iD;
    private int accountId;
    private String fullName;
    private String citizenNumber;
    private String phoneNumber;
    private String address;
    private String email;
    private LocalDate dob;
    private String userName;

    public CustomerDto(int iD, int accountId, String fullName, String citizenNumber, String phoneNumber, String address, String email, LocalDate dob, String userName) {
        this.iD = iD;
        this.accountId = accountId;
        this.fullName = fullName;
        this.citizenNumber = citizenNumber;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;
        this.dob = dob;
        this.userName = userName;
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

    public String getCitizenNumber() {
        return citizenNumber;
    }

    public void setCitizenNumber(String citizenNumber) {
        this.citizenNumber = citizenNumber;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }
}
