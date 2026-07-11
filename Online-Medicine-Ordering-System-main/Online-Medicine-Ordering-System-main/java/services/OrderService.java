package services;

import java.sql.*;
import java.sql.Date;
import java.util.*;
import model.Medicine;
import model.Order;
import model.OrderItem;
import utils.DBConnect;

public class OrderService {

	public String placeOrder(String email, String cusId) {
	    Connection conn = null;
	    String orderId = null;

	    try {
	        conn = DBConnect.getConnection();
	        conn.setAutoCommit(false);

	        orderId = generateOrderId();
	        Date orderDate = new Date(System.currentTimeMillis());
	        double totalAmount = 0;

	        // 1. Get cart items
	        String cartQuery = "SELECT c.MedId, c.Quantity, m.UnitPrice FROM cart c JOIN medicine m ON c.MedId = m.MedId WHERE c.Email = ?";
	        List<OrderItem> items = new ArrayList<>();
	        try (PreparedStatement cartStmt = conn.prepareStatement(cartQuery)) {
	            cartStmt.setString(1, email);
	            try (ResultSet rs = cartStmt.executeQuery()) {
	                while (rs.next()) {
	                    String medId = rs.getString("MedId");
	                    int qty = rs.getInt("Quantity");
	                    double price = rs.getDouble("UnitPrice");
	                    double total = qty * price;

	                    items.add(new OrderItem(orderId, medId, qty, price, total));
	                    totalAmount += total;
	                }
	            }
	        }

	        // 2. Insert into customerorder
	        String orderInsert = "INSERT INTO customerorder (OrderId, Email, OrderDate, TotalAmount, Status, CusID) VALUES (?, ?, ?, ?, ?, ?)";
	        try (PreparedStatement orderStmt = conn.prepareStatement(orderInsert)) {
	            orderStmt.setString(1, orderId);
	            orderStmt.setString(2, email);
	            orderStmt.setDate(3, new java.sql.Date(orderDate.getTime()));
	            orderStmt.setDouble(4, totalAmount + 5.00);
	            orderStmt.setString(5, "To Pay");
	            orderStmt.setString(6, cusId);
	            orderStmt.executeUpdate();
	        }

	        // 3. Insert order items
	        String itemInsert = "INSERT INTO orderitem (OrderId, MedId, Quantity, PricePerUnit, TotalPrice) VALUES (?, ?, ?, ?, ?)";
	        try (PreparedStatement itemStmt = conn.prepareStatement(itemInsert)) {
	            for (OrderItem item : items) {
	                itemStmt.setString(1, item.getOrderId());
	                itemStmt.setString(2, item.getMedId());
	                itemStmt.setInt(3, item.getQuantity());
	                itemStmt.setDouble(4, item.getPricePerUnit());
	                itemStmt.setDouble(5, item.getTotalPrice());
	                itemStmt.addBatch();
	            }
	            itemStmt.executeBatch();
	        }

	        // 4. Clear cart
	        try (PreparedStatement clearStmt = conn.prepareStatement("DELETE FROM cart WHERE Email = ?")) {
	            clearStmt.setString(1, email);
	            clearStmt.executeUpdate();
	        }

	        conn.commit();
	        return orderId;

	    } catch (Exception e) {
	        e.printStackTrace();
	        try { if (conn != null) conn.rollback(); } catch (Exception ignored) {}
	        return null;
	    }
	}


