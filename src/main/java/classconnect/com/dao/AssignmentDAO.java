package classconnect.com.dao;

import java.sql.*;
import java.util.*; // CRITICAL: Fixes "List cannot be resolved" error
import classconnect.com.db.DBConnection;

public class AssignmentDAO {
    
    // Functionality: Physically saves assignment details to Workbench
    public int uploadAssignment(int courseId, String title, String dueDate, String filePath) {
        String sql = "INSERT INTO assignment (course_id, title, due_date, file_path) VALUES (?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, courseId);
            ps.setString(2, title);
            ps.setString(3, dueDate);
            ps.setString(4, filePath);
            return ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); return 0; }
    }

    // Functionality: Fixes undefined method error in teacher_dashboard.jsp
    public List<String[]> getAllSubmissions() {
        List<String[]> list = new ArrayList<>();
        // Joins with course table to show real names instead of just IDs
        String sql = "SELECT a.title, c.c_name, a.file_path FROM assignment a " +
                     "JOIN course c ON a.course_id = c.c_id";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(new String[]{
                    rs.getString("title"), 
                    rs.getString("c_name"), 
                    rs.getString("file_path")
                });
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}