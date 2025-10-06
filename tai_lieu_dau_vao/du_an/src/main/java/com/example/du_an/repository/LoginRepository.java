package com.example.du_an.repository;


import com.example.du_an.entity.Login;

import java.util.List;

public class LoginRepository implements ILoginRepository {

    @Override
    public List<Login> findAll() {
        return List.of();
    }
}
