package classconnect.com.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import classconnect.com.dao.StudentDAO;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Capturing form data from register.jsp
        String name = request.getParameter("name");
        String prn = request.getParameter("prn");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        // Basic validation to ensure no null values are sent to MySQL
        if (name != null && email != null && password != null) {
            StudentDAO dao = new StudentDAO();
            
            // This calls the register method in your DAO
            int result = dao.registerUser(name, email, password, prn, role);

            if (result > 0) {
                // Success: Redirect to login page
                response.sendRedirect("login.html?status=success");
            } else {
                // Failure: Stay on register page
                response.sendRedirect("register.jsp?error=failed");
            }
        } else {
            response.sendRedirect("register.jsp?error=invalid_input");
        }
    }
}