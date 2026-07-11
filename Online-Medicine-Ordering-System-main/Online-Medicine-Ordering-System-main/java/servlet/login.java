package servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Admin;
import model.Customer;
import services.AdminService;
import services.CustomerService;

@WebServlet("/login")
public class login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public login() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");

		// Invalidate old session
		HttpSession oldSession = request.getSession(false);
		if (oldSession != null) {
			oldSession.invalidate();
		}

		// --- Admin Check ---
		AdminService adminService = new AdminService();
		Admin tempAdmin = new Admin();
		
		tempAdmin.setAdEmail(email);
		tempAdmin.setAdPassword(password);

		if (adminService.validateAdmin(tempAdmin)) {
			Admin admin = adminService.getAdmin(tempAdmin);
			HttpSession session = request.getSession();
			session.setAttribute("loggedAdmin", admin);
			session.setAttribute("role", "admin");
			response.sendRedirect("dashboard");
			return;
		}

		// --- Customer Check ---
		CustomerService customerService = new CustomerService();
		Customer customer = new Customer();
		
		customer.setEmail(email);
		customer.setPassword(password);

		if (customerService.validate(customer)) {
			Customer loginCus = customerService.getCus(customer);
			HttpSession session = request.getSession();
			session.setAttribute("loggedCustomer", loginCus);
			session.setAttribute("role", "customer");
			response.sendRedirect("Home.jsp");
			
		} else {
			request.setAttribute("error", "Invalid email or password.");
			RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
			dispatcher.forward(request, response);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
}
