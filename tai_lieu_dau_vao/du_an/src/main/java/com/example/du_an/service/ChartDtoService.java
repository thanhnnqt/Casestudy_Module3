package com.example.du_an.service;

import com.example.du_an.dto.ChartDto;
import com.example.du_an.repository.ChartDtoRepository;
import com.example.du_an.repository.IChartDtoRepository;

import java.util.List;

public class ChartDtoService implements IChartDtoService {
    IChartDtoRepository chartDtoRepository = new ChartDtoRepository();
    @Override
    public List<ChartDto> findAll() {
        return chartDtoRepository.findAll();
    }
}
