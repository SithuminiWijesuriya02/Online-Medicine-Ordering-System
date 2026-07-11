package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Medicine;
import services.MedicineService;


@WebServlet("/deleteMedicine")
public class deleteMedicine extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public deleteMedicine() {
        super();
       
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		// Admin login check
		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("loggedAdmin") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String medId = request.getParameter("id");

		Medicine med = new Medicine();
		med.setMedId(medId);

		MedicineService service = new MedicineService();
		boolean status = service.deleteMedicine(med);

		if (status) {
			session.setAttribute("successMessage", "Medicine deleted successfully.");
		} else {
			session.setAttribute("errorMessage", "Failed to delete medicine.");
		}

		response.sendRedirect("displayMedicine");
	}

}
