package com.example.du_an.repository;

import com.example.du_an.dto.ChartDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ChartDtoRepository implements IChartDtoRepository {
    static final String SELECT = "select sum(p.interest_rate) as interest_rate, month(p.pawn_date) as `month` from pawn_contract p group by `month`";

    @Override
    public List<ChartDto> findAll() {
        List<ChartDto> chartDtoList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                double interestRate = rs.getDouble("interest_rate");
                int moth = rs.getInt("interest_rate");
                chartDtoList.add(new ChartDto(interestRate, moth));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return chartDtoList;
    }
}
