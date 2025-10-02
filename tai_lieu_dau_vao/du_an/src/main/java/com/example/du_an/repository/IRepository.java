package com.example.du_an.repository;

import com.example.du_an.dto.LiquidationContractDto;

import java.util.List;

public interface IRepository<T> {
    List<T> findAll();
}
