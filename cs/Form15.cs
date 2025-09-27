using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Xml.Linq;

namespace DBMS_PROJECT
{
    public partial class Exercise : Form
    {
        private int WorkoutID;
        private int ExerciseID;
        private string day;
        private string time;
        private bool flag;

        public Exercise()
        {
            InitializeComponent();
            WorkoutID = 1;
            ExerciseID = 1;
            day = "";
            time = "";
            flag = false;
        }
        public Exercise(int ID, string day, string time)
        {
            InitializeComponent();
            this.WorkoutID = ID;
            this.day = day;
            this.time = time;
            this.flag = false;
        }

        private void label5_Click(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            string connectionString = "Data Source=DESKTOP-O7N2IHD\\SQLEXPRESS;Initial Catalog=FlexTrainer;Integrated Security=True;";
            string query = "";
            //int count = 0;

            string Ename = textBox1.Text;
            string muscle = comboBox1.SelectedItem?.ToString();
            int sets = int.Parse(comboBox2.Text);
            int reps = int.Parse(comboBox3.Text);
            int rest = int.Parse(comboBox4.Text);
            string machineName = textBox2.Text;


            try
            {

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();
                    MessageBox.Show("Workout Schedule successful");

                    query = "INSERT INTO Exercise (ExerciseName, Sets, Reps, RestInterval)" +
                              "VALUES (@ExerciseName, @Sets, @Reps, @Rest)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to avoid SQL injection
                        cmd.Parameters.AddWithValue("@ExerciseName", Ename);
                        cmd.Parameters.AddWithValue("@Sets", sets);
                        cmd.Parameters.AddWithValue("@Reps", reps);
                        cmd.Parameters.AddWithValue("@Rest", rest);
                        cmd.ExecuteNonQuery();

                        cmd.CommandText = "SELECT IDENT_CURRENT('Exercise') AS LastExerciseID";
                        this.ExerciseID = Convert.ToInt32(cmd.ExecuteScalar());
                    }

                    query = "INSERT INTO WorkoutSchedule (WorkoutID, WorkoutDay, WorkoutTime, MuscleGroup, ExerciseID)" +
                               "VALUES (@WorkoutID, @WorkoutDay, @WorkoutTime, @MuscleGroup, @ExerciseID)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to avoid SQL injection
                        cmd.Parameters.AddWithValue("@WorkoutID", this.WorkoutID);
                        cmd.Parameters.AddWithValue("@WorkoutDay", this.day);
                        cmd.Parameters.AddWithValue("@WorkoutTime", this.time);
                        cmd.Parameters.AddWithValue("@MuscleGroup", muscle);
                        cmd.Parameters.AddWithValue("@ExerciseID", this.ExerciseID);

                        cmd.ExecuteNonQuery();
                    }


                    query = "INSERT INTO Machine (MachineName, ExerciseID)" +
                            "VALUES (@MachineName, @ExerciseID)";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        // Add parameters to avoid SQL injection
                        cmd.Parameters.AddWithValue("@MachineName", machineName);
                        cmd.Parameters.AddWithValue("@ExerciseID", this.ExerciseID);
                        cmd.ExecuteNonQuery();
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred: " + ex.Message);
            }
            flag = true; // exercise has been submitted

        }

        private void button2_Click(object sender, EventArgs e)
        {
            
                this.Close();
            
            
        }
    }
}
