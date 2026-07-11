package servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.CartItemDetails;
import model.Customer;
import services.CartService;

@WebServlet("/orderConfirm")
public class orderConfirm extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public orderConfirm() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Customer loggedCustomer = (Customer) session.getAttribute("loggedCustomer");

        if (loggedCustomer == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CartService cartService = new CartService();
        List<CartItemDetails> cartItems = cartService.getUserCartDetails(loggedCustomer.getEmail());

        // Calculate subtotal
        double subtotal = 0;
        for (CartItemDetails item : cartItems) {
            subtotal += item.getUnitPrice() * item.getQuantity();
        }

        double shipping = 5.00;
        double discount = 0.00; 
        double total = subtotal + shipping - discount;

        // Set attributes for JSP
        request.setAttribute("loggedCustomer", loggedCustomer);
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("shipping", shipping);
        request.setAttribute("discount", discount);
        request.setAttribute("total", total);

        // Forward to JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("orderConfirm.jsp");
        dispatcher.forward(request, response);
	}

}
