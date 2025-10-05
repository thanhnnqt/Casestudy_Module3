package com.example.du_an.dto;

public class ChartDto {
    private double interestRate;
    private int month;

    public ChartDto() {
    }

    public ChartDto(double interestRate, int month) {
        this.interestRate = interestRate;
        this.month = month;
    }

    public double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(double interestRate) {
        this.interestRate = interestRate;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }
}
