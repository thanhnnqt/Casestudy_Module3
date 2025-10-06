package com.example.du_an.service;


import com.example.du_an.dto.PawnContractDto;
import com.example.du_an.entity.PawnContract;
import com.example.du_an.repository.IPawnContractRepository;
import com.example.du_an.repository.PawnContractRepository;

import java.util.List;

public class PawnContractService implements IPawnContractService{
    private final IPawnContractRepository pawnContractRepository = new PawnContractRepository();

    @Override
    public List<PawnContractDto> findAll() {
        return pawnContractRepository.findAll();
    }

    @Override
    public boolean add(PawnContract pawnContract) {
        return pawnContractRepository.add(pawnContract);
    }

    @Override
    public boolean delete(int id) {
        return pawnContractRepository.delete(id);
    }

    @Override
    public boolean update(PawnContract pawnContract) {
        return pawnContractRepository.update(pawnContract);
    }

    @Override
    public PawnContractDto findById(int id) {
        return pawnContractRepository.findById(id);
    }

    @Override
    public List<PawnContractDto> search(String customerName, String employeeName, String productName) {
        return pawnContractRepository.search(customerName, employeeName, productName);
    }

    @Override
    public PawnContract findByIdProduct(int id) {
        return pawnContractRepository.findByIdProduct(id);
    }

    @Override
    public List<PawnContractDto> findAll(int offset, int limit) {
        return pawnContractRepository.findAll(offset, limit);
    }

    @Override
    public int countPawnContract() {
        return pawnContractRepository.countPawnContract();
    }
}
