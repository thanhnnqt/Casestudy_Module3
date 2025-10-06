package com.example.du_an.service;



import com.example.du_an.entity.Account;
import com.example.du_an.repository.AccountRepository;

import java.util.List;

public class AccountService implements IAccountService {
    private final AccountRepository accountRepository = new AccountRepository();

    // Thêm tài khoản mới
    public boolean createAccount(Account account) {
        // Ở đây có thể validate username, password...
        if (accountRepository.findByUsername(account.getUsername()) != null) {
            throw new RuntimeException("Username đã tồn tại");
        }
        return accountRepository.add(account);
    }

    // Tìm theo ID
    public Account getAccountById(int id) {
        return accountRepository.findById(id);
    }

    // Tìm theo username
    public Account getAccountByUsername(String username) {
        return accountRepository.findByUsername(username);
    }

    // Lấy tất cả tài khoản
    public List<Account> getAllAccounts() {
        return accountRepository.findAll();
    }
}
