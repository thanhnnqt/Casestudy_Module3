package com.example.du_an.repository;

import com.example.du_an.dto.LiquidationProductDto;
import com.example.du_an.entity.LiquidationContract;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class LiquidationContractRepository implements ILiquidationContractRepository {
    private static final String SELECT_ALL = "select l.liquidation_contract_id, c.full_name, l.liquidation_date, l.price, p.product_name\n" +
            "from liquidation_contract l join product p on p.product_id = l.product_id left join customer c on c.customer_id = l.customer_id";
    private static final String INSERT = "insert into liquidation_contract " +
            "(liquidation_date, price, customer_id, employee_id, product_id) values(?, ?, ?, ?, ?)";
    private static final String DELETE = "delete from liquidation_contract where liquidation_contract_id = ?";
    private static final String FIND_PRODUCT ="select product_id, product_name from product where status = 'Thanh lý'";

    @Override
    public List<LiquidationContract> findAll() {
        List<LiquidationContract> liquidationContractList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                int liquidationContractId = rs.getInt("liquidation_contract_id");
                String customerName = rs.getString("full_name");
                LocalDate liquidationDate = rs.getDate("liquidation_date").toLocalDate();
                double price = rs.getDouble("price");
                String productName = rs.getString("product_name");
                LiquidationContract liquidationContract = new LiquidationContract(liquidationContractId, customerName, liquidationDate, price, productName);
                liquidationContractList.add(liquidationContract);
            }
        } catch (SQLException e) {
            System.out.println("Error when getting products: " + e.getMessage());
        }
        return liquidationContractList;
    }

    @Override
    public boolean add(LiquidationContract liquidationContract) {
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(INSERT)) {
            ps.setDate(1, Date.valueOf(liquidationContract.getLiquidationDate()));
            ps.setDouble(2, liquidationContract.getLiquidationPrice());
            ps.setInt(3, liquidationContract.getCustomerId());
            ps.setInt(4, liquidationContract.getEmployeeId());
            ps.setInt(5, liquidationContract.getProductId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean delete(int id) {
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(DELETE)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    @Override
    public LiquidationContract findById(int id) {
        return null;
    }

    public List<LiquidationContract> search(String customerName, String productName) {
        List<LiquidationContract> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("select l.liquidation_contract_id, c.full_name, " +
                "l.liquidation_date, l.price, p.product_name from liquidation_contract l " +
                "join product p on p.product_id = l.product_id left join customer c " +
                "on c.customer_id = l.customer_id where 1 = 1");

        if (customerName != null && !customerName.isEmpty()) {
            sql.append(" and c.full_name like ?");
        }
        if (productName != null && !productName.isEmpty()) {
            sql.append(" and p.product_name like ?");
        }
        try (Connection connection = BaseRepository.getConnectDB();
             PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int index = 1;
            if (customerName != null && !customerName.isEmpty()) {
                ps.setString(index++, "%" + customerName + "%");
            }
            if (productName != null && !productName.isEmpty()) {
                ps.setString(index++, "%" + productName + "%");
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new LiquidationContract(
                        rs.getInt("liquidation_contract_id"),
                        rs.getString("full_name"),
                        rs.getDate("liquidation_date").toLocalDate(),
                        rs.getDouble("price"),
                        rs.getString("product_name")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public LiquidationContract findByIdContract(int id) {
        return null;
    }

    @Override
    public List<LiquidationProductDto> findProduct() {
        List<LiquidationProductDto> productListNameId = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement ps = connection.prepareStatement(FIND_PRODUCT);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int id = rs.getInt("product_id");
                String name = rs.getString("product_name");
                productListNameId.add(new LiquidationProductDto(id, name));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return productListNameId;
    }
}
