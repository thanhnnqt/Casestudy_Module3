package com.example.du_an.repository;

import com.example.du_an.dto.PawnContractDto;
import com.example.du_an.entity.PawnContract;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class PawnContractRepository implements IPawnContractRepository {

    private final String STATUS_CASE_SQL = """
        CASE
            WHEN pc.return_date IS NOT NULL THEN 'DA_CHUOC'
            WHEN p.status = 'DA_THANH_LY' THEN 'DA_THANH_LY'
            WHEN p.status = 'THANH_LY' THEN 'THANH_LY'
            WHEN pc.due_date < CURDATE() AND pc.return_date IS NULL THEN 'CO_THE_THANH_LY'
            ELSE 'DANG_CAM'
        END
    """;

    @Override
    public List<PawnContractDto> findAll() {
        List<PawnContractDto> result = new ArrayList<>();
        String sql = "SELECT pc.*, c.full_name AS customer_name, e.full_name AS employee_name, p.product_name, " +
                STATUS_CASE_SQL + " AS status" +
                " FROM pawn_contract pc" +
                " LEFT JOIN customer c ON pc.customer_id = c.customer_id" +
                " LEFT JOIN employee e ON pc.employee_id = e.employee_id" +
                " LEFT JOIN product p ON pc.product_id = p.product_id" +
                " ORDER BY pc.pawn_contract_id DESC";

        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                result.add(mapToPawnContractDto(rs));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi SQL trong findAll: " + e.getMessage(), e);
        }
        return result;
    }

    @Override
    public boolean add(PawnContract contract) {
        String sql = "INSERT INTO pawn_contract " +
                "(customer_id, employee_id, product_id, pawn_price, interest_rate, pawn_date, due_date, return_date) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, contract.getCustomerId());
            stmt.setInt(2, contract.getEmployeeId());
            stmt.setInt(3, contract.getProductId());
            stmt.setBigDecimal(4, contract.getPawnPrice());
            if (contract.getInterestRate() != null) {
                stmt.setBigDecimal(5, contract.getInterestRate());
            } else {
                stmt.setNull(5, Types.DECIMAL);
            }
            stmt.setDate(6, Date.valueOf(contract.getPawnDate()));
            stmt.setDate(7, Date.valueOf(contract.getDueDate()));
            if (contract.getReturnDate() != null) {
                stmt.setDate(8, Date.valueOf(contract.getReturnDate()));
            } else {
                stmt.setNull(8, Types.DATE);
            }
            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        contract.setPawnContractId(rs.getInt(1));
                    }
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi SQL khi thêm hợp đồng: " + e.getMessage());
        }
    }

    @Override
    public boolean delete(int id) {
        String sql = "DELETE FROM pawn_contract WHERE pawn_contract_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi xóa hợp đồng cầm: " + e.getMessage(), e);
        }
    }

    @Override
    public boolean update(PawnContract pawnContract) {
        String sql = "UPDATE pawn_contract SET customer_id = ?, employee_id = ?, product_id = ?, " +
                "pawn_date = ?, pawn_price = ?, interest_rate = ?, due_date = ?, return_date = ? " +
                "WHERE pawn_contract_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, pawnContract.getCustomerId());
            stmt.setInt(2, pawnContract.getEmployeeId());
            stmt.setInt(3, pawnContract.getProductId());
            stmt.setDate(4, pawnContract.getPawnDate() != null ? Date.valueOf(pawnContract.getPawnDate()) : null);
            stmt.setBigDecimal(5, pawnContract.getPawnPrice());
            if (pawnContract.getInterestRate() != null) {
                stmt.setBigDecimal(6, pawnContract.getInterestRate());
            } else {
                stmt.setNull(6, Types.DECIMAL);
            }
            stmt.setDate(7, pawnContract.getDueDate() != null ? Date.valueOf(pawnContract.getDueDate()) : null);
            if (pawnContract.getReturnDate() != null) {
                stmt.setDate(8, Date.valueOf(pawnContract.getReturnDate()));
            } else {
                stmt.setNull(8, Types.DATE);
            }
            stmt.setInt(9, pawnContract.getPawnContractId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi cập nhật hợp đồng cầm: " + e.getMessage(), e);
        }
    }

    @Override
    public PawnContractDto findById(int id) {
        String sql = "SELECT pc.*, c.full_name AS customer_name, e.full_name AS employee_name, p.product_name, " +
                STATUS_CASE_SQL + " AS status" +
                " FROM pawn_contract pc" +
                " LEFT JOIN customer c ON pc.customer_id = c.customer_id" +
                " LEFT JOIN employee e ON pc.employee_id = e.employee_id" +
                " LEFT JOIN product p ON pc.product_id = p.product_id" +
                " WHERE pc.pawn_contract_id = ?";

        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapToPawnContractDto(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi SQL trong findById: " + e.getMessage(), e);
        }
        return null;
    }

    @Override
    public List<PawnContractDto> search(String customerName, String employeeName, String productName, String status) {
        List<PawnContractDto> result = new ArrayList<>();
        String baseSql = "SELECT pc.*, c.full_name AS customer_name, e.full_name AS employee_name, p.product_name, " +
                STATUS_CASE_SQL + " AS status";

        String fromSql = " FROM pawn_contract pc " +
                "LEFT JOIN customer c ON pc.customer_id = c.customer_id " +
                "LEFT JOIN employee e ON pc.employee_id = e.employee_id " +
                "LEFT JOIN product p ON pc.product_id = p.product_id";

        StringBuilder sql = new StringBuilder(baseSql).append(fromSql);
        List<Object> params = new ArrayList<>();
        StringBuilder whereClause = new StringBuilder(" WHERE 1=1");

        if (customerName != null && !customerName.trim().isEmpty()) {
            whereClause.append(" AND c.full_name LIKE ?");
            params.add("%" + customerName + "%");
        }
        if (employeeName != null && !employeeName.trim().isEmpty()) {
            whereClause.append(" AND e.full_name LIKE ?");
            params.add("%" + employeeName + "%");
        }
        if (productName != null && !productName.trim().isEmpty()) {
            whereClause.append(" AND p.product_name LIKE ?");
            params.add("%" + productName + "%");
        }

        sql.append(whereClause);

        if (status != null && !status.trim().isEmpty()) {
            sql.append(" HAVING status = ?");
            params.add(status);
        }

        sql.append(" ORDER BY pc.pawn_contract_id DESC");

        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    result.add(mapToPawnContractDto(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm kiếm hợp đồng: " + e.getMessage(), e);
        }
        return result;
    }

    @Override
    public PawnContract findByIdProduct(int id) {
        String sql = "SELECT * FROM pawn_contract WHERE product_id = ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapToPawnContract(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm hợp đồng theo ID sản phẩm: " + e.getMessage(), e);
        }
        return null;
    }

    @Override
    public List<PawnContractDto> findAll(int offset, int limit) {
        List<PawnContractDto> result = new ArrayList<>();
        String sql = "SELECT pc.*, c.full_name AS customer_name, e.full_name AS employee_name, p.product_name, " +
                STATUS_CASE_SQL + " AS status" +
                " FROM pawn_contract pc" +
                " LEFT JOIN customer c ON pc.customer_id = c.customer_id" +
                " LEFT JOIN employee e ON pc.employee_id = e.employee_id" +
                " LEFT JOIN product p ON pc.product_id = p.product_id" +
                " ORDER BY pc.pawn_contract_id DESC LIMIT ? OFFSET ?";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, offset);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    result.add(mapToPawnContractDto(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy danh sách hợp đồng phân trang: " + e.getMessage(), e);
        }
        return result;
    }

    @Override
    public int countPawnContract() {
        String sql = "SELECT COUNT(*) FROM pawn_contract";
        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi đếm số lượng hợp đồng cầm: " + e.getMessage(), e);
        }
        return 0;
    }

    private PawnContractDto mapToPawnContractDto(ResultSet rs) throws SQLException {
        PawnContractDto dto = new PawnContractDto();
        dto.setPawnContractId(rs.getInt("pawn_contract_id"));
        dto.setCustomerName(rs.getString("customer_name"));
        dto.setEmployeeName(rs.getString("employee_name"));
        dto.setProductName(rs.getString("product_name"));
        dto.setPawnDate(rs.getDate("pawn_date") != null ? rs.getDate("pawn_date").toLocalDate() : null);
        dto.setPawnPrice(rs.getBigDecimal("pawn_price"));
        dto.setInterestRate(rs.getBigDecimal("interest_rate"));
        dto.setDueDate(rs.getDate("due_date") != null ? rs.getDate("due_date").toLocalDate() : null);
        dto.setReturnDate(rs.getDate("return_date") != null ? rs.getDate("return_date").toLocalDate() : null);
        dto.setStatus(rs.getString("status"));
        dto.setCustomerId(rs.getInt("customer_id"));
        dto.setEmployeeId(rs.getInt("employee_id"));
        dto.setProductId(rs.getInt("product_id"));
        return dto;
    }

    private PawnContract mapToPawnContract(ResultSet rs) throws SQLException {
        return new PawnContract(
                rs.getInt("pawn_contract_id"),
                rs.getInt("customer_id"),
                rs.getInt("employee_id"),
                rs.getInt("product_id"),
                rs.getDate("pawn_date") != null ? rs.getDate("pawn_date").toLocalDate() : null,
                rs.getBigDecimal("pawn_price"),
                rs.getBigDecimal("interest_rate"),
                rs.getDate("due_date") != null ? rs.getDate("due_date").toLocalDate() : null,
                rs.getDate("return_date") != null ? rs.getDate("return_date").toLocalDate() : null
        );
    }

    public List<PawnContractDto> findContractsNearDueDate(int daysBefore) {
        List<PawnContractDto> contracts = new ArrayList<>();
        String sql = "SELECT pc.*, c.email, c.full_name AS customer_name, p.product_name, " +
                STATUS_CASE_SQL + " AS status" +
                " FROM pawn_contract pc" +
                " JOIN customer c ON pc.customer_id = c.customer_id" +
                " JOIN product p ON pc.product_id = p.product_id" +
                " WHERE DATEDIFF(pc.due_date, CURDATE()) <= ?" +
                " AND DATEDIFF(pc.due_date, CURDATE()) >= 0" +
                " AND pc.return_date IS NULL" +
                " AND pc.due_date IS NOT NULL";

        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, daysBefore);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    contracts.add(mapToPawnContractDto(rs));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi tìm hợp đồng gần đến hạn: " + e.getMessage(), e);
        }
        return contracts;
    }

    @Override
    public PawnContractDto getDetail(int id) {
        String sql = "SELECT pc.*, c.full_name AS customer_name, c.email AS customer_email, c.dob AS customer_dob, " +
                "c.citizen_number, e.full_name AS employee_name, p.product_name, p.description AS product_description, " +
                "p.pawn_price AS product_value, " + STATUS_CASE_SQL + " AS status" +
                " FROM pawn_contract pc" +
                " JOIN customer c ON pc.customer_id = c.customer_id" +
                " JOIN employee e ON pc.employee_id = e.employee_id" +
                " JOIN product p ON pc.product_id = p.product_id" +
                " WHERE pc.pawn_contract_id = ?";

        try (Connection conn = BaseRepository.getConnectDB();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    PawnContractDto dto = mapToPawnContractDto(rs);
                    dto.setCustomerEmail(rs.getString("customer_email"));
                    dto.setCustomerDob(rs.getDate("customer_dob").toLocalDate());
                    dto.setCustomerCccd(rs.getString("citizen_number")); // Sửa lại tên cột nếu cần
                    dto.setProductDescription(rs.getString("product_description"));
                    dto.setProductValue(rs.getBigDecimal("product_value"));

                    // Giữ nguyên code của bạn
                    dto.setPawnPriceInWords(dto.getPawnPrice());
                    dto.setProductValueInWords(dto.getProductValue());

                    return dto;
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Lỗi khi lấy chi tiết hợp đồng: " + e.getMessage(), e);
        }
        return null;
    }
}