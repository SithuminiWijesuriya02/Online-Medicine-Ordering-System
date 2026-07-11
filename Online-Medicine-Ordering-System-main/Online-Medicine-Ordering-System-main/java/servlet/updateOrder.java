package servlet;
import services.CustomerService;
import services.MedicineService;
import services.OrderService;
import model.Customer;
import model.Medicine;
import model.OrderItem;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/updateOrder")
public class updateOrder extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	 
    	 String orderId = request.getParameter("orderId");
         String action = request.getParameter("action");
         String street = request.getParameter("street");
         String city = request.getParameter("city");
         String state = request.getParameter("state");
         String zip = request.getParameter("zip");

         OrderService orderService = new OrderService();
         CustomerService customerService = new CustomerService();

         try {
             String currentStatus = orderService.getOrderStatus(orderId); 
             if ("markReceived".equals(action)) {
                 if ("Shipped".equals(currentStatus)) {
                     orderService.updateOrderStatus(orderId, "Delivered");
                     orderService.setDeliveredDate(orderId); 
                 }
                 response.sendRedirect("viewOrder.jsp?orderId=" + orderId);
                 return;
             }

             if ("To Pay".equals(currentStatus)) {
            	    orderService.updateOrderStatus(orderId, "Processing");

            	    // Decrease stock
            	    List<OrderItem> items = orderService.getOrderItemsByOrderId(orderId);
            	    MedicineService medicineService = new MedicineService();

            	    for (OrderItem item : items) {
            	        String medId = item.getMedId();
            	        int orderQty = item.getQuantity();

            	        Medicine med = medicineService.getMedicineById(medId);
            	        if (med != null) {
            	            int updatedQty = med.getQuantity() - orderQty;
            	            med.setQuantity(updatedQty);
            	            medicineService.updateMedicineStock(med);
            	        }
            	    }

            	    response.sendRedirect("viewOrder.jsp?orderId=" + orderId);
            	    return;
            	}

             
             if ("Processing".equals(currentStatus)) {
            	    orderService.updateOrderStatus(orderId, "Shipped");
            	    response.sendRedirect("DashboardServlet?orderId=" + orderId);
            	    return;
            	}


             response.sendRedirect("viewOrder");

         } catch (Exception e) {
             e.printStackTrace();
             request.setAttribute("error", "Order update failed: " + e.getMessage());
             request.getRequestDispatcher("error.jsp").forward(request, response);
         }
     }
    
     protected void doGet(HttpServletRequest request, HttpServletResponse response)
             throws ServletException, IOException {
         doPost(request, response);
     }
}