package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Customer;
import services.CustomerService;

@WebServlet("/addCustomer")
public class addCustomer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public addCustomer() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Customer cus = new Customer();
        CustomerService service = new CustomerService();

        // Generate unique customer ID
        String generatedId = service.generateCustomerId();
        cus.setCusID(generatedId);

        // Get form data from request
        cus.setFirstName(request.getParameter("firstName"));
        cus.setLastName(request.getParameter("lastName"));
        cus.setEmail(request.getParameter("email"));
        cus.setPhone(request.getParameter("phone"));
        cus.setPassword(request.getParameter("password"));

        try {
            Date dob = Date.valueOf(request.getParameter("dob")); // yyyy-MM-dd
            cus.setDob(dob);
        } catch (IllegalArgumentException e) {
            e.printStackTrace(); // or handle invalid date format
        }

        cus.setStreet(request.getParameter("street"));
        cus.setCity(request.getParameter("city"));
        cus.setState(request.getParameter("state"));
        cus.setZipCode(request.getParameter("zipCode"));

        // Register in the database
        service.regCustomer(cus);

        // Store user in session
        HttpSession session = request.getSession();
        session.setAttribute("loggedCustomer", cus);

        // Redirect to customer profile or success page
        response.sendRedirect("displayCustomer");
    }
}
