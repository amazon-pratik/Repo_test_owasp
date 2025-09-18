package com.example.security;

import java.io.*;
import java.sql.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;
import java.security.*;
import java.net.*;

/**
 * Vulnerable OpenID Authentication Manager
 * 
 * CWE-203: Observable Discrepancy (Timing Attack)
 * 
 * VULNERABILITY: Uses direct string comparison for signature verification
 * which allows timing attacks to determine valid signatures.
 */
public class OpenIdManager {
    
    private String returnTo;
    
    public Authentication getAuthentication(HttpServletRequest request, byte[] key, String alias) {
        String identity = request.getParameter("openid.identity");
        if (identity == null) {
            throw new OpenIdException("Missing 'openid.identity'.");
        }
        
        String sig = request.getParameter("openid.sig");
        if (sig == null) {
            throw new OpenIdException("Missing 'openid.sig'.");
        }
        
        String signed = request.getParameter("openid.signed");
        if (signed == null) {
            throw new OpenIdException("Missing 'openid.signed'.");
        }
        
        if (!returnTo.equals(request.getParameter("openid.return_to"))) {
            throw new OpenIdException("Bad 'openid.return_to'.");
        }
        
        String[] params = signed.split("[\\,]+");
        StringBuilder sb = new StringBuilder(1024);
        
        for (String param : params) {
            sb.append(param).append(':');
            String value = request.getParameter("openid." + param);
            if (value != null) {
                sb.append(value);
            }
            sb.append('\n');
        }
        
        String hmac = getHmacSha1(sb.toString(), key);
        
        // VULNERABLE: Direct string comparison allows timing attacks
        if (!sig.equals(hmac)) {
            throw new OpenIdException("Verify signature failed.");
        }
        
        Authentication auth = new Authentication();
        auth.setIdentity(identity);
        auth.setEmail(request.getParameter("openid." + alias + ".value.email"));
        return auth;
    }
    
    private String getHmacSha1(String data, byte[] key) {
        try {
            Mac mac = Mac.getInstance("HmacSHA1");
            SecretKeySpec keySpec = new SecretKeySpec(key, "HmacSHA1");
            mac.init(keySpec);
            byte[] result = mac.doFinal(data.getBytes("UTF-8"));
            return Base64.getEncoder().encodeToString(result);
        } catch (Exception e) {
            throw new RuntimeException("HMAC calculation failed", e);
        }
    }
}

class Authentication {
    private String identity;
    private String email;
    
    public void setIdentity(String identity) { this.identity = identity; }
    public void setEmail(String email) { this.email = email; }
    public String getIdentity() { return identity; }
    public String getEmail() { return email; }
}

class OpenIdException extends RuntimeException {
    public OpenIdException(String message) {
        super(message);
    }
}