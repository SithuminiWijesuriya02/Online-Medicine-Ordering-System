package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import model.Admin;
import utils.DBConnect;

public class AdminService {
	
	// Register Admin
	public void regAdmin(Admin admin) {
	    String sql = "INSERT INTO admin (AdminID, AdminName, Email, Password, Phone) VALUES (?, ?, ?, ?, ?)";

	    try (Connection conn = DBConnect.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(sql)) {

	        stmt.setString(1, admin.getAdID());
	        stmt.setString(2, admin.getAdName());
	        stmt.setString(3, admin.getAdEmail());
	        stmt.setString(4, admin.getAdPassword());
	        stmt.setString(5, admin.getAdphone());

	        stmt.executeUpdate();
	        System.out.println("Admin registered successfully.");

	    } catch (Exception e) {
	        System.out.println("Error while inserting admin:");
	        e.printStackTrace(); // Show full error
	    }
	}

	
	// Generate new Admin ID like ad001, ad002, ...
	public String generateAdminId() {
	    String id = "ad001";
	    try (Connection conn = DBConnect.getConnection();
	         Statement stmt = conn.createStatement();
	         ResultSet rs = stmt.executeQuery("SELECT AdminID FROM admin ORDER BY AdminID DESC LIMIT 1")) {

	        if (rs.next()) {
	            String lastId = rs.getString("AdminID"); 
	            int num = Integer.parseInt(lastId.substring(1)); 
	            num++;
	            id = String.format("ad%03d", num);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return id;
	}

	
	public Admin getAdminEmail(String Email) throws ClassNotFoundException {
	    String query = "SELECT * FROM admin WHERE Email = ?";

	    try (Connection connection = DBConnect.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(query)) {

	        stmt.setString(1, Email);
	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            Admin admin = new Admin();
	            admin.setAdID(rs.getString("AdminID"));
	            admin.setAdName(rs.getString("AdminName"));
	            admin.setAdEmail(rs.getString("Email"));
	            admin.setAdPassword(rs.getString("Password"));
	            admin.setAdphone(rs.getString("Phone"));

	            return admin;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	
	
	// Validate Admin Credentials
	public boolean validateAdmin(Admin admin) {
	    String query = "SELECT * FROM admin WHERE Email = ? AND Password = ?";

	    try (Connection conn = DBConnect.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query)) {

	        stmt.setString(1, admin.getAdEmail());
	        stmt.setString(2, admin.getAdPassword());

	        ResultSet rs = stmt.executeQuery();
	        return rs.next(); // return true if admin found

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}

	
	public Admin getAdmin(Admin admin) {
	    try {
	        String query = "SELECT * FROM admin WHERE Email = ? AND Password = ?";

	        Connection conn = DBConnect.getConnection();
	        PreparedStatement stmt = conn.prepareStatement(query);

	        stmt.setString(1, admin.getAdEmail());
	        stmt.setString(2, admin.getAdPassword());

	        ResultSet rs = stmt.executeQuery();

	        if (rs.next()) {
	            Admin adm = new Admin();
	            adm.setAdID(rs.getString("AdminID"));
	            adm.setAdName(rs.getString("AdminName"));
	            adm.setAdEmail(rs.getString("Email"));
	            adm.setAdPassword(rs.getString("Password"));
	            adm.setAdphone(rs.getString("Phone"));

	            return adm;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return null;
	}

	
	// update admin
	public boolean updateAdmin(Admin admin) {

	    String query = "UPDATE admin SET AdminName = ?, Email = ?, Password = ? Phone = ? WHERE AdminID = ?";

	    try (Connection conn = DBConnect.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query)) {

	        stmt.setString(1, admin.getAdName());
	        stmt.setString(2, admin.getAdEmail());
	        stmt.setString(3, admin.getAdPassword());	       
	        stmt.setString(4, admin.getAdphone());
	        stmt.setString(5, admin.getAdID());
	        
	        int rows = stmt.executeUpdate();
	        return rows > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;
	}
	

	 // Delete admin
	    public boolean deleteAdmin(Admin admin) {
	        String query = "DELETE FROM admin WHERE Email = ?";
	
	        try (Connection conn = DBConnect.getConnection();
	             PreparedStatement stmt = conn.prepareStatement(query)) {
	
	            stmt.setString(1, admin.getAdEmail());
	            return stmt.executeUpdate() > 0;
	
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

	
}
