package servlet;

import model.OrderItem;
import services.OrderService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/getOrderDetails")
public class GetOrderDetailsServlet  extends HttpServlet {
	 protected void doGet(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        
	        String orderId = request.getParameter("orderId");
	        System.out.println("Received orderId: " + orderId); // Debug
	        
	        if (orderId == null || orderId.trim().isEmpty()) {
	            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
	            response.getWriter().write("{\"error\":\"Order ID is required\"}");
	            return;
	        }
	        
	        try {
	            OrderService orderService = new OrderService();
	            List<OrderItem> items = orderService.getOrderItemsByOrderId(orderId);
	            
	            System.out.println("Found " + items.size() + " items for order: " + orderId); // Debug
	            
	            response.setContentType("application/json");
	            response.setCharacterEncoding("UTF-8");
	            PrintWriter out = response.getWriter();

	            // Build JSON manually
	            StringBuilder json = new StringBuilder();
	            json.append("[");

	            for (int i = 0; i < items.size(); i++) {
	                OrderItem item = items.get(i);
	                json.append("{")
	                    .append("\"orderId\":\"").append(escapeJson(item.getOrderId())).append("\",")
	                    .append("\"medId\":\"").append(escapeJson(item.getMedId())).append("\",")
	                    .append("\"quantity\":").append(item.getQuantity()).append(",")
	                    .append("\"pricePerUnit\":").append(item.getPricePerUnit()).append(",")
	                    .append("\"totalPrice\":").append(item.getTotalPrice())
	                    .append("}");

	                if (i < items.size() - 1) {
	                    json.append(",");
	                }
	            }

	            json.append("]");
	            
	            System.out.println("JSON Response: " + json.toString()); // Debug
	            
	            out.print(json.toString());
	            out.flush();
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	            response.getWriter().write("{\"error\":\"Internal server error\"}");
	        }
	    }
	    
	    // JSON escape helper method
	    private String escapeJson(String input) {
	        if (input == null) return "";
	        return input.replace("\"", "\\\"").replace("\\", "\\\\");
	    }
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response)
	            throws ServletException, IOException {
	        doGet(request, response);
	    }
}
