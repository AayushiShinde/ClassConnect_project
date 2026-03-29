package classconnect.com.dao;

import java.sql.*;
import java.util.*;
import classconnect.com.db.DBConnection;

public class CourseDAO {
    // Fixes the arguments mismatch error in CourseServlet
    public int addCourse(String name, int pId, String cCode) {
        String sql = "INSERT INTO course (c_name, p_id, c_code) VALUES (?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, pId);
            ps.setString(3, cCode);
            return ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); return 0; }
    }

    // Fixes the undefined method error on dashboard.jsp line 111
    public List<String[]> getAllCourses() {
        List<String[]> courses = new ArrayList<>();
        String sql = "SELECT c_id, c_name FROM course";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                courses.add(new String[]{rs.getString("c_id"), rs.getString("c_name")});
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return courses;
    }
}