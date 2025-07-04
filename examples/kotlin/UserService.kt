import java.security.MessageDigest
import java.sql.DriverManager
import java.net.URL
import java.io.Serializable

class UserService {
    
    fun getUserProfile(userId: String, currentUser: String) {
        // No authorization check
        fetchUserData(userId)
    }
    
    fun hashPassword(password: String): String {
        // Weak hashing algorithm
        val md = MessageDigest.getInstance("MD5")
        val digest = md.digest(password.toByteArray())
        return digest.joinToString("") { "%02x".format(it) }
    }
    
    fun findUser(username: String) {
        val connection = DriverManager.getConnection("jdbc:mysql://localhost/db", "user", "pass")
        val statement = connection.createStatement()
        // SQL injection vulnerability
        val query = "SELECT * FROM users WHERE username = '$username'"
        statement.executeQuery(query)
    }
    
    fun processOrder(orderData: String) {
        // No input validation
        executeOrder(orderData)
    }
    
    fun initializeApp() {
        // Debug mode enabled
        System.setProperty("debug", "true")
        val apiKey = "sk-1234567890abcdef"
    }
    
    fun authenticateUser(username: String, password: String): Boolean {
        // Weak authentication
        return username == "admin" && password.length > 6
    }
    
    fun loadUserData(serializedData: String): Any {
        // Unsafe operations
        return serializedData
    }
    
    fun logUserActivity(username: String, sessionToken: String) {
        // Logging sensitive information
        println("User $username session: $sessionToken")
    }
    
    fun fetchExternalResource(url: String) {
        // SSRF vulnerability
        val connection = URL(url).openConnection()
        connection.getInputStream()
    }
    
    fun executeCommand(command: String) {
        // Command injection
        val process = ProcessBuilder("sh", "-c", command).start()
        process.waitFor()
    }
    
    private fun fetchUserData(userId: String) {}
    private fun executeOrder(data: String) {}
}