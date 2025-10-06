package com.example.du_an.repository;

import com.example.du_an.dto.PawnHistoryDto;
import com.example.du_an.dto.PurchaseHistoryDto;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CustomerHistoryRepository implements ICustomerHistoryRepository {
    private static final String FIND_PAWN_HISTORY = "SELECT p.product_name, pc.pawn_date, pc.pawn_price, pc.due_date, p.status " +
            "FROM pawn_contract pc JOIN product p ON pc.product_id = p.product_id WHERE pc.customer_id = ?";
    private static final String FIND_PURCHASE_HISTORY = "SELECT p.product_name, lc.liquidation_date, lc.price " +
            "FROM liquidation_contract lc JOIN product p ON lc.product_id = p.product_id WHERE lc.customer_id = ?";

    @Override
    public List<PawnHistoryDto> findPawnHistoryByCustomerId(int customerId) {
        List<PawnHistoryDto> history = new ArrayList<>();
        Connection conn = BaseRepository.getConnectDB();
        try (PreparedStatement ps = conn.prepareStatement(FIND_PAWN_HISTORY)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                history.add(new PawnHistoryDto(
                        rs.getString("product_name"), rs.getObject("pawn_date", LocalDate.class),
                        rs.getBigDecimal("pawn_price"), rs.getObject("due_date", LocalDate.class),
                        rs.getString("status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }

    @Override
    public List<PurchaseHistoryDto> findPurchaseHistoryByCustomerId(int customerId) {
        List<PurchaseHistoryDto> history = new ArrayList<>();
        Connection conn = BaseRepository.getConnectDB();
        try (PreparedStatement ps = conn.prepareStatement(FIND_PURCHASE_HISTORY)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                history.add(new PurchaseHistoryDto(
                        rs.getString("product_name"), rs.getObject("liquidation_date", LocalDate.class),
                        rs.getBigDecimal("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return history;
    }
}