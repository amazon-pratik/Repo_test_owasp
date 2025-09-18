package com.example.security;

import java.sql.*;
import javax.servlet.http.*;

/**
 * Vulnerable User Authentication
 * 
 * CWE-89: Improper Neutralization of Special Elements used in an SQL Command ('SQL Injection')
 * 
 * VULNERABILITY: Uses string concatenation to build SQL queries
 */
public class UserAuthenticator {
    
    private Connection connection;
    
    public boolean authenticateUser(String username, String password) {
        try {
            // VULNERABLE: Direct string concatenation allows SQL injection
            String query = "SELECT * FROM users WHERE username = '" + username + 
                          "' AND password = '" + password + "'";
            
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public User getUserById(String userId) {
        try {
            // VULNERABLE: No input validation or parameterization
            String query = "SELECT * FROM users WHERE id = " + userId;
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery(query);
            
            if (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}

class User {
    private int id;
    private String username;
    private String email;
    
    public void setId(int id) { this.id = id; }
    public void setUsername(String username) { this.username = username; }
    public void setEmail(String email) { this.email = email; }
    public int getId() { return id; }
    public String getUsername() { return username; }
    public String getEmail() { return email; }
}