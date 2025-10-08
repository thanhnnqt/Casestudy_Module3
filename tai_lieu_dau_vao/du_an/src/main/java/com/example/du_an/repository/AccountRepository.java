package com.example.du_an.repository;

import com.example.du_an.entity.Account;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AccountRepository implements IAccountRepository {

    static final String UPDATE = "UPDATE account\n" +
            "SET \n" +
            "    username = ?,\n" +
            "    password_hash = ?,\n" +
            "    role = ?\n" +
            "WHERE account_id = ?;\n";

    public boolean add(Account account) {
        if (account.getUsername() == null || account.getUsername().trim().isEmpty()) {
            throw new IllegalArgumentException("Username không được để trống");
        }
        if (account.getPasswordHash() == null || account.getPasswordHash().trim().isEmpty()) {
            throw new IllegalArgumentException("Mật khẩu không được để trống");
        }
        if (account.getRole() == null) {
            throw new IllegalArgumentException("Vai trò không được để trống");
        }

        String sql = "INSERT INTO account (username, password_hash, role) VALUES (?, ?, ?)";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            System.out.println("Account username: " + account.getUsername());
            System.out.println("Account passwordHash: [HIDDEN]");
            System.out.println("Account role: " + account.getRole());
            stmt.setString(1, account.getUsername());
            stmt.setString(2, account.getPasswordHash());
            stmt.setString(3, account.getRole());
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        account.setAccountId(rs.getInt(1));
                        System.out.println("Created accountId: " + account.getAccountId());
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            System.err.println("Lỗi SQL trong add Account: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Lỗi SQL khi thêm Account: " + e.getMessage(), e);
        }
    }

    // Tìm theo ID
    public Account findById(int id) {
        String sql = "SELECT * FROM account WHERE account_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapToAccount(rs);
                }
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Tìm theo username
    public Account findByUsername(String username) {
        String sql = "SELECT * FROM account WHERE username = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapToAccount(rs);
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Lấy tất cả
    public List<Account> findAll() {
        List<Account> list = new ArrayList<>();
        String sql = "SELECT * FROM account";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapToAccount(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    // Mapping ResultSet -> Account
    private Account mapToAccount(ResultSet rs) throws SQLException {
        return new Account(
                rs.getInt("account_id"),
                rs.getString("username"),
                rs.getString("password_hash"),
                Account.Role.valueOf(rs.getString("role"))
        );
    }

    @Override
    public boolean update(Account account) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE);
            preparedStatement.setString(1, account.getUsername());
            preparedStatement.setString(2, account.getPasswordHash());
            preparedStatement.setString(3, account.getRole());
            preparedStatement.setInt(4, account.getAccountId());
            int row = preparedStatement.executeUpdate();
            return row == 1;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
