package com.Deny;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/DenyPaymentServlet")
public class DenyPaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // Admin panel se ye dono cheezein aa rahi hain
        String enrollID = request.getParameter("enroll");
        String utrID = request.getParameter("utr");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");

            // Sirf PAYMENTS table mein status badlo taaki login chalta rahe
            // Hum yahan 'REJECTED' likh rahe hain jo tere JSP mein Red color dikhayega
            String sql = "UPDATE payments SET status = 'Rejected' WHERE enrollment_no = ? AND transaction_id = ?";
            
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, enrollID);
            ps.setString(2, utrID);
            
            int rowsAffected = ps.executeUpdate();

            con.close();

            if(rowsAffected > 0) {
                response.sendRedirect("admin.jsp?msg=Payment_Denied_Successfully");
            } else {
                response.sendRedirect("admin.jsp?msg=Error_Payment_Not_Found");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?msg=Error_Database_Issue");
        }
    }
}