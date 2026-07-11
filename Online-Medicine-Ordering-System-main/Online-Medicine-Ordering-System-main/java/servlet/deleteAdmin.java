package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Admin;
import services.AdminService;

@WebServlet("/deleteAdmin")
public class deleteAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public deleteAdmin() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);

		// If not logged in, redirect to login
		if (session == null || session.getAttribute("loggedAdmin") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Get logged admin from session
		Admin admin = (Admin) session.getAttribute("loggedAdmin");

		// Call service to delete
		AdminService service = new AdminService();
		boolean status = service.deleteAdmin(admin);

		if (status) {
			// Invalidate session
			session.invalidate();

			// Redirect to homepage
			RequestDispatcher dispatcher = request.getRequestDispatcher("Home.jsp");
			dispatcher.forward(request, response);
		} else {
			request.setAttribute("error", "Account deletion failed.");
			request.getRequestDispatcher("adminProfile.jsp").forward(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
}
