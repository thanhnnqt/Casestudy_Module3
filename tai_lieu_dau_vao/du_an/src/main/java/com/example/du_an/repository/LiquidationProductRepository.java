package com.example.du_an.repository;

import com.example.du_an.dto.LiquidationProductDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class LiquidationProductRepository implements ILiquidationProductRepository {


    private static final String SELECT_LIQUIDATION_PRODUCTS =
            "SELECT p.product_name, p.description, lc.price AS liquidation_price, lc.liquidation_date " +
                    "FROM product p " +
                    "JOIN liquidation_contract lc ON p.product_id = lc.product_id " +
                    "WHERE p.status = 'Thanh lý'";

    @Override
    public List<LiquidationProductDto> findAllLiquidationProducts() {
        List<LiquidationProductDto> productList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement ps = connection.prepareStatement(SELECT_LIQUIDATION_PRODUCTS);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String name = rs.getString("product_name");
                String desc = rs.getString("description");
                java.math.BigDecimal price = rs.getBigDecimal("liquidation_price");
                LocalDate date = rs.getObject("liquidation_date", LocalDate.class);
                productList.add(new LiquidationProductDto(name, desc, price, date));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productList;
    }
}
