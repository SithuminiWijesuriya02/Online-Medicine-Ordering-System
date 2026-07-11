package model;

public class Cart {
    private String email;
    private String medId;
    private int quantity;

    public Cart() {}

    public Cart(String email, String medId, int quantity) {
        this.email = email;
        this.medId = medId;
        this.quantity = quantity;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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
}
