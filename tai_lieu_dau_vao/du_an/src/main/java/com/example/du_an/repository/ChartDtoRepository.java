package com.example.du_an.repository;

import com.example.du_an.dto.ChartDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChartDtoRepository implements IChartDtoRepository {
    static final String SELECT = "SELECT \n" +
            "    DATE_FORMAT(p.pawn_date, '%m') AS month,\n" +
            "    SUM(\n" +
            "        (p.pawn_price * (p.interest_rate / 100))        \n" +
            "        - p.pawn_price                                  \n" +
            "        + IFNULL(l.price, 0)                            \n" +
            "    ) AS total_profit\n" +
            "FROM pawn_contract p\n" +
            "LEFT JOIN liquidation_contract l \n" +
            "       ON p.product_id = l.product_id             \n" +
            "WHERE p.return_date IS NOT NULL  \n" +
            "GROUP BY DATE_FORMAT(p.pawn_date, '%m')\n" +
            "having total_profit > 0\n" +
            "ORDER BY month;";

    @Override
    public List<ChartDto> findAll() {
        List<ChartDto> chartDtoList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                double interestRate = rs.getDouble("total_profit");
                int moth = rs.getInt("month");
                chartDtoList.add(new ChartDto(interestRate, moth));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return chartDtoList;
    }
}
