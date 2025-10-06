package com.example.du_an.service;

import com.example.du_an.dto.LiquidationProductDto;
import com.example.du_an.repository.ILiquidationProductRepository;
import com.example.du_an.repository.LiquidationProductRepository;

import java.util.List;

public class LiquidationProductService implements ILiquidationProductService {
    private final ILiquidationProductRepository liquidationProductRepository = new LiquidationProductRepository();

    @Override
    public List<LiquidationProductDto> findAllLiquidationProducts() {
        return liquidationProductRepository.findAllLiquidationProducts();
    }
}
