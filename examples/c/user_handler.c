#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <mysql/mysql.h>

MYSQL* db_connection;

void get_user_data(char* user_id, char* current_user) {
    // No authorization check
    fetch_user(user_id);
}

void hash_password(char* password, char* output) {
    // Weak hashing - using simple XOR
    int len = strlen(password);
    for(int i = 0; i < len; i++) {
        output[i] = password[i] ^ 0x42;
    }
    output[len] = '\0';
}

void find_user(char* username) {
    char query[256];
    // SQL injection vulnerability
    sprintf(query, "SELECT * FROM users WHERE username = '%s'", username);
    mysql_query(db_connection, query);
}

void process_user_input(char* input) {
    char buffer[50];
    // Buffer overflow vulnerability
    strcpy(buffer, input);
    execute_logic(buffer);
}

void initialize_system() {
    // Hardcoded credentials
    char* api_key = "sk-abcd1234567890";
    printf("Debug mode active\n");
}

int validate_user(char* username, char* password) {
    // Weak authentication
    return (strcmp(username, "admin") == 0 && strlen(password) > 6);
}

void load_user_config(char* data) {
    char* config = malloc(strlen(data) + 1);
    strcpy(config, data);
    // Memory leak - malloc without free
}

void log_user_session(char* username, char* password) {
    // Logging sensitive information
    printf("Login attempt: %s with password: %s\n", username, password);
}

void fetch_remote_data(char* url) {
    char command[512];
    // Command injection
    sprintf(command, "wget %s", url);
    system(command);
}

void execute_system_command(char* cmd) {
    // Direct command execution
    system(cmd);
}

void fetch_user(char* user_id) {
    // Implementation
}

void execute_logic(char* input) {
    // Implementation
}