package servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Customer;
import model.Medicine;
import model.Order;
import model.OrderItem;
import services.OrderService;

@WebServlet("/viewOrder")
public class viewOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public viewOrder() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        processRequest(request, response);
    }

    private void processRequest(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set response content type
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                System.out.println("No session found");
                response.sendRedirect("login.jsp");
                return;
            }

            Customer customer = (Customer) session.getAttribute("loggedCustomer");
            if (customer == null) {
                System.out.println("No customer logged in");
                response.sendRedirect("login.jsp");
                return;
            }

            System.out.println("Customer found: " + customer.getEmail());

            OrderService orderService = new OrderService();
            List<Order> orders = orderService.getOrdersByEmail(customer.getEmail());
            
            System.out.println("Orders found: " + orders.size());
            for (Order o : orders) {
                System.out.println("Order ID: " + o.getOrderId() + " | Status: " + o.getStatus());
            }

            // Sort orders - "To Pay" status first
            orders.sort((o1, o2) -> {
                if ("To Pay".equals(o1.getStatus()) && !"To Pay".equals(o2.getStatus())) {
                    return -1;
                } else if (!"To Pay".equals(o1.getStatus()) && "To Pay".equals(o2.getStatus())) {
                    return 1;
                } else {
                    // Secondary sort by order date (newest first)
                    return o2.getOrderDate().compareTo(o1.getOrderDate());
                }
            });

            // Load order items and medicines
            Map<String, List<OrderItem>> orderItemsMap = new HashMap<>();
            Map<String, Medicine> medicineMap = new HashMap<>();

            for (Order order : orders) {
                try {
                    List<OrderItem> items = orderService.getOrderItems(order.getOrderId());
                    orderItemsMap.put(order.getOrderId(), items);

                    for (OrderItem item : items) {
                        if (!medicineMap.containsKey(item.getMedId())) {
                            Medicine med = orderService.getMedicineById(item.getMedId());
                            if (med != null) {
                                medicineMap.put(item.getMedId(), med);
                            }
                        }
                    }
                } catch (Exception e) {
                    System.err.println("Error loading items for order " + order.getOrderId() + ": " + e.getMessage());
                    e.printStackTrace();
                }
            }

            // Set attributes
            request.setAttribute("orders", orders);
            request.setAttribute("orderItemsMap", orderItemsMap);
            request.setAttribute("medicineMap", medicineMap);
            
            // Forward to JSP
            request.getRequestDispatcher("viewOrder.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error in viewOrder servlet: " + e.getMessage());
            e.printStackTrace();
            
            // Set error message and forward to error page or back to profile
            request.setAttribute("errorMessage", "Unable to load orders. Please try again.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}