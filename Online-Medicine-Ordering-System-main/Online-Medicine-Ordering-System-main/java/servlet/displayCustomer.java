package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Customer;


@WebServlet("/displayCustomer")
public class displayCustomer extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public displayCustomer() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// If session doesn't exist or user is not logged in, redirect to login
		if (session == null || session.getAttribute("loggedCustomer") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		// Get the customer object from session
		Customer cus = (Customer) session.getAttribute("loggedCustomer");

		// Attach customer to request so JSP can access it
		request.setAttribute("cus", cus);

		// Forward to profile page
		request.getRequestDispatcher("CusProfile.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response); // handle POST the same way as GET
	}
}




