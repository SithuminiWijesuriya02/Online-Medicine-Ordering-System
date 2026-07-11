package servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Discount;
import services.DiscountService;

@WebServlet("/displayDiscounts")
public class displayDiscounts extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public displayDiscounts() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		// Admin session check
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedAdmin") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		DiscountService service = new DiscountService();
		ArrayList<Discount> dis = service.getAllDiscount();
		request.setAttribute("discount", dis);

		
		RequestDispatcher dispatcher = request.getRequestDispatcher("discount.jsp");
		dispatcher.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
