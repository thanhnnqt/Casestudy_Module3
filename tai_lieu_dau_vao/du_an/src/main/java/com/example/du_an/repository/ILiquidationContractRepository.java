package com.example.du_an.repository;

import com.example.du_an.dto.LiquidationContractDto;
import com.example.du_an.dto.LiquidationProductDto;
import com.example.du_an.entity.LiquidationContract;
import com.example.du_an.entity.Product;

import java.util.List;

public interface ILiquidationContractRepository {
    List<LiquidationContract> findAll();
    boolean add(LiquidationContract liquidationContract);
    boolean delete(int id);
    LiquidationContract findById(int id);
    List<LiquidationContract> search(String name, String categoryId);
    LiquidationContract findByIdContract(int id);
    List<LiquidationProductDto> findProduct();
    List<Product> findProductPrice();
    LiquidationContractDto findByIdDto(int id);
}