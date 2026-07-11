package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Admin;

@WebServlet("/displayAdmin")
public class displayAdmin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public displayAdmin() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if admin is logged in
        if (session != null && session.getAttribute("loggedAdmin") != null) {
            Admin admin = (Admin) session.getAttribute("loggedAdmin");

            // Optional: set as request attribute too if JSP uses ${admin}
            request.setAttribute("admin", admin);

            // Forward to profile page
            request.getRequestDispatcher("adminProfile.jsp").forward(request, response);
        } else {
            // If not logged in, redirect to login
            response.sendRedirect("login.jsp");
        }
    }
}
