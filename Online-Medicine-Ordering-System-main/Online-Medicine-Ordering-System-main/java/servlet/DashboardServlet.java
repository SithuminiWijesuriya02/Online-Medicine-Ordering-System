package servlet;

import model.Medicine;
import model.Order;
import services.MedicineService;
import services.OrderService;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private final OrderService orderService = new OrderService();
    private final MedicineService medicineService = new MedicineService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Load recent orders
        List<Order> recentOrders = orderService.getAllOrders(); 
        request.setAttribute("orderList", recentOrders);

        // Load low stock items
        List<Medicine> lowStockList = medicineService.getLowStockItems(); 
        request.setAttribute("lowStockList", lowStockList);

        // Forward to dashboard JSP
        request.getRequestDispatcher("adminDash.jsp").forward(request, response);
    }
}
