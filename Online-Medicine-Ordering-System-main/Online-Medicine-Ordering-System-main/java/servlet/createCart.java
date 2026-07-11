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

@WebServlet("/createCart")
public class createCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public createCart() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		 HttpSession session = request.getSession(false);
	        Customer customer = (session != null) ? (Customer) session.getAttribute("loggedCustomer") : null;

	        if (customer == null || customer.getEmail() == null) {
	            System.out.println("Not logged in or email missing");
	            response.sendRedirect("login.jsp");
	            return;
	        }

	        String medId = request.getParameter("medId");
	        int quantity = 1;
	        try {
	            quantity = Integer.parseInt(request.getParameter("quantity"));
	        } catch (NumberFormatException e) {
	            quantity = 1;
	        }

	        CartService service = new CartService();
	        boolean success = service.addToCart(customer.getEmail(), medId, quantity);

	        if (success) {
	            System.out.println("Added to cart");
	            response.sendRedirect("viewMedicine"); // Reload page or cart
	        } else {
	            System.out.println("Failed to add to cart");
	            response.sendRedirect("error.jsp"); // Or show message
	        }

		
	}		

}
