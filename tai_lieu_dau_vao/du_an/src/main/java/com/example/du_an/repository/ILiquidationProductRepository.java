package com.example.du_an.repository;

import com.example.du_an.dto.LiquidationProductDto;

import java.util.List;

public interface ILiquidationProductRepository {
    List<LiquidationProductDto> findAllLiquidationProducts();
}
