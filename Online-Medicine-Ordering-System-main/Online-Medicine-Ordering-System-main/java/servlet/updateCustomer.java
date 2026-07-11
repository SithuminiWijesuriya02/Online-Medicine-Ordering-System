package servlet;

import java.io.IOException;
import java.sql.Date;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Customer;
import services.CustomerService;

@WebServlet("/updateCustomer")
public class updateCustomer extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public updateCustomer() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedCustomer") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Customer oldCus = (Customer) session.getAttribute("loggedCustomer");

        Customer cus = new Customer();
        cus.setCusID(oldCus.getCusID());
        cus.setFirstName(request.getParameter("firstName"));
        cus.setLastName(request.getParameter("lastName"));
        cus.setEmail(request.getParameter("email"));
        cus.setPhone(request.getParameter("phone"));
        cus.setPassword(request.getParameter("password"));

        try {
            Date dob = Date.valueOf(request.getParameter("dob"));
            cus.setDob(dob);
        } catch (Exception e) {
            e.printStackTrace();
        }

        cus.setStreet(request.getParameter("street"));
        cus.setCity(request.getParameter("city"));
        cus.setState(request.getParameter("state"));
        cus.setZipCode(request.getParameter("zipCode"));

        CustomerService service = new CustomerService();
        boolean status = service.updateCustomer(cus);

        if (status) {
            Customer updatedCus = service.getCustomerByCusID(oldCus.getCusID());
            session.setAttribute("loggedCustomer", updatedCus);
            request.setAttribute("cus", updatedCus);

            RequestDispatcher dispatcher = request.getRequestDispatcher("displayCustomer");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("error", "Update failed.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("displayCustomer");
            dispatcher.forward(request, response);
        }
    }
}
