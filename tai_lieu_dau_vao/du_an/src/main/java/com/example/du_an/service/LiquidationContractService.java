package com.example.du_an.service;


import com.example.du_an.entity.LiquidationContract;
import com.example.du_an.repository.ILiquidationContractRepository;
import com.example.du_an.repository.LiquidationContractRepository;

import java.util.List;

public class LiquidationContractService implements ILiquidationContractService {
    private final ILiquidationContractRepository liquidationContractRepository = new LiquidationContractRepository();
    @Override
    public List<LiquidationContract> findAll() {
        return liquidationContractRepository.findAll();
    }

    @Override
    public boolean add(LiquidationContract liquidationContract) {
        return liquidationContractRepository.add(liquidationContract);
    }

    @Override
    public boolean delete(int id) {
        return liquidationContractRepository.delete(id);
    }

    @Override
    public LiquidationContract findById(int id) {
        return liquidationContractRepository.findById(id);
    }

    @Override
    public List<LiquidationContract> search(String name, String categoryId) {
        return liquidationContractRepository.search(name, categoryId);
    }

    @Override
    public LiquidationContract findByIdProduct(int id) {
        return liquidationContractRepository.findByIdContract(id);
    }
}