    public String generateOrderId() {
        String id = "ORD001";
        try (Connection conn = DBConnect.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT OrderId FROM customerorder ORDER BY OrderId DESC LIMIT 1")) {
            if (rs.next()) {
                String lastId = rs.getString("OrderId");
                int num = Integer.parseInt(lastId.substring(3));
                id = String.format("ORD%03d", num + 1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return id;
    }

    public void updateOrderStatus(String orderId, String status) throws Exception {
        String sql;
        if ("Delivered".equals(status)) {
            sql = "UPDATE customerorder SET Status=?, DeliveredDate=? WHERE OrderId=?";
        } else {
            sql = "UPDATE customerorder SET Status=? WHERE OrderId=?";
        }

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, status);
            if ("Delivered".equals(status)) {
                ps.setDate(2, new java.sql.Date(System.currentTimeMillis()));
                ps.setString(3, orderId);
            } else {
                ps.setString(2, orderId);
            }

            int rows = ps.executeUpdate();
            System.out.println("Status updated rows: " + rows);
            if (rows == 0) {
                System.out.println("No rows updated! Check orderId match.");
            }

        }
    }



    public void deleteOrderItems(String orderId, List<String> medIds) throws Exception {
        String sql = "DELETE FROM orderitem WHERE OrderId=? AND MedId=?";
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            for (String medId : medIds) {
                ps.setString(1, orderId);
                ps.setString(2, medId);
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }

    public List<Order> getOrdersByEmail(String email) {
        List<Order> orders = new ArrayList<>();
        String query = "SELECT * FROM customerorder WHERE Email = ? ORDER BY OrderDate DESC";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getString("OrderId"));
                order.setEmail(rs.getString("Email"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setDeliveredDate(rs.getDate("DeliveredDate"));
                orders.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<OrderItem> getOrderItems(String orderId) {
        List<OrderItem> items = new ArrayList<>();
        String query = "SELECT * FROM orderitem WHERE OrderId = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, orderId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderId(rs.getString("OrderId"));
                item.setMedId(rs.getString("MedId"));
                item.setQuantity(rs.getInt("Quantity"));
                item.setPricePerUnit(rs.getDouble("PricePerUnit"));
                item.setTotalPrice(rs.getDouble("TotalPrice"));
                items.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return items;
    }

    public Medicine getMedicineById(String medId) {
        Medicine med = null;
        String query = "SELECT * FROM medicine WHERE MedId = ?";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, medId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                med = new Medicine();
                med.setMedId(rs.getString("MedId"));
                med.setMedName(rs.getString("MedName"));
                med.setType(rs.getString("Type"));
                med.setDescription(rs.getString("Description"));
                med.setUnitPrice(rs.getDouble("UnitPrice"));
                med.setQuantity(rs.getInt("Quantity"));
                med.setImage(rs.getBytes("Image")); 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return med;
    }
    
    public String getOrderStatus(String orderId) {
        String status = null;
        String query = "SELECT TRIM(Status) AS Status FROM customerorder WHERE OrderId = ?";
        
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    status = rs.getString("Status");
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return status;
    }


    public void setDeliveredDate(String orderId) {
        String query = "UPDATE customerorder SET DeliveredDate = ? WHERE OrderId = ?";
        
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            java.sql.Date today = new java.sql.Date(System.currentTimeMillis());
            ps.setDate(1, today);
            ps.setString(2, orderId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
 
    
    public boolean deleteOrderById(String orderId) {
        Connection conn = null;
        try {
            conn = DBConnect.getConnection();
            conn.setAutoCommit(false);

            // Step 1: Delete order items first
            String deleteItemsSQL = "DELETE FROM orderitem WHERE OrderId = ?";
            try (PreparedStatement psItems = conn.prepareStatement(deleteItemsSQL)) {
                psItems.setString(1, orderId);
                psItems.executeUpdate();
            }

            // Step 2: Delete main order
            String deleteOrderSQL = "DELETE FROM customerorder WHERE OrderId = ?";
            try (PreparedStatement psOrder = conn.prepareStatement(deleteOrderSQL)) {
                psOrder.setString(1, orderId);
                psOrder.executeUpdate();
            }

            conn.commit();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            try { if (conn != null) conn.rollback(); } catch (Exception ignore) {}
            return false;
        }
    }
    
    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();

        String query = "SELECT * FROM customerorder ORDER BY OrderDate DESC";

        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getString("OrderId"));
                order.setEmail(rs.getString("Email"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setTotalAmount(rs.getDouble("TotalAmount"));
                order.setStatus(rs.getString("Status"));
                order.setDeliveredDate(rs.getDate("DeliveredDate"));
                orders.add(order);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return orders;
    }
    

    public List<OrderItem> getOrderItemsByOrderId(String orderId) {
        List<OrderItem> list = new ArrayList<>();
        String sql = "SELECT oi.*, m.MedName FROM orderitem oi " +
                     "LEFT JOIN medicine m ON oi.MedId = m.MedId " +
                     "WHERE oi.OrderId = ?";
        
        try (Connection con = DBConnect.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, orderId);
            System.out.println("Executing query for orderId: " + orderId); 
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setOrderId(rs.getString("OrderId"));
                    item.setMedId(rs.getString("MedId"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setPricePerUnit(rs.getDouble("PricePerUnit"));
                    item.setTotalPrice(rs.getDouble("TotalPrice"));
                    
                    
                    try {
                        String medName = rs.getString("MedName");                       
                    } catch (SQLException e) {                       
                    }
                    
                    list.add(item);
                    System.out.println("Added item: " + item.getMedId() + " qty: " + item.getQuantity()); // Debug
                }
            }
            
        } catch (Exception e) {
            System.err.println("Error in getOrderItemsByOrderId: " + e.getMessage());
            e.printStackTrace();
        }
        
        System.out.println("Total items found: " + list.size()); 
        return list;
    }


}
