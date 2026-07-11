package servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Admin;
import services.AdminService;

@WebServlet("/addAdmin")
public class addAdmin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public addAdmin() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        Admin admin = new Admin();
        AdminService service = new AdminService();

        // Generate unique admin ID
        String generatedId = service.generateAdminId();
        admin.setAdID(generatedId);

        // Get form data from request
        admin.setAdName(request.getParameter("adName"));
        admin.setAdEmail(request.getParameter("adEmail"));
        admin.setAdPassword(request.getParameter("adPassword"));
        admin.setAdphone(request.getParameter("adphone"));

        // Register in the database
        service.regAdmin(admin);

        // Create session and log in admin
        HttpSession session = request.getSession();
        session.setAttribute("loggedAdmin", admin);

        // Redirect to profile display
        response.sendRedirect("adminDash.jsp");
    }
}
