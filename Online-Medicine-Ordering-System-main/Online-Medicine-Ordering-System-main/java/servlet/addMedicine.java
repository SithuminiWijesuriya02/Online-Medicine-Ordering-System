package servlet;

import java.io.IOException;
import java.io.InputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import model.Medicine;
import services.MedicineService;

@WebServlet("/addMedicine")
@MultipartConfig(maxFileSize = 16177215)
public class addMedicine extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	 HttpSession session = request.getSession(false);
         if (session == null || session.getAttribute("loggedAdmin") == null) {
             response.sendRedirect("login.jsp");
             return;
         }

         MedicineService service = new MedicineService();
         Medicine med = new Medicine();

         // Generate ID
         String generatedId = service.generateMedicineId();
         med.setMedId(generatedId);

         // Basic fields
         med.setMedName(request.getParameter("medicineName"));
         med.setBrand(request.getParameter("brand"));
         med.setQuantity(Integer.parseInt(request.getParameter("quantity")));
         med.setUnitPrice(Double.parseDouble(request.getParameter("unitPrice")));
         med.setType(request.getParameter("type"));
         med.setCategory(request.getParameter("category"));
         med.setDescription(request.getParameter("description"));
         med.setDosage(request.getParameter("dosage"));

         // Image field
         Part imagePart = request.getPart("image");
         if (imagePart != null && imagePart.getSize() > 0) {
             try (InputStream imageStream = imagePart.getInputStream()) {
                 med.setImage(imageStream.readAllBytes());
             }
         }

         boolean success = service.addMedicine(med);

         if (success) {
             session.setAttribute("successMessage", "Medicine inserted successfully!");
         } else {
             session.setAttribute("errorMessage", "Failed to insert medicine.");
         }

         response.sendRedirect("displayMedicine");
     }
}
