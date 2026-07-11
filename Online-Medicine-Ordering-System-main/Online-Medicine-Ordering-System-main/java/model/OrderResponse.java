package model;

import java.util.List;

public class OrderResponse {
    private Order order;
    private List<OrderItem> items;

    // constructor
    public OrderResponse(Order order, List<OrderItem> items) {
        this.order = order;
        this.items = items;
    }

    // getters and setters
    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}
