package servlet;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

import model.Medicine;
import services.MedicineService;

@WebServlet("/viewMedicine")
public class viewMedicine extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		MedicineService service = new MedicineService();
		ArrayList<Medicine> medicineList = service.getAllMedicines();

		// Convert image bytes to Base64 string for each medicine
		for (Medicine med : medicineList) {
			if (med.getImage() != null) {
				String base64 = Base64.getEncoder().encodeToString(med.getImage());
				med.setImageBase64(base64); // This makes it available as ${medicine.imageBase64}
			} else {
				med.setImageBase64(""); // fallback if no image exists
			}
		}

		// Debug log
		System.out.println("Loaded medicines: " + medicineList.size());

		request.setAttribute("allMedicines", medicineList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("medicine.jsp");
		dispatcher.forward(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}
}
