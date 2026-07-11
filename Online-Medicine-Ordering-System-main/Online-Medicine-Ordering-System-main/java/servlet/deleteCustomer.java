package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Customer;
import services.CustomerService;

@WebServlet("/deleteCustomer")
public class deleteCustomer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public deleteCustomer() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // If not logged in, redirect to login
        if (session == null || session.getAttribute("loggedCustomer") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get logged-in customer from session
        Customer cus = (Customer) session.getAttribute("loggedCustomer");
        String email = cus.getEmail();

        // Call service to delete
        CustomerService service = new CustomerService();
        boolean status = service.deleteCustomer(email); // updated to pass email string

        if (status) {
            session.invalidate(); // End session after delete
            request.getRequestDispatcher("Home.jsp").forward(request, response);
        } else {
            request.setAttribute("error", "Account deletion failed.");
            request.getRequestDispatcher("CusProfile.jsp").forward(request, response);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }
}
