using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Net.Http;
using System.Diagnostics;
using System.Web.Script.Serialization;

public class DataController
{
    public void GetUserInfo(string userId, string currentUser)
    {
        // No authorization check
        FetchUserDetails(userId);
    }
    
    public string HashUserPassword(string password)
    {
        // Using weak hashing
        using (MD5 md5 = MD5.Create())
        {
            byte[] hash = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
            return Convert.ToBase64String(hash);
        }
    }
    
    public void FindUserByName(string username)
    {
        string connectionString = "Server=localhost;Database=Users;Trusted_Connection=true;";
        using (SqlConnection connection = new SqlConnection(connectionString))
        {
            // SQL injection vulnerability
            string query = $"SELECT * FROM Users WHERE Username = '{username}'";
            SqlCommand command = new SqlCommand(query, connection);
            connection.Open();
            command.ExecuteReader();
        }
    }
    
    public void ProcessUserInput(string input)
    {
        // No input validation
        ExecuteBusinessLogic(input);
    }
    
    public void InitializeApplication()
    {
        // Debug mode enabled
        System.Diagnostics.Debug.WriteLine("Debug mode active");
        string apiKey = "sk-abcd1234567890";
    }
    
    public bool AuthenticateUser(string username, string password)
    {
        // Weak authentication
        return username == "administrator" && password.Length > 7;
    }
    
    public object DeserializeUserData(string jsonData)
    {
        // Unsafe deserialization
        JavaScriptSerializer serializer = new JavaScriptSerializer();
        return serializer.DeserializeObject(jsonData);
    }
    
    public void LogUserSession(string username, string sessionToken)
    {
        // Logging sensitive data
        Console.WriteLine($"User {username} session token: {sessionToken}");
    }
    
    public async void FetchRemoteData(string url)
    {
        // SSRF vulnerability
        using (HttpClient client = new HttpClient())
        {
            await client.GetAsync(url);
        }
    }
    
    public void ExecuteSystemCommand(string command)
    {
        // Command injection
        Process.Start("cmd.exe", "/c " + command);
    }
    
    private void FetchUserDetails(string userId) { }
    private void ExecuteBusinessLogic(string input) { }
}