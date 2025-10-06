package com.example.du_an.repository;


import com.example.du_an.entity.Employee;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRepository {

    // Lấy tất cả nhân viên
    public List<Employee> findAll() {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT * FROM employee";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapToEmployee(rs));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách nhân viên: " + e.getMessage(), e);
        }
        return list;
    }

    // Tìm theo ID
    public Employee findById(int id) {
        String sql = "SELECT * FROM employee WHERE employee_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapToEmployee(rs);
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm nhân viên theo ID: " + e.getMessage(), e);
        }
    }

    // Mapping ResultSet -> Employee
    private Employee mapToEmployee(ResultSet rs) throws SQLException {
        return new Employee(
                rs.getInt("employee_id"),
                rs.getInt("account_id"),
                rs.getString("full_name"),
                rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null,
                rs.getString("phone_number"),
                rs.getBigDecimal("salary"),
                rs.getString("email"),
                rs.getString("citizen_number")
        );
    }
}
