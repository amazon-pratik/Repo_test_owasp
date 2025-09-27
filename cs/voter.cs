using System;
using System.Data.SqlClient;
using System.IO;
using System.Windows.Forms;
using System.Drawing;


namespace Voting_System__SDP_
{
    public partial class voter : Form
    {
        public string email, name, vote_name, table_name, temp;
        DateTime start_date, end_date;
        bool vote_running = false, given_vote = true;
        string connection_string = @"Data Source=DESKTOP-NMF9NAR\SQLEXPRESS;Initial Catalog=SDP_Voting_System;Integrated Security=True;Encrypt=False";

        public voter(string user_email)
        {
            email = user_email;
            InitializeComponent();
            InitializeVotingData();
            LoadCandidateData();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            // Get the selected email from the combo box
            string selectedEmail = comboBox1.SelectedItem?.ToString();

            if (string.IsNullOrEmpty(selectedEmail))
            {
                MessageBox.Show("Please select a candidate email.", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                return;
            }

            try
            {
                // Query to get the name and photo of the selected email from user_data
                string queryUserData = "SELECT name, photo FROM user_data WHERE email = @Email";
                using (SqlConnection connection = new SqlConnection(connection_string))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(queryUserData, connection))
                    {
                        command.Parameters.AddWithValue("@Email", selectedEmail);
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            // Get the name and photo from the database
                            string candidateName = reader["name"].ToString();
                            byte[] candidatePhoto = (byte[])reader["photo"];

                            // Set the name label
                            label7.Text = candidateName;

                            // Display the candidate photo in the picture box
                            if (candidatePhoto != null && candidatePhoto.Length > 0)
                            {
                                using (MemoryStream ms = new MemoryStream(candidatePhoto))
                                {
                                    pictureBox1.Image = Image.FromStream(ms);
                                }
                            }
                            else
                            {
                                // If no photo found, display default image or leave it empty
                                pictureBox1.Image = null;
                            }
                        }
                        else
                        {
                            MessageBox.Show("User not found.");
                        }
                    }
                }

                // Query to get the number of votes received by the selected candidate

