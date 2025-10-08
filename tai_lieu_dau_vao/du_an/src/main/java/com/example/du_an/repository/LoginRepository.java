package com.example.du_an.repository;

import com.example.du_an.entity.Login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginRepository {
    public Login login(String username, String password) {
        String sql = "SELECT * FROM account WHERE username = ? AND password_hash = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Login acc = new Login();
                acc.setId(rs.getInt("account_id"));
                acc.setUsername(rs.getString("username"));
                acc.setRole(rs.getString("role"));
                return acc;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // =================================================================
    // ===== PHƯƠNG THỨC MỚI ĐỂ KIỂM TRA TÊN TÀI KHOẢN TỒN TẠI =====
    // =================================================================
    public Login findByUsername(String username) {
        String sql = "SELECT * FROM account WHERE username = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Login acc = new Login();
                acc.setId(rs.getInt("account_id"));
                acc.setUsername(rs.getString("username"));
                acc.setRole(rs.getString("role"));
                return acc;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public Login findById(int accountId) {
        String sql = "SELECT * FROM account WHERE account_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Login acc = new Login();
                acc.setId(rs.getInt("account_id"));
                acc.setUsername(rs.getString("username"));
                acc.setRole(rs.getString("role"));
                return acc;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
