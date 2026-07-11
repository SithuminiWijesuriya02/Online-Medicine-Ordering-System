package servlet;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Discount;
import services.DiscountService;

@WebServlet("/deleteDiscount")
public class deleteDiscount extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public deleteDiscount() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Check if admin is logged in
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedAdmin") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String code = request.getParameter("code");

		Discount dis = new Discount();
		dis.setCode(code);

		DiscountService service = new DiscountService();
		boolean status = service.deleteDiscount(dis);

		// Set success or error message
		if (status) {
			session.setAttribute("successMessage", "Discount deleted successfully.");
		} else {
			session.setAttribute("errorMessage", "Failed to delete discount.");
		}

	
		response.sendRedirect("displayDiscounts");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
