package services;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import model.Medicine;
import utils.DBConnect;

public class MedicineService {

    // Add new medicine
	public boolean addMedicine(Medicine med) {
	    String query = "INSERT INTO medicine (MedId, MedName, Brand, Quantity, UnitPrice, Type, Description, Image, Dosage, Category) " +
	                   "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DBConnect.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query)) {

	        stmt.setString(1, med.getMedId());
	        stmt.setString(2, med.getMedName());
	        stmt.setString(3, med.getBrand());
	        stmt.setInt(4, med.getQuantity());
	        stmt.setDouble(5, med.getUnitPrice());
	        stmt.setString(6, med.getType());
	        stmt.setString(7, med.getDescription());
	        stmt.setBytes(8, med.getImage()); 
	        stmt.setString(9, med.getDosage());     
	        stmt.setString(10, med.getCategory());   

	        return stmt.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

    public String generateMedicineId() {
        String id = "M001";
        String query = "SELECT MedId FROM medicine ORDER BY MedId DESC LIMIT 1";

        try (Connection conn = DBConnect.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

            if (rs.next()) {
                String lastId = rs.getString("MedId"); // e.g., M005
                int num = Integer.parseInt(lastId.substring(1)); // get 5
                num++;
                id = String.format("M%03d", num); // M006
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return id;
    }

    
    // Get all medicines
    public ArrayList<Medicine> getAllMedicines() {
        ArrayList<Medicine> list = new ArrayList<>();

        String query = "SELECT * FROM medicine";

        try (Connection conn = DBConnect.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {

        	while (rs.next()) {
        	    Medicine med = new Medicine();
        	    med.setMedId(rs.getString("MedId"));
        	    med.setMedName(rs.getString("MedName"));
        	    med.setBrand(rs.getString("Brand"));
        	    med.setQuantity(rs.getInt("Quantity"));
        	    med.setUnitPrice(rs.getDouble("UnitPrice"));
        	    med.setType(rs.getString("Type"));
        	    med.setDescription(rs.getString("Description"));
        	    med.setImage(rs.getBytes("Image"));
        	    med.setDosage(rs.getString("Dosage"));             
        	    med.setCategory(rs.getString("Category"));         

        	    list.add(med);
        	}

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // Get medicine by ID
    public Medicine getMedicineById(String id) {
        String query = "SELECT * FROM medicine WHERE MedId = ?";
        Medicine med = null;

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                med = new Medicine();
                med.setMedId(rs.getString("MedId"));
                med.setMedName(rs.getString("MedName"));
                med.setBrand(rs.getString("Brand"));
                med.setQuantity(rs.getInt("Quantity"));
                med.setUnitPrice(rs.getDouble("UnitPrice"));
                med.setType(rs.getString("Type"));
                med.setDescription(rs.getString("Description"));
                med.setImage(rs.getBytes("Image"));
                med.setDosage(rs.getString("Dosage"));
                med.setCategory(rs.getString("Category"));
            } 

        } catch (Exception e) {
            e.printStackTrace();
        }

        return med;
    }

    // Update medicine
    public boolean updateMedicine(Medicine med) {
        String query;

        // Update with or without image
        if (med.getImage() != null) {
            query = "UPDATE medicine SET MedName = ?, Brand = ?, Quantity = ?, UnitPrice = ?, Type = ?, Description = ?, Image = ?, Dosage = ?, Category = ? WHERE MedId = ?";
        } else {
            query = "UPDATE medicine SET MedName = ?, Brand = ?, Quantity = ?, UnitPrice = ?, Type = ?, Description = ?, Dosage = ?, Category = ? WHERE MedId = ?";
        }

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, med.getMedName());
            stmt.setString(2, med.getBrand());
            stmt.setInt(3, med.getQuantity());
            stmt.setDouble(4, med.getUnitPrice());
            stmt.setString(5, med.getType());
            stmt.setString(6, med.getDescription());
            stmt.setString(7, med.getDosage());
            stmt.setString(8, med.getCategory());

            if (med.getImage() != null) {
                stmt.setBytes(9, med.getImage());
                stmt.setString(10, med.getMedId());
            } else {
                stmt.setString(9, med.getMedId());
            }

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete medicine
    public boolean deleteMedicine(Medicine med) {
        String query = "DELETE FROM medicine WHERE MedId = ?";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setString(1, med.getMedId());
            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Medicine> getLowStockItems() {
        List<Medicine> lowStock = new ArrayList<>();
        String query = "SELECT * FROM medicine WHERE Quantity < 20 ORDER BY Quantity ASC";

        try (Connection conn = DBConnect.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Medicine med = new Medicine();
                med.setMedId(rs.getString("MedId"));
                med.setMedName(rs.getString("MedName"));
                med.setCategory(rs.getString("Category"));
                med.setQuantity(rs.getInt("Quantity"));
                med.setUnitPrice(rs.getDouble("UnitPrice"));
                med.setBrand(rs.getString("Brand"));
                lowStock.add(med);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return lowStock;
    }
    
    public boolean updateMedicineStock(Medicine med) {
        String query = "UPDATE medicine SET Quantity = ? WHERE MedId = ?";
        try (Connection conn = DBConnect.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {

            stmt.setInt(1, med.getQuantity());
            stmt.setString(2, med.getMedId());

            int rows = stmt.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
