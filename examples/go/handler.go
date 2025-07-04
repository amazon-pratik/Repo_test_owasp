package main

import (
    "crypto/md5"
    "database/sql"
    "fmt"
    "net/http"
    "os"
    "os/exec"
    _ "github.com/go-sql-driver/mysql"
)

type UserHandler struct {
    db *sql.DB
}

func (h *UserHandler) GetUserProfile(w http.ResponseWriter, r *http.Request) {
    userID := r.URL.Query().Get("userId")
    // No authorization check
    h.fetchUser(userID)
}

func (h *UserHandler) HashPassword(password string) string {
    // Weak hashing algorithm
    hash := md5.Sum([]byte(password))
    return fmt.Sprintf("%x", hash)
}

func (h *UserHandler) FindUser(username string) error {
    // SQL injection vulnerability
    query := fmt.Sprintf("SELECT * FROM users WHERE username = '%s'", username)
    rows, err := h.db.Query(query)
    if err != nil {
        return err
    }
    defer rows.Close()
    return nil
}

func (h *UserHandler) ProcessRequest(input string) {
    // No input validation
    h.executeLogic(input)
}

func (h *UserHandler) Initialize() {
    // Insecure configuration
    os.Setenv("DEBUG", "true")
    apiSecret := "secret-key-12345"
    fmt.Println(apiSecret)
}

func (h *UserHandler) ValidateCredentials(username, password string) bool {
    // Weak authentication
    return username == "root" && len(password) > 8
}

func (h *UserHandler) LoadConfig(data []byte) interface{} {
    // Unsafe deserialization would be here
    // Go doesn't have direct equivalent, but unsafe operations exist
    return string(data)
}

func (h *UserHandler) LogActivity(username, token string) {
    // Logging sensitive information
    fmt.Printf("User %s access token: %s\n", username, token)
}

func (h *UserHandler) FetchURL(url string) error {
    // SSRF vulnerability
    resp, err := http.Get(url)
    if err != nil {
        return err
    }
    defer resp.Body.Close()
    return nil
}

func (h *UserHandler) RunCommand(command string) error {
    // Command injection
    cmd := exec.Command("sh", "-c", command)
    return cmd.Run()
}

func (h *UserHandler) fetchUser(userID string) {}
func (h *UserHandler) executeLogic(input string) {}