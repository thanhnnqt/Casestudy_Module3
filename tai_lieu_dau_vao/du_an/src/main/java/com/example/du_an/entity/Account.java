package com.example.du_an.entity;

public class Account {
    private int iD;
    private String userName;
    private String password;
    private String role;

    public Account() {
    }

    public Account(String userName, String password, String role) {
        this.userName = userName;
        this.password = password;
        this.role = role;
    }

    public Account(int iD, String userName, String password, String role) {
        this.iD = iD;
        this.userName = userName;
        this.password = password;
        this.role = role;
    }

    public int getId() {
        return iD;
    }

    public void setId(int iD) {
        this.iD = iD;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
