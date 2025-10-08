package com.example.du_an.repository;



import com.example.du_an.entity.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepository {

    // Thêm khách hàng mới
    public boolean add(Customer customer) {
        String sql = "INSERT INTO customer (account_id, full_name, citizen_number, phone_number, address, email, dob) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            // ⚙️ Debug toàn bộ giá trị
            System.out.println("===== [DEBUG] Insert Customer =====");
            System.out.println("account_id: " + customer.getAccountId());
            System.out.println("full_name: " + customer.getFullName());
            System.out.println("citizen_number: " + customer.getCitizenNumber());
            System.out.println("phone_number: " + customer.getPhoneNumber());
            System.out.println("address: " + customer.getAddress());
            System.out.println("email: " + customer.getEmail());
            System.out.println("dob: " + customer.getDob());
            System.out.println("===================================");

            // ✅ Đảm bảo giá trị null không gây lỗi SQL
            stmt.setInt(1, customer.getAccountId());
            stmt.setString(2, safeString(customer.getFullName()));
            stmt.setString(3, safeString(customer.getCitizenNumber()));
            stmt.setString(4, safeString(customer.getPhoneNumber()));
            stmt.setString(5, safeString(customer.getAddress()));
            stmt.setString(6, safeString(customer.getEmail()));

            if (customer.getDob() != null) {
                stmt.setDate(7, Date.valueOf(customer.getDob()));
            } else {
                stmt.setNull(7, Types.DATE);
            }

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    customer.setCustomerId(rs.getInt(1));
                }
                return true;
            }

        } catch (SQLException e) {
            System.out.println("❌ Lỗi khi tạo khách hàng:");
            e.printStackTrace();
        }
        return false;
    }

    // ⚙️ Hàm phụ giúp xử lý chuỗi an toàn
    private String safeString(String value) {
        return (value != null && !value.trim().isEmpty()) ? value.trim() : null;
    }

    // Tìm theo ID
    public Customer findById(int id) {
        String sql = "SELECT * FROM customer WHERE customer_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) return mapToCustomer(rs);
                return null;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    // Tìm theo CMND
    public Customer findByCitizenNumber(String value) {
        String sql = "SELECT * FROM customer WHERE citizen_number = ? OR phone_number = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, value);
            stmt.setString(2, value);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new Customer(
                        rs.getInt("customer_id"),
                        rs.getInt("account_id"),
                        rs.getString("full_name"),
                        rs.getString("citizen_number"),
                        rs.getString("phone_number"),
                        rs.getString("address"),
                        rs.getString("email"),
                        rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    // Tìm theo số điện thoại hoặc CCCD (loại bỏ khoảng trắng đầu/cuối, case-insensitive)
    public Customer findByPhoneOrCCCD(String value) {
        if (value == null || value.trim().isEmpty()) return null;
        value = value.trim();

        String sql = "SELECT * FROM customer " +
                "WHERE TRIM(phone_number) = ? OR TRIM(citizen_number) = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, value);
            stmt.setString(2, value);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapToCustomer(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi SQL khi tìm Customer: " + e.getMessage(), e);
        }
        return null;
    }


    // Lấy tất cả
    public List<Customer> findAll() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customer";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapToCustomer(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return list;
    }

    // Mapping ResultSet -> Customer
    private Customer mapToCustomer(ResultSet rs) throws SQLException {
        return new Customer(
                rs.getInt("customer_id"),
                rs.getInt("account_id"),
                rs.getString("full_name"),
                rs.getString("citizen_number"),
                rs.getString("phone_number"),
                rs.getString("address"),
                rs.getString("email"),
                rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null
        );
    }

    public Customer findByAccountId(int accountId) {
        String sql = "SELECT * FROM customer WHERE account_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapToCustomer(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}

