package com.example.du_an.service;

import com.example.du_an.entity.Account;
import com.example.du_an.repository.AccountRepository;
import com.example.du_an.repository.IAccountRepository;

import java.util.List;

public class AccountService implements IAccountService {
    IAccountRepository accountRepository = new AccountRepository();

    @Override
    public List<Account> findAll() {
        return accountRepository.findAll();
    }
}
