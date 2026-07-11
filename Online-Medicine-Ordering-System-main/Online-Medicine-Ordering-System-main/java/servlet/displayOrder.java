package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Order;
import services.OrderService;

@WebServlet("/displayOrder")
public class displayOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;
   
    public displayOrder() {
        super();
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response); 
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("displayOrder servlet called"); 
        
        try {
            OrderService orderService = new OrderService();
            List<Order> allOrders = orderService.getAllOrders();
            
            System.out.println("Orders found: " + allOrders.size()); 
            
            request.setAttribute("orderList", allOrders);
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("orderAD.jsp");
            dispatcher.forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in displayOrder: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }
}