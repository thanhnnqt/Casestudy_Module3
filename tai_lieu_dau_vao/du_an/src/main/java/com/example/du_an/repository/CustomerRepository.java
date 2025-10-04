package com.example.du_an.repository;

import com.example.du_an.entity.Customer;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerRepository implements ICustomerRepository {
    static final String SELECT_ALL = "select c.customer_id, c.full_name, c.citizen_number,c.phone_number, c.address, c.email, c.dob, a.username from customer c \n" +
            "join `account` a on c.account_id = a.account_id;";
    @Override
    public List<Customer> findAll() {
        List<Customer> customers = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return;
    }
}
