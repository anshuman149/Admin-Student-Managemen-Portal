package com.portal; // Agar tera package name kuch aur hai toh wo likhna

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet to check if the Enrollment Number is already taken during SignUp
 */
@WebServlet("/CheckEnrollAvailability")
public class CheckEnrollAvailability extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Response type text/plain rakhenge kyunki JS ko sirf "available" ya "taken" chahiye
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        
        String enrollID = request.getParameter("enrollID");

        // Database Credentials (Apne hisaab se check kar lena)
        String dbUrl = "jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED";
        String dbUser = "avnadmin";
        String dbPass = "AVNS_jwoNr6orQRJ8JWL9863";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(dbUrl, dbUser, dbPass);

            // Hum check kar rahe hain ki kya ye enrollment number students table mein pehle se hai
            String sql = "SELECT enrollment_no FROM students WHERE enrollment_no = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, enrollID);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // Agar record mil gaya, matlab ID kisi ne le rakhi hai
                out.print("taken");
            } else {
                // Agar nahi mila, matlab naya user ise use kar sakta hai
                out.print("available");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
            out.print("error"); // Kuch gadbad hui toh JS ko pata chal jaye
        }
    }
}