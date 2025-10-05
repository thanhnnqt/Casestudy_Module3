package com.example.du_an.repository;

import com.example.du_an.dto.EmployeeDto;
import com.example.du_an.entity.Account;
import com.example.du_an.entity.Employee;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class EmployeeRepository implements IEmployeeRepository {
    private static final String SELECT_ALL_EMPLOYEES = "SELECT e.*, a.username " +
            "FROM employee e JOIN account a ON e.account_id = a.account_id";
    private static final String INSERT_ACCOUNT = "INSERT INTO account(username, password_hash, `role`) VALUES(?, ?, ?)";
    private static final String INSERT_EMPLOYEE = "INSERT INTO employee(account_id, full_name, dob, phone_number, salary, email, citizen_number) VALUES(?, ?, ?, ?, ?, ?, ?)";
    private static final String FIND_BY_ID = "SELECT * FROM employee WHERE employee_id = ?";
    private static final String UPDATE_EMPLOYEE = "UPDATE employee SET full_name = ?, dob = ?, phone_number = ?, salary = ?, email = ?, citizen_number = ? WHERE employee_id = ?";
    private static final String SELECT_ACCOUNT_ID_FROM_EMPLOYEE = "SELECT account_id FROM employee WHERE employee_id = ?";
    private static final String DELETE_EMPLOYEE = "DELETE FROM employee WHERE employee_id = ?";
    private static final String DELETE_ACCOUNT = "DELETE FROM account WHERE account_id = ?";

    @Override
    public List<EmployeeDto> findAll() {
        List<EmployeeDto> employeeList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement ps = connection.prepareStatement(SELECT_ALL_EMPLOYEES);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                employeeList.add(new EmployeeDto(
                        rs.getInt("employee_id"),
                        rs.getInt("account_id"),
                        rs.getString("full_name"),
                        rs.getObject("dob", LocalDate.class),
                        rs.getString("phone_number"),
                        rs.getBigDecimal("salary"),
                        rs.getString("email"),
                        rs.getString("citizen_number"),
                        rs.getString("username")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employeeList;
    }

    @Override
    public boolean add(Employee employee, Account account) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            connection.setAutoCommit(false);


            PreparedStatement psAccount = connection.prepareStatement(INSERT_ACCOUNT, Statement.RETURN_GENERATED_KEYS);
            psAccount.setString(1, account.getUserName());
            psAccount.setString(2, account.getPassword());
            psAccount.setString(3, account.getRole());
            psAccount.executeUpdate();


            ResultSet rs = psAccount.getGeneratedKeys();
            int accountId = 0;
            if (rs.next()) {
                accountId = rs.getInt(1);
            }


            PreparedStatement psEmployee = connection.prepareStatement(INSERT_EMPLOYEE);
            psEmployee.setInt(1, accountId);
            psEmployee.setString(2, employee.getFullName());
            psEmployee.setObject(3, employee.getDob());
            psEmployee.setString(4, employee.getPhoneNumber());
            psEmployee.setBigDecimal(5, employee.getSalary());
            psEmployee.setString(6, employee.getEmail());
            psEmployee.setString(7, employee.getCitizenNumber());
            psEmployee.executeUpdate();

            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public boolean update(Employee employee) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement ps = connection.prepareStatement(UPDATE_EMPLOYEE);
            ps.setString(1, employee.getFullName());
            ps.setObject(2, employee.getDob());
            ps.setString(3, employee.getPhoneNumber());
            ps.setBigDecimal(4, employee.getSalary());
            ps.setString(5, employee.getEmail());
            ps.setString(6, employee.getCitizenNumber());
            ps.setInt(7, employee.getEmployeeId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean delete(int employeeId) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            connection.setAutoCommit(false);


            PreparedStatement psSelect = connection.prepareStatement(SELECT_ACCOUNT_ID_FROM_EMPLOYEE);
            psSelect.setInt(1, employeeId);
            ResultSet rs = psSelect.executeQuery();
            int accountId = 0;
            if (rs.next()) {
                accountId = rs.getInt("account_id");
            } else {
                connection.rollback();
                return false;
            }


            PreparedStatement psEmployee = connection.prepareStatement(DELETE_EMPLOYEE);
            psEmployee.setInt(1, employeeId);
            psEmployee.executeUpdate();


            PreparedStatement psAccount = connection.prepareStatement(DELETE_ACCOUNT);
            psAccount.setInt(1, accountId);
            psAccount.executeUpdate();

            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    @Override
    public Employee findById(int employeeId) {
        Connection connection = BaseRepository.getConnectDB();
        try {
            PreparedStatement ps = connection.prepareStatement(FIND_BY_ID);
            ps.setInt(1, employeeId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Employee(
                        rs.getInt("employee_id"),
                        rs.getInt("account_id"),
                        rs.getString("full_name"),
                        rs.getObject("dob", LocalDate.class),
                        rs.getString("phone_number"),
                        rs.getBigDecimal("salary"),
                        rs.getString("email"),
                        rs.getString("citizen_number")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<EmployeeDto> search(String keyword) {
        List<EmployeeDto> employeeList = new ArrayList<>();
        Connection connection = BaseRepository.getConnectDB();


        String sql = SELECT_ALL_EMPLOYEES + " WHERE e.full_name LIKE ?";

        int employeeId = -1;
        try {

            employeeId = Integer.parseInt(keyword);

            sql += " OR e.employee_id = ?";
        } catch (NumberFormatException e) {

        }

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + keyword + "%");
            if (employeeId != -1) {

                ps.setInt(2, employeeId);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                employeeList.add(new EmployeeDto(
                        rs.getInt("employee_id"),
                        rs.getInt("account_id"),
                        rs.getString("full_name"),
                        rs.getObject("dob", LocalDate.class),
                        rs.getString("phone_number"),
                        rs.getBigDecimal("salary"),
                        rs.getString("email"),
                        rs.getString("citizen_number"),
                        rs.getString("username")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return employeeList;
    }
}
