package com.register;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // ZONE 1: Data Pakadna
        String fName = request.getParameter("fullName");
        String eMail = request.getParameter("email");
        String pNumber = request.getParameter("phone");
        String enrollID = request.getParameter("enrollmentNo");
        String courseName = request.getParameter("course");
        String pass = request.getParameter("password");
        String addr = request.getParameter("address");

        try {
            // ZONE 2: Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");
            // ZONE 3: Query (payment_status 'PENDING' add kiya hai)
            String query = "INSERT INTO students (enrollment_no, full_name, email, phone_no, course, personal_address, password, payment_status) VALUES (?, ?, ?, ?, ?, ?, ?, 'PENDING')";
            PreparedStatement ps = con.prepareStatement(query);
            
            ps.setString(1, enrollID);
            ps.setString(2, fName);
            ps.setString(3, eMail);
            ps.setString(4, pNumber);
            ps.setString(5, courseName);
            ps.setString(6, addr);
            ps.setString(7, pass);

            // ZONE 4: Execute & Forward (Asli Magic Yahan Hai)
            int row = ps.executeUpdate(); 
            
            if(row > 0) {
                // index.jsp pe nahi bhejenge! 
                // payment.jsp par bhejenge taaki wo QR scan kar sake
                request.getRequestDispatcher("payment.jsp").forward(request, response);
            } else {
                response.sendRedirect("signup.jsp?msg=Error");
            }
            
            con.close(); 

        } catch(Exception e) {
            e.printStackTrace();
            // Duplicate enrollment hone par wapas signup par bhejo
            response.sendRedirect("signup.jsp?msg=Enrollment_Already_Exists");
        }
    } 
}