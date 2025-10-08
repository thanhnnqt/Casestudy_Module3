package com.example.du_an.repository;

import com.example.du_an.entity.Product;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductRepository implements IProductRepository {

    @Override
    public boolean create(Product product) {
        String sql = "INSERT INTO product(product_name, description, pawn_price, status) VALUES (?, ?, ?, ?)";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPawnPrice());
            ps.setString(4, product.getStatus().name());
            int affectedRows = ps.executeUpdate();
            if (affectedRows == 0) return false;
            try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    product.setProductId(generatedKeys.getInt(1));
                }
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public Product findById(int id) {
        String sql = "SELECT * FROM product WHERE product_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToProduct(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public Product findByName(String name) {
        String sql = "SELECT * FROM product WHERE product_name = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToProduct(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Product> findAll() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM product";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setProductName(rs.getString("product_name"));
        product.setDescription(rs.getString("description"));
        product.setPawnPrice(rs.getBigDecimal("pawn_price"));
        String statusStr = rs.getString("status");
        if (statusStr != null) {
            try {
                product.setStatus(Product.Status.valueOf(statusStr));
            } catch (IllegalArgumentException e) {
                product.setStatus(null);
            }
        }
        return product;
    }

    @Override
    public boolean updateStatus(int productId, String status) {
        String sql = "UPDATE product SET status = ? WHERE product_id = ?";
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean updateStatusToLiquidated(int productId) {
        return updateStatus(productId, "THANH_LY");
    }

    @Override
    public List<Product> findByStatus(String status) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT product_id, product_name FROM product WHERE status = ?";
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    products.add(new Product(rs.getInt("product_id"), rs.getString("product_name")));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public void updateProductStatusForOverdueContracts() {
        String sql = """
        UPDATE product p
        SET p.status = 'CO_THE_THANH_LY'
        WHERE p.status = 'DANG_CAM' AND p.product_id IN (
            SELECT pc.product_id
            FROM pawn_contract pc
            WHERE pc.due_date < CURDATE()
            AND pc.return_date IS NULL
        )
        """;
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                System.out.println("✅ [AUTO-UPDATE] Đã cập nhật " + rowsAffected + " sản phẩm sang CO_THE_THANH_LY.");
            } else {
                System.out.println("ℹ️ [AUTO-UPDATE] Không tìm thấy sản phẩm nào cần cập nhật.");
            }
        } catch (SQLException e) {
            System.err.println("❌ [AUTO-UPDATE] Lỗi SQL: " + e.getMessage());
        }
    }
    @Override
    public boolean update(Product product) {
        // Thêm product_name vào câu lệnh SQL
        String sql = "UPDATE product SET product_name = ?, description = ?, pawn_price = ? WHERE product_id = ?";

        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            // Thêm tham số cho product_name
            ps.setString(1, product.getProductName());
            ps.setString(2, product.getDescription());
            ps.setBigDecimal(3, product.getPawnPrice());
            ps.setInt(4, product.getProductId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
}
}