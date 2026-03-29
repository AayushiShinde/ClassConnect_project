package classconnect.com.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import classconnect.com.dao.StudentDAO;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String pass = request.getParameter("password");
        
        StudentDAO dao = new StudentDAO();
        if (dao.validateLogin(email, pass)) {
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            response.sendRedirect("dashboard.jsp");
        } else {
            response.sendRedirect("login.html?error=invalid");
        }
    }
}