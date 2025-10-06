package com.example.du_an.repository;

import com.example.du_an.dto.CustomerDto;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class CustomerDtoRepository implements ICustomerDtoRepository {
    static final String SELECT_ALL = "select c.*, pc.*, a.* from customer c \n" +
            "join `account` a on c.account_id = a.account_id join `pawn_contract` pc on c.customer_id = pc.customer_id;";

    @Override
    public List<CustomerDto> findAll() {
        List<CustomerDto> customerDtos = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int iD = rs.getInt("customer_id");
                int accountId = rs.getInt("account_id");
                String fullName = rs.getString("full_name");
                String citizenNumber = rs.getString("citizen_number");
                String phoneNumber = rs.getString("phone_number");
                String address = rs.getString("address");
                String email = rs.getString("email");
                LocalDate dob = LocalDate.parse(rs.getString("dob"));
                String userName = rs.getString("username");
                LocalDate pawn_date = LocalDate.parse(rs.getString("pawn_date"));
                customerDtos.add(new CustomerDto(iD, accountId, fullName, citizenNumber, phoneNumber, address, email, dob, userName, pawn_date));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customerDtos;
    }
}

