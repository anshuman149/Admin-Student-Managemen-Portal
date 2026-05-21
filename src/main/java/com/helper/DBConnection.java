package com.helper;
import java.sql.*;

public class DBConnection {
    private static Connection con;
    public static Connection getConnection() {
        try {
            if (con == null) {
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_portal", "root", "123456");
            }
        } catch (Exception e) { e.printStackTrace(); }
        return con;
    }

    // --- YE WALA PART ADD KARO TEST KARNE KE LIYE ---
    public static void main(String[] args) {
        Connection c = getConnection();
        if(c != null) {
            System.out.println("Success: Database connected!");
        } else {
            System.out.println("Error: Connection failed.");
        }
    }
}