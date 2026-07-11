package servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Customer;
import services.CustomerService;
import services.OrderService;

@WebServlet("/createOrder")
public class createOrder extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public createOrder() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fix: Get session safely
        HttpSession session = request.getSession(false);
        
        // Check for session null or customer not logged in
        if (session == null || session.getAttribute("loggedCustomer") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in customer
        Customer customer = (Customer) session.getAttribute("loggedCustomer");

        // Read customer info from form
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String city = request.getParameter("city");
        String province = request.getParameter("state");
        String postal = request.getParameter("postal");
        String country = request.getParameter("country");

        // Optional: Update session-stored customer object
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setPhone(phone);
        customer.setStreet(address);
        customer.setCity(city);
        customer.setState(province);
        customer.setZipCode(postal);
        customer.setCountry(country);
        
        CustomerService customerService = new CustomerService();
        customerService.updateCustomer(customer);  

        OrderService orderService = new OrderService();
        String cusId = customer.getCusID();
        String orderId = orderService.placeOrder(email, cusId);

        if (orderId != null) {
            request.setAttribute("orderId", orderId); 
            request.getRequestDispatcher("payment.jsp").forward(request, response);
        } else {
            response.sendRedirect("orderConfirm.jsp?error=1");
        }

    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
    }
}
