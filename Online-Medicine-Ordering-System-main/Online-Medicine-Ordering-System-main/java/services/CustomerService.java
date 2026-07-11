package services;

import model.Customer;
import utils.DBConnect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class CustomerService {

    // Register Customer
    public void regCustomer(Customer cus) {
        String sql = "INSERT INTO customer (CusID, FirstName, LastName, Email, Phone, Password, DOB, Street, City, State, ZipCode) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, cus.getCusID());
            stmt.setString(2, cus.getFirstName());
            stmt.setString(3, cus.getLastName());
            stmt.setString(4, cus.getEmail());
            stmt.setString(5, cus.getPhone());
            stmt.setString(6, cus.getPassword());
            stmt.setDate(7, cus.getDob());
            stmt.setString(8, cus.getStreet());
            stmt.setString(9, cus.getCity());
            stmt.setString(10, cus.getState());
            stmt.setString(11, cus.getZipCode());

            stmt.executeUpdate();
            System.out.println("Customer registered successfully.");

        } catch (Exception e) {
            System.out.println("Error while inserting:");
            e.printStackTrace();
        }
    }

    // Generate Customer ID (C001, C002...)
    public String generateCustomerId() {
        String id = "C001";
        try (Connection conn = DBConnect.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT CusID FROM customer ORDER BY CusID DESC LIMIT 1")) {

            if (rs.next()) {
                String lastId = rs.getString("CusID");
                int num = Integer.parseInt(lastId.substring(1));
                num++;
                id = String.format("C%03d", num);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    // Validate login credentials
    public boolean validate(Customer cus) {
        String query = "SELECT * FROM customer WHERE Email = ? AND Password = ?";
        try (Connection connection = DBConnect.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, cus.getEmail());
            stmt.setString(2, cus.getPassword());

            ResultSet rs = stmt.executeQuery();
            return rs.next();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get full customer details by ID
    public Customer getCustomerByCusID(String cusId) {
        String query = "SELECT * FROM customer WHERE CusID = ?";

        try (Connection connection = DBConnect.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, cusId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCusID(rs.getString("CusID"));
                customer.setFirstName(rs.getString("FirstName"));
                customer.setLastName(rs.getString("LastName"));
                customer.setEmail(rs.getString("Email"));
                customer.setPhone(rs.getString("Phone"));
                customer.setPassword(rs.getString("Password"));
                customer.setDob(rs.getDate("DOB"));
                customer.setStreet(rs.getString("Street"));
                customer.setCity(rs.getString("City"));
                customer.setState(rs.getString("State"));
                customer.setZipCode(rs.getString("ZipCode"));
                return customer;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    // Update customer
    public boolean updateCustomer(Customer cus) {
        String query = "UPDATE customer SET FirstName=?, LastName=?, Email=?, Phone=?, Password=?, DOB=?, Street=?, City=?, State=?, ZipCode=? WHERE CusID=?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, cus.getFirstName());
            stmt.setString(2, cus.getLastName());
            stmt.setString(3, cus.getEmail());
            stmt.setString(4, cus.getPhone());
            stmt.setString(5, cus.getPassword());
            stmt.setDate(6, cus.getDob());
            stmt.setString(7, cus.getStreet());
            stmt.setString(8, cus.getCity());
            stmt.setString(9, cus.getState());
            stmt.setString(10, cus.getZipCode());
            stmt.setString(11, cus.getCusID());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // Delete customer by email
    public boolean deleteCustomer(String email) {
        String query = "DELETE FROM customer WHERE Email = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, email);
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

    // Get customer by email & password (login)
    public Customer getCus(Customer cus) {
        String query = "SELECT * FROM customer WHERE Email = ? AND Password = ?";

        try (Connection connection = DBConnect.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {

            stmt.setString(1, cus.getEmail());
            stmt.setString(2, cus.getPassword());
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Customer result = new Customer();
                result.setCusID(rs.getString("CusID"));
                result.setFirstName(rs.getString("FirstName"));
                result.setLastName(rs.getString("LastName"));
                result.setEmail(rs.getString("Email"));
                result.setPhone(rs.getString("Phone"));
                result.setPassword(rs.getString("Password"));
                result.setDob(rs.getDate("DOB"));
                result.setStreet(rs.getString("Street"));
                result.setCity(rs.getString("City"));
                result.setState(rs.getString("State"));
                result.setZipCode(rs.getString("ZipCode"));
                return result;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }
}
