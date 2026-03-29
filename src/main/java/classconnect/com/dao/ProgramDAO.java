package classconnect.com.dao;

import java.sql.*;
import java.util.*;
import classconnect.com.db.DBConnection;

public class ProgramDAO {
    // Physically updates the 'program' table in MySQL Workbench
    public int addProgram(String name) {
        String sql = "INSERT INTO program (p_name) VALUES (?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            return ps.executeUpdate();
        } catch (SQLException e) { 
            e.printStackTrace(); 
            return 0; 
        }
    }

    // Fetches existing programs to display below the form
    public List<String[]> getAllPrograms() {
        List<String[]> programs = new ArrayList<>();
        String sql = "SELECT p_id, p_name FROM program";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                programs.add(new String[]{rs.getString("p_id"), rs.getString("p_name")});
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return programs;
    }
}