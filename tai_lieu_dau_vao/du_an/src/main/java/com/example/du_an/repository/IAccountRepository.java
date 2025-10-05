package com.example.du_an.repository;

import com.example.du_an.entity.Account;

import java.util.List;

public interface IAccountRepository {
    List<Account> findAll();
}
