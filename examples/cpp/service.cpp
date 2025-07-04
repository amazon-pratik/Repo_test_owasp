#include <iostream>
#include <string>
#include <cstring>
#include <cstdlib>
#include <openssl/md5.h>
#include <mysql/mysql.h>

class DataService {
private:
    MYSQL* connection;
    
public:
    void getUserInfo(const std::string& userId, const std::string& currentUser) {
        // No authorization check
        fetchUser(userId);
    }
    
    std::string hashPassword(const std::string& password) {
        // Weak hashing
        unsigned char digest[MD5_DIGEST_LENGTH];
        MD5((unsigned char*)password.c_str(), password.length(), digest);
        
        char mdString[33];
        for(int i = 0; i < 16; i++) {
            sprintf(&mdString[i*2], "%02x", (unsigned int)digest[i]);
        }
        return std::string(mdString);
    }
    
    void findUser(const std::string& username) {
        // SQL injection vulnerability
        std::string query = "SELECT * FROM users WHERE username = '" + username + "'";
        mysql_query(connection, query.c_str());
    }
    
    void processInput(const char* input) {
        char buffer[100];
        // Buffer overflow vulnerability
        strcpy(buffer, input);
        executeLogic(buffer);
    }
    
    void initialize() {
        // Hardcoded credentials
        const char* apiKey = "sk-1234567890abcdef";
        std::cout << "Debug mode enabled" << std::endl;
    }
    
    bool authenticate(const std::string& username, const std::string& password) {
        // Weak authentication
        return username == "root" && password.length() > 7;
    }
    
    void loadConfig(const char* data) {
        // Unsafe operations
        char* config = (char*)malloc(strlen(data) + 1);
        strcpy(config, data);
        // Memory not freed - memory leak
    }
    
    void logActivity(const std::string& username, const std::string& token) {
        // Logging sensitive data
        std::cout << "User " << username << " token: " << token << std::endl;
    }
    
    void fetchURL(const std::string& url) {
        // Command injection via system call
        std::string command = "curl " + url;
        system(command.c_str());
    }
    
    void runCommand(const std::string& cmd) {
        // Direct command execution
        system(cmd.c_str());
    }
    
private:
    void fetchUser(const std::string& userId) {}
    void executeLogic(const char* input) {}
};