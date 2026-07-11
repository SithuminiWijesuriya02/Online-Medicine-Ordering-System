package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Customer;
import services.CartService;

@WebServlet("/deleteCart")
public class deleteCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public deleteCart() {
        super();
       
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession(false);
		Customer customer = (Customer) session.getAttribute("loggedCustomer");

		if (customer == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String email = customer.getEmail();
		String medId = request.getParameter("medId");

		CartService cartService = new CartService();
		boolean success = cartService.deleteCartItem(email, medId);

		response.sendRedirect("displayCart");
	}

}
