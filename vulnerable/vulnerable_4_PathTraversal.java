package com.example.security;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 * Vulnerable File Handler
 * 
 * CWE-22: Improper Limitation of a Pathname to a Restricted Directory ('Path Traversal')
 * 
 * VULNERABILITY: No validation of file paths allows directory traversal
 */
public class FileHandler extends HttpServlet {
    
    private static final String BASE_DIR = "/app/files/";
    
    public void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String filename = request.getParameter("file");
        
        if (filename != null) {
            // VULNERABLE: Direct file access without path validation
            File file = new File(BASE_DIR + filename);
            
            if (file.exists()) {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=" + filename);
                
                FileInputStream fis = new FileInputStream(file);
                OutputStream out = response.getOutputStream();
                
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fis.read(buffer)) != -1) {
                    out.write(buffer, 0, bytesRead);
                }
                
                fis.close();
            } else {
                response.sendError(404, "File not found");
            }
        }
    }
    
    public String readConfigFile(String configName) {
        try {
            // VULNERABLE: No path validation
            File configFile = new File("/etc/config/" + configName);
            BufferedReader reader = new BufferedReader(new FileReader(configFile));
            StringBuilder content = new StringBuilder();
            String line;
            
            while ((line = reader.readLine()) != null) {
                content.append(line).append("\n");
            }
            
            reader.close();
            return content.toString();
        } catch (IOException e) {
            return null;
        }
    }
}