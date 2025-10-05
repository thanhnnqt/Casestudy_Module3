package com.example.du_an.repository;

import com.example.du_an.dto.ChartDto;

import java.util.List;

public interface IChartDtoRepository {
    List<ChartDto> findAll();
}
