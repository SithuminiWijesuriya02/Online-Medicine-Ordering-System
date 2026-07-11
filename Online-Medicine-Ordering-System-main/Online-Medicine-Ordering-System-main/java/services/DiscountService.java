package services;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.util.ArrayList;

import model.Discount;
import utils.DBConnect;

public class DiscountService {
	
	//create discount
	public boolean addDiscount(Discount dis) {
	    String query = "INSERT INTO discount (Code, Description, Percentage, StartDate, EndDate) VALUES (?, ?, ?, ?, ?)";

	    try (Connection connection = DBConnect.getConnection();
		      PreparedStatement stmt = connection.prepareStatement(query)) {

	        stmt.setString(1, dis.getCode());
	        stmt.setString(2, dis.getDescription());
	        stmt.setInt(3, dis.getPercentage());
	        stmt.setDate(4, dis.getStartDate());
	        stmt.setDate(5, dis.getEndDate());

	        int rowsInserted = stmt.executeUpdate();
	        return rowsInserted > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	        return false;
	    }
	}

	//get all discount
	public ArrayList<Discount> getAllDiscount(){
		try {
			ArrayList<Discount> listDis = new ArrayList<Discount>();
			
			String query = "SELECT * FROM discount";
			
			Statement statement = DBConnect.getConnection().createStatement();
			ResultSet rs = statement.executeQuery(query);
			
			while(rs.next()) {
				Discount dis = new Discount();
				dis.setCode(rs.getString("code"));
				dis.setDescription(rs.getString("description"));
				dis.setPercentage(rs.getInt("percentage"));
				dis.setStartDate(rs.getDate("startDate"));
				dis.setEndDate(rs.getDate("endDate"));
				
				listDis.add(dis);
			}
			return listDis;
			
		} catch (Exception e) {
			return null;
		}
	}
	
	//update discount
	public boolean updateDiscount(Discount dis) {
	    String query = "UPDATE discount SET Code = ?, Description = ?, Percentage = ?, StartDate = ?, EndDate = ? WHERE Code = ?";

	    try (Connection conn = DBConnect.getConnection();
	         PreparedStatement stmt = conn.prepareStatement(query)) {

	    	stmt.setString(1, dis.getCode());
	        stmt.setString(2, dis.getDescription());
	        stmt.setInt(3, dis.getPercentage());
	        stmt.setDate(4, dis.getStartDate());
	        stmt.setDate(5, dis.getEndDate());
	        stmt.setString(6, dis.getCode());

	        int rows = stmt.executeUpdate();
	        return rows > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;
	}
	
	
	// Delete Discount
	public boolean deleteDiscount(Discount dis) {
	    String query = "DELETE FROM discount WHERE Code = ?";

	    try (Connection connection = DBConnect.getConnection();
	         PreparedStatement stmt = connection.prepareStatement(query)) {

	    	stmt.setString(1, dis.getCode());// Discount code
	        return stmt.executeUpdate() > 0;

	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return false;
	}



}
