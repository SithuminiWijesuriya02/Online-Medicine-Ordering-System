package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.OrderItem;
import services.OrderService; // මේක import කරන්න

@WebServlet("/OrderItems")
public class OrderItems extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    private OrderService orderService = new OrderService(); // Service instance එක

    public OrderItems() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String orderId = request.getParameter("orderId");
       
        List<OrderItem> orderItems = orderService.getOrderItemsByOrderId(orderId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
      
        StringBuilder json = new StringBuilder();
        json.append("[");

        for (int i = 0; i < orderItems.size(); i++) {
            OrderItem item = orderItems.get(i);
            json.append("{")
                .append("\"medId\":\"").append(item.getMedId()).append("\",")
                .append("\"quantity\":").append(item.getQuantity()).append(",")
                .append("\"pricePerUnit\":").append(item.getPricePerUnit())
                .append("}");

            if (i < orderItems.size() - 1) {
                json.append(",");
            }
        }

        json.append("]");

        response.getWriter().write(json.toString());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}