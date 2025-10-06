package com.example.du_an.service;



import com.example.du_an.dto.PawnContractDto;
import com.example.du_an.entity.PawnContract;

import java.util.List;

public interface IPawnContractService {
    List<PawnContractDto> findAll();
    boolean add(PawnContract pawnContract);
    boolean delete(int id);
    boolean update(PawnContract pawnContract);
    PawnContractDto findById(int id);
    List<PawnContractDto> search(String customerName, String employeeName, String productName);
    PawnContract findByIdProduct(int id);
    List<PawnContractDto> findAll(int offset, int limit);
    int countPawnContract();
}
