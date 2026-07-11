package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CartItemDetails;
import model.Customer;
import services.CartService;

@WebServlet("/displayCart")
public class displayCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
   
    public displayCart() {
        super();
        }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 doPost(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Customer customer = (Customer) request.getSession().getAttribute("loggedCustomer");

		if (customer == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String email = customer.getEmail();

		CartService service = new CartService(); 
		List<CartItemDetails> cart = service.getUserCartDetails(email);

		request.setAttribute("cartItems", cart);
		request.getRequestDispatcher("cart.jsp").forward(request, response);
	}
	

}
