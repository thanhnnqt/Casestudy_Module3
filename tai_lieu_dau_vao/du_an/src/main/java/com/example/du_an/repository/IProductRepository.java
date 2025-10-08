package com.example.du_an.repository;


import com.example.du_an.entity.Product;

import java.util.List;

public interface IProductRepository {
    boolean create(Product product);
    Product findById(int id);
    Product findByName(String name);
    List<Product> findAll();
    boolean updateStatusToLiquidated(int productId);
    boolean updateStatus(int productId, String status);
    List<Product> findByStatus(String status);
    void updateProductStatusForOverdueContracts();
    boolean update(Product product);
}
