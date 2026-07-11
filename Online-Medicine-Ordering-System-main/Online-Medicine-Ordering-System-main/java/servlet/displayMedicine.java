package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Medicine;
import services.MedicineService;

@WebServlet("/displayMedicine")
public class displayMedicine extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public displayMedicine() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Admin session check (optional)
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedAdmin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get all medicine data
        MedicineService service = new MedicineService();
        ArrayList<Medicine> medList = service.getAllMedicines();

        // Encode image to Base64 for modal display
        for (Medicine med : medList) {
            if (med.getImage() != null) {
                String base64 = Base64.getEncoder().encodeToString(med.getImage());
                med.setImageBase64(base64);
            } else {
                med.setImageBase64(""); 
            }
        }

        // Set data and forward
        request.setAttribute("allMedicines", medList);
        RequestDispatcher dispatcher = request.getRequestDispatcher("medicineAD.jsp");
        dispatcher.forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
