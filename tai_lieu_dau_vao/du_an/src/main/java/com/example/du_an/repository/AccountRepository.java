package com.example.du_an.repository;

import com.example.du_an.entity.Account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class AccountRepository implements IAccountRepository {
    static final String SELECT_ALL = "select * from account";

    @Override
    public List<Account> findAll() {
        List<Account> accountList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int iD = rs.getInt("account_id");
                String userName = rs.getString("username");
                String password = rs.getString("password_hash");
                String role = rs.getString("role");
                accountList.add(new Account(iD, userName, password, role));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return accountList;
    }
}
