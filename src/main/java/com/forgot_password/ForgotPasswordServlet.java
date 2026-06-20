package com.forgot_password;


import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ForgotPasswordServlet")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String enrollment_no = request.getParameter("enrollment_no");
        String isResend = request.getParameter("resend");
        HttpSession session = request.getSession();
        
        // 1. Agar Resend par click kiya hai toh session se username uthao
        if (isResend != null && isResend.equals("true")) {
           enrollment_no = (String) session.getAttribute("resetEnrollment");
        }

        String email = null;

        try {
            // 2. Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            // Database details update karein
            Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");

            // 3. Email nikalne ke liye Query
            String query = "SELECT email FROM students WHERE enrollment_no = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, enrollment_no);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                email = rs.getString("email");

                // 4. 6-Digit OTP Generate karna
                Random rand = new Random();
                int otpValue = 100000 + rand.nextInt(900000);
                String otp = String.valueOf(otpValue);

                // 5. Session mein Data Save karna
                session.setAttribute("resetOTP", otp);
                session.setAttribute("resetEnrollment",enrollment_no);

                // 6. Email Bhejna (Using our EmailSender class)
                EmailSender.sendOTP(email, otp);
                
                System.out.println("OTP sent successfully to: " + email);

                // 7. Verify page par redirect karna
                response.sendRedirect("verify_otp.jsp");

            } else {
                // User nahi mila
                response.sendRedirect("forgor_passsword.jsp?error=not_found");
            }
            
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("System Error: " + e.getMessage());
        }
    }
    
    // Agar koi link se (GET request) resend karna chahe toh doPost ko hi call karega
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}