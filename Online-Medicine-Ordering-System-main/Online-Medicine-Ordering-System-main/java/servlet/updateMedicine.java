package servlet;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Medicine;
import services.MedicineService;

@WebServlet("/updateMedicine")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // max 5MB file size
public class updateMedicine extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public updateMedicine() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedAdmin") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Retrieve form fields
        String medId = request.getParameter("medid");
        String medName = request.getParameter("medName");
        String brand = request.getParameter("brand");
        String dosage = request.getParameter("dosage");
        String category = request.getParameter("category");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
        String type = request.getParameter("type");
        String description = request.getParameter("description");

        // File part
        Part filePart = request.getPart("image");
        byte[] imageBytes = null;
        if (filePart != null && filePart.getSize() > 0) {
            try (InputStream inputStream = filePart.getInputStream()) {
                imageBytes = inputStream.readAllBytes();
            }
        }

        // Build Medicine object
        Medicine medicine = new Medicine();
        medicine.setMedId(medId);
        medicine.setMedName(medName);
        medicine.setBrand(brand);
        medicine.setDosage(dosage);
        medicine.setCategory(category);
        medicine.setQuantity(quantity);
        medicine.setUnitPrice(unitPrice);
        medicine.setType(type);
        medicine.setDescription(description);
        medicine.setImage(imageBytes); 

        // Update using service
        MedicineService service = new MedicineService();
        boolean status = service.updateMedicine(medicine);

        if (status) {
            request.setAttribute("successMessage", "Medicine updated successfully!");
        } else {
            request.setAttribute("errorMessage", "Failed to update medicine.");
        }

        // Forward to display page
        RequestDispatcher dispatcher = request.getRequestDispatcher("displayMedicine");
        dispatcher.forward(request, response);
    }
}
