package com.example.du_an.service;



import com.example.du_an.entity.Product;

import java.util.List;

public interface IProductService {
    boolean create(Product product);
    Product findById(int id);
    Product findByName(String name);
    List<Product> findAll();
}
