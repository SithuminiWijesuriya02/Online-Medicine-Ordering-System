package model;

public class CartItemDetails {
    private String medId;
    private String medName;
    private int quantity;
    private double unitPrice;
	private byte[] image;
    private String brand;
    private String type;
    private String dosage;

    // getters and setters
    public String getMedId() { return medId; }
    public void setMedId(String medId) { this.medId = medId; }

    public String getMedName() { return medName; }
    public void setMedName(String medName) { this.medName = medName; }

	public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }
    
    public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
	
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getDosage() {
        return dosage;
    }

    public void setDosage(String dosage) {
        this.dosage = dosage;
    }
	
}
