package servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import utils.DBConnect;

@WebServlet("/medicineImage")
public class medicineImage extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public medicineImage() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String medId = request.getParameter("id");
		String query = "SELECT Image FROM medicine WHERE MedId = ?";

		try (Connection conn = DBConnect.getConnection();
			 PreparedStatement ps = conn.prepareStatement(query)) {

			ps.setString(1, medId);
			ResultSet rs = ps.executeQuery();

			if (rs.next()) {
				byte[] imageBytes = rs.getBytes("Image");
				if (imageBytes != null) {
					response.setContentType("image/jpeg");
					OutputStream out = response.getOutputStream();
					out.write(imageBytes);
					out.flush();
				} else {
					response.sendError(HttpServletResponse.SC_NOT_FOUND);
				}
			} else {
				response.sendError(HttpServletResponse.SC_NOT_FOUND);
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
	}

}
