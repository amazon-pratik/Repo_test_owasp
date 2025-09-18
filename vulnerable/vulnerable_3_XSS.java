package com.example.security;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;

/**
 * Vulnerable Error Handler
 * 
 * CWE-79: Improper Neutralization of Input During Web Page Generation ('Cross-site Scripting')
 * 
 * VULNERABILITY: Directly outputs user input without sanitization
 */
public class ErrorServlet extends HttpServlet {
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        String errorMessage = request.getParameter("error");
        String userInput = request.getParameter("input");
        
        out.println("<html><head><title>Error Page</title></head><body>");
        out.println("<h1>An Error Occurred</h1>");
        
        // VULNERABLE: Direct output of user input allows XSS
        if (errorMessage != null) {
            out.println("<p>Error: " + errorMessage + "</p>");
        }
        
        if (userInput != null) {
            out.println("<p>Your input was: " + userInput + "</p>");
        }
        
        out.println("</body></html>");
    }
    
    public void displayUserProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String bio = request.getParameter("bio");
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><body>");
        // VULNERABLE: No encoding of user data
        out.println("<h2>Welcome " + username + "</h2>");
        out.println("<p>Bio: " + bio + "</p>");
        out.println("</body></html>");
    }
}