# JavaScript CWE Examples Summary (High-Priority Dataset)

This curated dataset contains examples of the **most critical** security vulnerabilities in JavaScript applications.

## High-Priority CWE Categories (10 categories, 61 files):

### CWE-022: Path Traversal
**Description:** Improper Limitation of a Pathname to a Restricted Directory
**Risk Level:** HIGH - File system access vulnerabilities

### CWE-078: OS Command Injection  
**Description:** Improper Neutralization of Special Elements used in an OS Command
**Risk Level:** CRITICAL - System compromise vulnerabilities

### CWE-079: Cross-site Scripting (XSS)
**Description:** Improper Neutralization of Input During Web Page Generation
**Risk Level:** CRITICAL - Most common web vulnerability

### CWE-089: SQL Injection
**Description:** Improper Neutralization of Special Elements used in an SQL Command
**Risk Level:** CRITICAL - Database security vulnerabilities

### CWE-094: Code Injection
**Description:** Improper Control of Generation of Code
**Risk Level:** CRITICAL - Arbitrary code execution

### CWE-200: Information Exposure
**Description:** Exposure of Sensitive Information to an Unauthorized Actor
**Risk Level:** HIGH - Data leakage vulnerabilities

### CWE-295: Certificate Validation
**Description:** Improper Certificate Validation
**Risk Level:** HIGH - HTTPS/TLS security issues

### CWE-352: Cross-Site Request Forgery (CSRF)
**Description:** Cross-Site Request Forgery
**Risk Level:** HIGH - State-changing operation vulnerabilities

### CWE-502: Deserialization of Untrusted Data
**Description:** Deserialization of Untrusted Data
**Risk Level:** CRITICAL - Remote code execution via data

### CWE-601: Open Redirect
**Description:** URL Redirection to Untrusted Site
**Risk Level:** MEDIUM-HIGH - Phishing and social engineering

## Dataset Statistics
- **Total JS Files:** 61
- **Target Achieved:** ✅ Under 80 files
- **Coverage:** Top 10 most critical web security vulnerabilities
- **Quality:** Each category includes vulnerable and fixed examples

## Usage
This dataset focuses on the most impactful security vulnerabilities that every JavaScript developer should understand and prevent.

## File Structure
Each CWE directory contains:
- `examples/` - Vulnerable and secure code samples
- Clear naming: `_basic.js` (vulnerable), `_fixed.js` (secure)