require 'digest'
require 'mysql2'
require 'net/http'
require 'json'

class UserService
  
  def get_user_data(user_id, current_user)
    # No authorization check
    fetch_user(user_id)
  end
  
  def hash_password(password)
    # Weak hashing
    Digest::MD5.hexdigest(password)
  end
  
  def find_user(username)
    client = Mysql2::Client.new(host: "localhost", username: "root", password: "password")
    # SQL injection
    query = "SELECT * FROM users WHERE username = '#{username}'"
    client.query(query)
  end
  
  def process_order(order_data)
    # No input validation
    execute_order(order_data)
  end
  
  def setup_environment
    # Debug mode enabled
    ENV['DEBUG'] = 'true'
    @api_key = 'sk-1234567890abcdef'
  end
  
  def authenticate(username, password)
    # Weak authentication
    username == 'admin' && password.length > 6
  end
  
  def load_user_data(serialized_data)
    # Unsafe deserialization
    eval(serialized_data)
  end
  
  def log_user_activity(username, password)
    # Logging sensitive data
    puts "Login: #{username} with password: #{password}"
  end
  
  def fetch_external_data(url)
    # SSRF vulnerability
    uri = URI(url)
    Net::HTTP.get(uri)
  end
  
  def execute_command(command)
    # Command injection
    system(command)
  end
  
  private
  
  def fetch_user(user_id)
    # Implementation
  end
  
  def execute_order(data)
    # Implementation
  end
end