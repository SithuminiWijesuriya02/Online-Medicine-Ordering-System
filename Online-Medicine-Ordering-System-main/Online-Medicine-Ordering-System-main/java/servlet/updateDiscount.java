package servlet;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Discount;
import services.DiscountService;

@WebServlet("/updateDiscount")
public class updateDiscount extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public updateDiscount() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Session check for admin
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedAdmin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form parameters
        String code = request.getParameter("code");
        String description = request.getParameter("description");
        int percentage = Integer.parseInt(request.getParameter("percentage"));
        Date startDate = Date.valueOf(request.getParameter("startDate"));
        Date endDate = Date.valueOf(request.getParameter("endDate"));

        Discount dis = new Discount();
        dis.setCode(code);
        dis.setDescription(description);
        dis.setPercentage(percentage);
        dis.setStartDate(startDate);
        dis.setEndDate(endDate);

        // Update using service
        DiscountService service = new DiscountService();
        boolean status = service.updateDiscount(dis);

        if (status) {
            request.setAttribute("success", "Discount updated successfully!");
        } else {
            request.setAttribute("error", "Failed to update discount.");
        }

     
        RequestDispatcher dispatcher = request.getRequestDispatcher("displayDiscounts");
        dispatcher.forward(request, response);
    }
}
