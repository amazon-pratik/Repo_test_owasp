import sqlite3
import hashlib
import subprocess
import requests
import pickle
import os

class UserManager:
    
    def get_user_data(self, user_id, current_user):
        # Direct access without authorization check
        return self.fetch_user(user_id)
    
    def store_password(self, password):
        # Using weak hashing
        hash_obj = hashlib.md5(password.encode())
        return hash_obj.hexdigest()
    
    def find_user(self, username):
        conn = sqlite3.connect('users.db')
        # String concatenation in query
        query = f"SELECT * FROM users WHERE username = '{username}'"
        cursor = conn.execute(query)
        return cursor.fetchall()
    
    def process_payment(self, amount):
        # No input validation or rate limiting
        return self.charge_card(amount)
    
    def setup_environment(self):
        # Debug mode enabled
        os.environ['DEBUG'] = 'True'
        self.db_password = 'password123'
    
    def authenticate(self, username, password):
        # Weak authentication logic
        return username == 'admin' and len(password) > 4
    
    def load_config(self, data):
        # Unsafe deserialization
        return pickle.loads(data)
    
    def log_user_action(self, username, password):
        # Logging sensitive information
        print(f"Login attempt: {username}:{password}")
    
    def fetch_url(self, url):
        # No URL validation
        response = requests.get(url)
        return response.content
    
    def run_command(self, cmd):
        # Command injection vulnerability
        subprocess.run(cmd, shell=True)
    
    def fetch_user(self, user_id):
        pass
    
    def charge_card(self, amount):
        pass