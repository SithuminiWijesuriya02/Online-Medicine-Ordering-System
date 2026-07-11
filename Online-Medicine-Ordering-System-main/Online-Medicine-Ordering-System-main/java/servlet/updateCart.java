package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import services.CartService;

@WebServlet("/updateCart")
public class updateCart extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public updateCart() {
        super();
      
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");  
	    String medId = request.getParameter("medId");  
	    int qty = Integer.parseInt(request.getParameter("quantity"));

	    boolean success = new CartService().updateQuantity(email, medId, qty);
	    response.sendRedirect("displayCart");
	}

}
