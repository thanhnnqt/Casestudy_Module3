package com.example.du_an.repository;

import com.example.du_an.entity.Login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginRepository {
    public Login login(String username, String password) {
        String sql = "SELECT * FROM account WHERE username = ? AND password = ?";
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
}
