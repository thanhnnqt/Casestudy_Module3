package com.example.du_an.service;

import com.example.du_an.repository.BaseRepository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerAutoDeleteService {
    public static void deleteOldCustomers() {
        try (Connection conn = BaseRepository.getConnectDB()) {

            // 1. Lấy danh sách customer_id và account_id cần xóa
            String selectOldCustomers =
                    "SELECT c.customer_id, c.account_id, c.full_name " +
                            "FROM customer c " +
                            "WHERE NOT EXISTS ( " +
                            "    SELECT 1 FROM pawn_contract pc " +
                            "    WHERE pc.customer_id = c.customer_id " +
                            "    AND TIMESTAMPDIFF(MONTH, pc.pawn_date, NOW()) < 6 " +
                            ")";

            List<Integer> customerIds = new ArrayList<>();
            List<Integer> accountIds = new ArrayList<>();
            List<String> customerNames = new ArrayList<>();

            try (PreparedStatement stmt = conn.prepareStatement(selectOldCustomers);
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    customerIds.add(rs.getInt("customer_id"));
                    accountIds.add(rs.getInt("account_id"));
                    customerNames.add(rs.getString("full_name"));
                }
            }

            if (customerIds.isEmpty()) {
                System.out.println("No customers to delete.");
                return;
            }

            // 2. Lưu tên khách hàng vào history_delete_customer
            String insertHistory = "INSERT INTO history_delete_customer(name) VALUES (?)";
            try (PreparedStatement stmt = conn.prepareStatement(insertHistory)) {
                for (String name : customerNames) {
                    stmt.setString(1, name);
                    stmt.executeUpdate();
                }
            }

            // 3. Set customer_id trong pawn_contract = NULL để giữ lại hợp đồng
            String updateContracts = "UPDATE pawn_contract SET customer_id = NULL WHERE customer_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(updateContracts)) {
                for (Integer customerId : customerIds) {
                    stmt.setInt(1, customerId);
                    stmt.executeUpdate();
                }
            }

            // 4. Xoá customer
            String deleteCustomer = "DELETE FROM customer WHERE customer_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteCustomer)) {
                for (Integer customerId : customerIds) {
                    stmt.setInt(1, customerId);
                    stmt.executeUpdate();
                }
            }

            // 5. Xoá account liên quan
            String deleteAccount = "DELETE FROM account WHERE account_id = ?";
            try (PreparedStatement stmt = conn.prepareStatement(deleteAccount)) {
                for (Integer accountId : accountIds) {
                    stmt.setInt(1, accountId);
                    stmt.executeUpdate();
                }
            }

            System.out.println("Deleted " + customerIds.size() + " customers and related accounts, but kept contracts.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
