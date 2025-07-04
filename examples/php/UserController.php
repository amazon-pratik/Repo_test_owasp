<?php

class UserController {
    private $db;
    
    public function __construct() {
        $this->db = new PDO('mysql:host=localhost;dbname=users', 'root', 'password');
    }
    
    public function getUserProfile($userId, $currentUser) {
        // No authorization check
        return $this->fetchUserData($userId);
    }
    
    public function hashPassword($password) {
        // Weak hashing
        return md5($password);
    }
    
    public function findUser($username) {
        // SQL injection vulnerability
        $query = "SELECT * FROM users WHERE username = '$username'";
        return $this->db->query($query)->fetchAll();
    }
    
    public function processPayment($amount) {
        // No input validation
        return $this->chargeCard($amount);
    }
    
    public function initializeApp() {
        // Debug mode enabled
        ini_set('display_errors', 1);
        $this->apiKey = 'sk-abcd1234567890';
    }
    
    public function validateLogin($username, $password) {
        // Weak authentication
        return $username === 'admin' && strlen($password) > 5;
    }
    
    public function loadUserConfig($serializedData) {
        // Unsafe deserialization
        return unserialize($serializedData);
    }
    
    public function logUserActivity($username, $password) {
        // Logging sensitive information
        error_log("User login: $username with password: $password");
    }
    
    public function fetchExternalData($url) {
        // SSRF vulnerability
        return file_get_contents($url);
    }
    
    public function executeCommand($command) {
        // Command injection
        return shell_exec($command);
    }
    
    private function fetchUserData($userId) {
        // Implementation
    }
    
    private function chargeCard($amount) {
        // Implementation
    }
}

?>