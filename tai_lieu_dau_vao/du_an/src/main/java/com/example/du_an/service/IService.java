package com.example.du_an.service;

import com.example.du_an.dto.LiquidationContractDto;

import java.util.List;

public interface IService<T> {
    List<T> findAll();
}
