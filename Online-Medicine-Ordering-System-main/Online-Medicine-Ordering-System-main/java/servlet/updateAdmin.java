package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Admin;
import services.AdminService;

@WebServlet("/updateAdmin")
public class updateAdmin extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public updateAdmin() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedAdmin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Admin oldAdmin = (Admin) session.getAttribute("loggedAdmin");

        // Build updated admin object
        Admin admin = new Admin();
        admin.setAdID(oldAdmin.getAdID()); // retain ID
        admin.setAdName(request.getParameter("adName"));
        admin.setAdEmail(request.getParameter("adEmail"));
        admin.setAdPassword(request.getParameter("adPassword"));
        admin.setAdphone(request.getParameter("adphone"));

        AdminService service = new AdminService();
        boolean status = service.updateAdmin(admin); // update in DB

        if (status) {
            // Get updated admin from DB and update session
            try {
                Admin updatedAdmin = service.getAdminEmail(admin.getAdEmail());
                session.setAttribute("loggedAdmin", updatedAdmin);
                request.setAttribute("admin", updatedAdmin);
            } catch (Exception e) {
                e.printStackTrace();
            }

            RequestDispatcher dispatcher = request.getRequestDispatcher("displayAdmin");
            dispatcher.forward(request, response);

        } else {
            request.setAttribute("error", "Update failed.");
            request.getRequestDispatcher("adProfileEdit.jsp").forward(request, response);
        }
    }
}
