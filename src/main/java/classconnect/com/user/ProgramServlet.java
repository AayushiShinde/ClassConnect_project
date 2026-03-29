package classconnect.com.user;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import classconnect.com.dao.ProgramDAO;

@WebServlet("/addProgram")
public class ProgramServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String pName = request.getParameter("p_name");

        if (pName != null && !pName.trim().isEmpty()) {
            ProgramDAO dao = new ProgramDAO();
            int result = dao.addProgram(pName);

            if (result > 0) {
                // Success: Program updated in Workbench
                response.sendRedirect("dashboard.jsp?status=programAdded");
            } else {
                response.sendRedirect("dashboard.jsp?error=insertFailed");
            }
        } else {
            response.sendRedirect("dashboard.jsp?error=emptyName");
        }
    }
}