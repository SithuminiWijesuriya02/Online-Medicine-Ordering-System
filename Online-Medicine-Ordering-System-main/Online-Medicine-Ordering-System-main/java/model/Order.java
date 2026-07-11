package model;

import java.sql.Date;

public class Order {

	private String orderId;
    private String email;
    private Date orderDate;
    private double totalAmount;
    private String status;
    private Date deliveredDate;

    // Constructor
    public Order() {}

    public Order(String orderId, String email, Date orderDate, double totalAmount, String status, Date deliveredDate) {
        this.orderId = orderId;
        this.email = email;
        this.orderDate = orderDate;
        this.totalAmount = totalAmount;
        this.status = status;
        this.deliveredDate = deliveredDate;
    }

	// Getters and Setters
    public String getOrderId() {
        return orderId;
    }
    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public Date getOrderDate() {
        return orderDate;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }
    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }

    public Date getDeliveredDate() {
		return deliveredDate;
	}

	public void setDeliveredDate(Date deliveredDate) {
		this.deliveredDate = deliveredDate;
	}

    
}    
	
