package classconnect.com.dao;

import java.sql.*;
import classconnect.com.db.DBConnection;

public class StudentDAO {
    // Validates login for LoginServlet
    public boolean validateLogin(String email, String pass) {
        String sql = "SELECT * FROM user_login WHERE email=? AND password=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, pass);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // Fetches the name dynamically so Kaumudi sees her name
    public String getUserName(String email) {
        String sql = "SELECT name FROM user_login WHERE email=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getString("name");
        } catch (SQLException e) { e.printStackTrace(); }
        return "User"; 
    }

    // Used by RegisterServlet to update MySQL Workbench
    public int registerUser(String name, String email, String pass, String prn, String role) {
        String sql = "INSERT INTO user_login (name, email, password, prn, role) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, pass);
            ps.setString(4, prn);
            ps.setString(5, role);
            return ps.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); return 0; }
    }
}