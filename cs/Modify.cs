using System;
using System.Collections.Generic;
using System.Data.SqlClient;

namespace DrawLuckyWheel
{
    internal class Modify
    {
        public Modify()
        {
        }

        SqlCommand sqlCommand; // Biến dùng để lưu câu lệnh SQL cho các thao tác INSERT, UPDATE, DELETE
        SqlDataReader dataReader; // Dùng để đọc dữ liệu từ cơ sở dữ liệu

        // Phương thức TaiKhoans để kiểm tra tài khoản, nhận vào một câu truy vấn SQL và trả về danh sách các tài khoản
        public List<TaiKhoan> TaiKhoans(string query)
        {
            List<TaiKhoan> taiKhoans = new List<TaiKhoan>(); // Tạo danh sách tài khoản để lưu kết quả truy vấn
            using (SqlConnection sqlConnection = Connection.GetSqlConnection()) // Mở kết nối tới cơ sở dữ liệu
            {
                sqlConnection.Open(); // Mở kết nối
                sqlCommand = new SqlCommand(query, sqlConnection); // Gán câu truy vấn vào sqlCommand
                dataReader = sqlCommand.ExecuteReader(); // Thực hiện truy vấn và nhận kết quả
                while (dataReader.Read()) // Đọc từng dòng dữ liệu trả về
                {
                    // Thêm tài khoản vào danh sách taiKhoans
                    taiKhoans.Add(new TaiKhoan(dataReader.GetString(0), dataReader.GetString(1)));
                }
                sqlConnection.Close(); // Đóng kết nối sau khi đọc xong
            }
            return taiKhoans; // Trả về danh sách tài khoản
        }

        // Phương thức Command dùng để thực thi các câu lệnh không trả về dữ liệu (như đăng ký tài khoản)
        public void Command(string query)
        {
            using (SqlConnection sqlConnection = Connection.GetSqlConnection()) // Mở kết nối tới cơ sở dữ liệu
            {
                sqlConnection.Open(); // Mở kết nối
                sqlCommand = new SqlCommand(query, sqlConnection); // Gán câu lệnh truy vấn vào sqlCommand
                sqlCommand.ExecuteNonQuery(); // Thực hiện câu lệnh (INSERT, UPDATE, DELETE)
                sqlConnection.Close(); // Đóng kết nối sau khi thực hiện xong
            }
        }

        //// Phương thức LuuDiem để lưu điểm người chơi sau 5 lượt chơi
        //public void LuuDiem(string tenNguoiChoi, int diem, int soLuot)
        //{
        //    // Chuỗi câu lệnh SQL dùng để chèn dữ liệu vào bảng TongDiem
        //    string query = "INSERT INTO TongDiem (TenNguoiChoi, Diem, SoLuot) VALUES (@TenNguoiChoi, @Diem, @SoLuot)";
        //    using (SqlConnection sqlConnection = Connection.GetSqlConnection()) // Mở kết nối tới cơ sở dữ liệu
        //    {
        //        sqlConnection.Open(); // Mở kết nối
        //        sqlCommand = new SqlCommand(query, sqlConnection); // Gán câu lệnh truy vấn vào sqlCommand

        //        // Thêm tham số vào câu lệnh SQL để tránh SQL Injection
        //        sqlCommand.Parameters.AddWithValue("@TenNguoiChoi", tenNguoiChoi); // Gán giá trị tên người chơi
        //        sqlCommand.Parameters.AddWithValue("@Diem", diem); // Gán giá trị điểm
        //        sqlCommand.Parameters.AddWithValue("@SoLuot", soLuot); // Gán giá trị số lượt chơi

        //        sqlCommand.ExecuteNonQuery(); // Thực thi câu lệnh
        //        sqlConnection.Close(); // Đóng kết nối sau khi thực thi
        //    }
        //}
    }
}