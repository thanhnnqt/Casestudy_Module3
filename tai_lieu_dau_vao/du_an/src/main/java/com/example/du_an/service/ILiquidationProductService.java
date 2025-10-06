package com.example.du_an.service;

import com.example.du_an.dto.LiquidationProductDto;

import java.util.List;

public interface ILiquidationProductService {
    List<LiquidationProductDto> findAllLiquidationProducts();
}
