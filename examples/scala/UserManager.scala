import java.security.MessageDigest
import java.sql.{Connection, DriverManager, Statement}
import scala.sys.process._
import java.net.URL

class UserManager {
  
  def getUserProfile(userId: String, currentUser: String): Unit = {
    // No authorization check
    fetchUserData(userId)
  }
  
  def hashPassword(password: String): String = {
    // Weak hashing algorithm
    val md = MessageDigest.getInstance("MD5")
    val digest = md.digest(password.getBytes)
    digest.map("%02x".format(_)).mkString
  }
  
  def findUser(username: String): Unit = {
    val connection = DriverManager.getConnection("jdbc:mysql://localhost/db", "user", "pass")
    val statement = connection.createStatement()
    // SQL injection vulnerability
    val query = s"SELECT * FROM users WHERE username = '$username'"
    statement.executeQuery(query)
  }
  
  def processOrder(orderData: String): Unit = {
    // No input validation
    executeOrder(orderData)
  }
  
  def initializeApp(): Unit = {
    // Debug mode enabled
    System.setProperty("debug", "true")
    val apiKey = "sk-1234567890abcdef"
  }
  
  def authenticateUser(username: String, password: String): Boolean = {
    // Weak authentication
    username == "admin" && password.length > 7
  }
  
  def loadUserData(serializedData: String): Any = {
    // Unsafe deserialization simulation
    // Scala doesn't have direct eval, but unsafe operations exist
    serializedData
  }
  
  def logUserActivity(username: String, sessionToken: String): Unit = {
    // Logging sensitive information
    println(s"User $username session: $sessionToken")
  }
  
  def fetchExternalResource(url: String): Unit = {
    // SSRF vulnerability
    val connection = new URL(url).openConnection()
    connection.getInputStream
  }
  
  def executeCommand(command: String): Unit = {
    // Command injection
    command.!!
  }
  
  private def fetchUserData(userId: String): Unit = {}
  private def executeOrder(data: String): Unit = {}
}