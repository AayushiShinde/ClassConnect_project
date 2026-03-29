package classconnect.com.user;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.*;
import javax.servlet.http.*;
import classconnect.com.dao.AssignmentDAO;

@WebServlet("/uploadAssignment")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AssignmentServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Must match name="assignment_file" in your dashboard.jsp
            Part filePart = request.getPart("assignment_file"); 
            
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = filePart.getSubmittedFileName();
                String title = request.getParameter("title");
                int courseId = Integer.parseInt(request.getParameter("course_id"));
                String dueDate = request.getParameter("due_date");

                // Save physical file to a directory
                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) uploadDir.mkdir();
                
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);

                // Update MySQL Workbench
                AssignmentDAO dao = new AssignmentDAO();
                int result = dao.uploadAssignment(courseId, title, dueDate, filePath);
                
                response.sendRedirect("dashboard.jsp?status=success");
            } else {
                // Fixes the NullPointerException
                response.sendRedirect("dashboard.jsp?error=noFile");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.jsp?error=failed");
        }
    }
}