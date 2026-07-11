package servlet;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.annotation.WebServlet;
import javax.servlet.ServletException;

import services.OrderService;

@WebServlet("/deleteOrder")
public class deleteOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private OrderService orderService;

    @Override
    public void init() throws ServletException {
        orderService = new OrderService(); 
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        try {
            boolean deleted = orderService.deleteOrderById(orderId);
            if (deleted) {
                response.sendRedirect("viewOrder.jsp?msg=cancelSuccess");
            } else {
                response.sendRedirect("viewOrder.jsp?msg=cancelFailed");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewOrder.jsp?msg=error");
        }
    }
}
