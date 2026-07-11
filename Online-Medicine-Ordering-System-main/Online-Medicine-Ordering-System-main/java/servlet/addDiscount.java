package servlet;

import java.io.IOException;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Discount;
import services.DiscountService;

@WebServlet("/addDiscount")
public class addDiscount extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public addDiscount() {
		super();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);

		// Check if admin is logged in
		if (session == null || session.getAttribute("loggedAdmin") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		Discount dis = new Discount();
		dis.setCode(request.getParameter("code"));
		dis.setDescription(request.getParameter("desc"));
		dis.setPercentage(Integer.parseInt(request.getParameter("percentage")));
		dis.setStartDate(Date.valueOf(request.getParameter("startDate")));
		dis.setEndDate(Date.valueOf(request.getParameter("endDate")));

		// Add to DB
		DiscountService service = new DiscountService();
		service.addDiscount(dis);

		ArrayList<Discount> discounts = service.getAllDiscount();
		request.setAttribute("discountList", discounts);

		
		RequestDispatcher dispatcher = request.getRequestDispatcher("displayDiscounts");
		dispatcher.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}
}
