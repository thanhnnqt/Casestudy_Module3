package com.example.du_an.entity;
import org.mindrot.jbcrypt.BCrypt;
public class Account {
    public enum Role {
        ADMIN, STAFF, USER
    }

    private int accountId;
    private String username;
    private String passwordHash;
    private Role role;
    private int employeeId;
    public Account(String username, String passwordHash, Role role) {
        if (username == null || username.trim().isEmpty()) {
            throw new IllegalArgumentException("Username không được để trống");
        }
        if (passwordHash == null || passwordHash.trim().isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu không được để trống");
        }
        if (passwordHash.trim().length() < 6) {
            throw new IllegalArgumentException("Mật khẩu phải có ít nhất 6 ký tự");
        }
        if (role == null) {
            throw new IllegalArgumentException("Vai trò không được để trống");
        }
        this.username = username.trim();
        this.passwordHash = BCrypt.hashpw(passwordHash.trim(), BCrypt.gensalt());
        this.role = role;
    }

    // Constructor có ID (dùng khi lấy từ DB)
    public Account(int accountId, String username, String passwordHash, Role role) {
        this.accountId = accountId;
        this.username = username;
        this.passwordHash = passwordHash;
        this.role = role;
    }

    // Getter & Setter
    public int getAccountId() { return accountId; }
    public void setAccountId(int accountId) { this.accountId = accountId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public Role getRole() { return role; }
    public void setRole(Role role) { this.role = role; }
    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }
}