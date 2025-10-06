package com.example.du_an.service;



import com.example.du_an.entity.Product;
import com.example.du_an.repository.IProductRepository;
import com.example.du_an.repository.ProductRepository;

import java.util.List;

public class ProductService implements IProductService {

    private final IProductRepository productRepository = new ProductRepository();

    @Override
    public boolean create(Product product) {
        return productRepository.create(product);
    }

    @Override
    public Product findById(int id) {
        return productRepository.findById(id);
    }

    @Override
    public Product findByName(String name) {
        return productRepository.findByName(name);
    }

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }
    public boolean updateStatusToLiquidated(int productId) {
        return productRepository.updateStatusToLiquidated(productId);
    }
    @Override
    public List<Product> findByStatus(String status) {
        return productRepository.findByStatus(status);
    }
}
