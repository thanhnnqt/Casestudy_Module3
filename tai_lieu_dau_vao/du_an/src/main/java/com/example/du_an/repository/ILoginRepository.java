package com.example.du_an.repository;

import com.example.du_an.entity.Account;
import com.example.du_an.entity.Login;

import java.util.List;

public interface ILoginRepository {
    List<Login> findAll();
}
