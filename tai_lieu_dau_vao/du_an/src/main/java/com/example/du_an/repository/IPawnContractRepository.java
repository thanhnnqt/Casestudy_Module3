package com.example.du_an.repository;

import com.example.du_an.entity.PawnContract;

import java.util.List;

public interface IPawnContractRepository {
    List<PawnContract> findInterestRate();
}
