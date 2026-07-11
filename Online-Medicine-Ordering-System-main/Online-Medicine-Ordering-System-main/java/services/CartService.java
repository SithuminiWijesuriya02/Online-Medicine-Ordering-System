package services;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import model.Cart;
import model.CartItemDetails;
import utils.DBConnect;

public class CartService {
	
    private Connection conn = DBConnect.getConnection();

 	//Add to Cart method
    public boolean addToCart(String email, String medId, int qty) {
        try (Connection conn = DBConnect.getConnection()) {
            String checkSql = "SELECT Quantity FROM cart WHERE Email = ? AND MedId = ?";
            PreparedStatement checkStmt = conn.prepareStatement(checkSql);
            checkStmt.setString(1, email);
            checkStmt.setString(2, medId);
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                int newQty = rs.getInt("Quantity") + qty;
                String updateSql = "UPDATE cart SET Quantity = ? WHERE Email = ? AND MedId = ?";
                PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                updateStmt.setInt(1, newQty);
                updateStmt.setString(2, email);
                updateStmt.setString(3, medId);
                return updateStmt.executeUpdate() > 0;
            } else {
                String insertSql = "INSERT INTO cart (Email, MedId, Quantity) VALUES (?, ?, ?)";
                PreparedStatement insertStmt = conn.prepareStatement(insertSql);
                insertStmt.setString(1, email);
                insertStmt.setString(2, medId);
                insertStmt.setInt(3, qty);
                return insertStmt.executeUpdate() > 0;
            }

        } catch (Exception e) {
            System.out.println(" Error in CartService");
            e.printStackTrace();
            return false;
        }
    }

    

    public List<Cart> getUserCart(String email) {
        List<Cart> list = new ArrayList<>();
        try {
            PreparedStatement stmt = conn.prepareStatement("SELECT * FROM cart WHERE Email = ?");
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Cart c = new Cart();
                c.setEmail(rs.getString("Email"));
                c.setMedId(rs.getString("MedId"));
                c.setQuantity(rs.getInt("Quantity"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    

    public List<CartItemDetails> getUserCartDetails(String email) {
        List<CartItemDetails> list = new ArrayList<>();

        try (Connection conn = DBConnect.getConnection()) {
            String query = "SELECT c.MedId, m.MedName, c.Quantity, m.UnitPrice, m.Image, m.Brand, m.Type, m.Dosage " +
                           "FROM cart c JOIN medicine m ON c.MedId = m.MedId WHERE c.Email = ?";

            PreparedStatement stmt = conn.prepareStatement(query);
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                CartItemDetails item = new CartItemDetails();
                item.setMedId(rs.getString("MedId"));
                item.setMedName(rs.getString("MedName"));
                item.setQuantity(rs.getInt("Quantity"));
                item.setUnitPrice(rs.getDouble("UnitPrice"));
                item.setImage(rs.getBytes("Image")); 
                item.setBrand(rs.getString("Brand"));
                item.setType(rs.getString("Type"));
                item.setDosage(rs.getString("Dosage"));

                list.add(item);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }



    //update quantity
    public boolean updateQuantity(String email, String medId, int qty) {
        try {
            PreparedStatement stmt = conn.prepareStatement("UPDATE cart SET quantity = ? WHERE Email = ? AND MedId = ?");
            stmt.setInt(1, qty);
            stmt.setString(2, email);
            stmt.setString(3, medId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    
    //delete cart item
    public boolean deleteCartItem(String email, String medId) {
        try {
            PreparedStatement stmt = conn.prepareStatement("DELETE FROM cart WHERE Email = ? AND MedId = ?");
            stmt.setString(1, email);
            stmt.setString(2, medId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
