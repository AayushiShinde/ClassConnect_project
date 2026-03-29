package classconnect.com.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import classconnect.com.dao.CourseDAO;

@WebServlet("/addCourse")
public class CourseServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String name = request.getParameter("course_name");
        int pId = Integer.parseInt(request.getParameter("program_id"));
        
        // Generate a simple code (e.g., PYT101) to satisfy MySQL NOT NULL
        String cCode = name.substring(0, Math.min(name.length(), 3)).toUpperCase() + "101";

        CourseDAO dao = new CourseDAO();
        // Fixes: The method addCourse(String, int, String) in type CourseDAO
        int result = dao.addCourse(name, pId, cCode);

        if (result > 0) {
            response.sendRedirect("dashboard.jsp?status=courseAdded");
        } else {
            response.sendRedirect("dashboard.jsp?error=failed");
        }
    }
}