package model;

public class OrderItem {
	
	 private String orderId;
	 private String medId;
	 private int quantity;
	 private double pricePerUnit;
	 private double totalPrice;
	 
	 
	 public OrderItem(String orderId, String medId, int quantity, double pricePerUnit, double totalPrice) {
	        this.orderId = orderId;
	        this.medId = medId;
	        this.quantity = quantity;
	        this.pricePerUnit = pricePerUnit;
	        this.totalPrice = totalPrice;
	 }
	 
	 public OrderItem() {
		    
		}
 
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public String getMedId() {
		return medId;
	}
	public void setMedId(String medId) {
		this.medId = medId;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public double getPricePerUnit() {
		return pricePerUnit;
	}
	public void setPricePerUnit(double pricePerUnit) {
		this.pricePerUnit = pricePerUnit;
	}
	public double getTotalPrice() {
		return totalPrice;
	}
	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}
	 
	 

}
