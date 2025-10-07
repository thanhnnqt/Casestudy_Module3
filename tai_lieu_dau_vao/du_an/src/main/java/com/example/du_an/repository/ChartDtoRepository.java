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
            "    DATE_FORMAT(pc.pawn_date, '%m') AS month,\n" +
            "    SUM(pc.pawn_price) AS total_revenue\n" +
            "FROM pawn_contract pc\n" +
            "WHERE YEAR(pc.pawn_date) = 2025\n" +
            "GROUP BY DATE_FORMAT(pc.pawn_date, '%m')\n" +
            "ORDER BY month;\n";

    @Override
    public List<ChartDto> findAll() {
        List<ChartDto> chartDtoList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                double interestRate = rs.getDouble("total_revenue");
                int moth = rs.getInt("month");
                chartDtoList.add(new ChartDto(interestRate, moth));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return chartDtoList;
    }
}
