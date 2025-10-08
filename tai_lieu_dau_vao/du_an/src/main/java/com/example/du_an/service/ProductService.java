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

    @Override
    public boolean updateStatus(int productId, String status) {
        return productRepository.updateStatus(productId, status);
    }


    @Override
    public boolean updateStatusToLiquidated(int productId) {
        return productRepository.updateStatusToLiquidated(productId);
    }

    @Override
    public List<Product> findByStatus(String status) {
        return productRepository.findByStatus(status);
    }

    @Override
    public void updateProductStatusForOverdueContracts() {
        productRepository.updateProductStatusForOverdueContracts();
    }
    @Override
    public boolean update(Product product) {
        // Có thể thêm các logic kiểm tra dữ liệu ở đây nếu cần
        if (product == null || product.getProductId() <= 0) {
            return false;
        }
        return productRepository.update(product);
    }
}