                table_name = vote_name + "_candidate";
                string queryVoteCount = $"SELECT vote_number FROM {table_name} WHERE email = @CandidateEmail";
                using (SqlConnection connection = new SqlConnection(connection_string))
                {
                    connection.Open();
                    using (SqlCommand command = new SqlCommand(queryVoteCount, connection))
                    {
                        command.Parameters.AddWithValue("@CandidateEmail", selectedEmail);
                        int voteCount = (int)command.ExecuteScalar();
                        label9.Text = voteCount.ToString(); // Display the vote count on label9
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred: {ex.Message}", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }



        private void voter_Load(object sender, EventArgs e)
        {
            string connection_string = @"Data Source=DESKTOP-NMF9NAR\SQLEXPRESS;Initial Catalog=SDP_Voting_System;Integrated Security=True;Encrypt=False";

            try
            {
                // Connect to database
                using (SqlConnection connection = new SqlConnection(connection_string))
                {
                    connection.Open();

                    // Construct table name dynamically (avoid SQL injection)
                    string tableName = vote_name + "_candidate";

                    // Prepare and execute query (example: retrieve candidate list)
                    string query = $"SELECT * FROM {tableName}"; // Use string interpolation for clarity
                    SqlCommand command = new SqlCommand(query, connection);
                    SqlDataReader reader = command.ExecuteReader();

                    // Populate UI elements (example: combo box with candidate names)
                    while (reader.Read())
                    {
                        string candidateemail = reader.GetString(reader.GetOrdinal("email"));
                        comboBox1.Items.Add(candidateemail); // Add candidateEmail to combo box or other UI element
                    }

                    reader.Close();
                }
            }
            catch (SqlException ex)
            {
                // Handle database connection or query execution errors
                MessageBox.Show("Error connecting to database: " + ex.Message, "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

            try
            {
                using (SqlConnection connection = new SqlConnection(connection_string))
                {
                    connection.Open();

                    // Construct table name dynamically (avoid SQL injection)
                    string tableName = vote_name + "_candidate";

                    // Prepare and execute query (example: retrieve candidate list)
                    string query = $"SELECT email, vote_number FROM {tableName} where vote_number = (SELECT MAX(vote_number) From {tableName})"; // Use string interpolation for clarity
                    SqlCommand command = new SqlCommand(query, connection);
                    SqlDataReader reader = command.ExecuteReader();

                    string candidateemail;
                    int vote_num;

                    // Populate UI elements (example: combo box with candidate names)
                    while (reader.Read())
                    {
                        candidateemail = reader.GetString(reader.GetOrdinal("email"));
                        vote_num = (int)reader["vote_number"];

                        temp = candidateemail;
                        label8.Text = vote_num.ToString(); // Set the label text
                    }

                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred while loading candidate data: {ex.Message}");
            }

            try
            {
                using (SqlConnection connection = new SqlConnection(connection_string))
                {
                    connection.Open();
                    string query = $"SELECT name FROM user_data where email = @Email"; // Use string interpolation for clarity
                    SqlCommand command = new SqlCommand(query, connection);
                    command.Parameters.AddWithValue("@Email", temp);
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        name = reader.GetString(reader.GetOrdinal("name"));
                    }

                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error retrieving data: " + ex.Message);
                return;
            }

            label4.Text = name;
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {
        }

        private void panel2_Paint(object sender, PaintEventArgs e)
        {
        }

        private void panel1_Paint(object sender, PaintEventArgs e)
        {
            label2.Text = name;
        }

        private void InitializeVotingData()
        {
            try
            {
                // Get user name
                string query = "SELECT name FROM user_data WHERE email = @Email";
                using (SqlConnection connect = new SqlConnection(connection_string))
                {
                    using (SqlCommand cmd = new SqlCommand(query, connect))
                    {
                        cmd.Parameters.AddWithValue("@Email", email);
                        connect.Open();
                        name = (string)cmd.ExecuteScalar() ?? "Null";
                    }
                }

                // Get the latest vote details
                query = @"SELECT TOP 1 vote_name, start_date, end_date FROM votelist ORDER BY end_date DESC";
                using (SqlConnection conn = new SqlConnection(connection_string))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        vote_name = reader["vote_name"].ToString();
                        table_name = vote_name + "_voted";
                        start_date = Convert.ToDateTime(reader["start_date"]);
                        end_date = Convert.ToDateTime(reader["end_date"]);
                        DateTime currentDate = DateTime.Now;

                        if (currentDate >= start_date && currentDate <= end_date)
                        {
                            vote_running = true;
                        }
                    }
                    else
                    {
                        MessageBox.Show("No votes found.");
                    }
                }

                // Check if the user has already voted
                if (vote_running)
                {
                    using (SqlConnection connect = new SqlConnection(connection_string))
                    {
                        query = $"SELECT COUNT(*) FROM {table_name} WHERE email = @Email";
                        using (SqlCommand command = new SqlCommand(query, connect))
                        {
                            command.Parameters.AddWithValue("@Email", email);
                            connect.Open();
                            int count = (int)command.ExecuteScalar();
                            given_vote = count > 0;
                        }
                    }
                }

                if (!given_vote)
                {
                    voting_page vp = new voting_page(email, vote_name);
                    vp.Show();

                    this.Hide();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred: {ex.Message}");
            }
        }

        private void LoadCandidateData()
        {
            try
            {
                string tableName = vote_name + "_candidate";
                string query = $"SELECT email, vote_number FROM {tableName} WHERE vote_number = (SELECT MAX(vote_number) FROM {tableName})";

                using (SqlConnection connection = new SqlConnection(connection_string))
                {
                    connection.Open();
                    SqlCommand command = new SqlCommand(query, connection);
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        string candidateEmail = reader.GetString(reader.GetOrdinal("email"));
                        int voteNumber = (int)reader["vote_number"];

                        // Do something with candidateEmail and voteNumber
                        // For example, update UI elements
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred while loading candidate data: {ex.Message}");
            }
        }
    }
}