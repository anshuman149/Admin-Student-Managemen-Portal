package com.verifyotp; // Apne package ka naam check kar lena

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/VerifyOTPServlet")
public class VerifyOTPServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. User ne jo OTP input kiya hai wo nikalna
        String enteredOTP = request.getParameter("otp");

        // 2. Session se original generated OTP nikalna
        HttpSession session = request.getSession();
        String generatedOTP = (String) session.getAttribute("resetOTP");

        // Debugging ke liye console pe print kar rahe hain
        System.out.println("User entered: " + enteredOTP);
        System.out.println("System generated: " + generatedOTP);

        // 3. Match checking logic
        if (generatedOTP != null && enteredOTP != null && enteredOTP.equals(generatedOTP)) {
            // Success! Dono match ho gaye
            System.out.println("OTP Verification Successful!");
            
            // User ko naya password set karne wale page par bhej do
            response.sendRedirect("new_password.jsp");
            
        } else {
            // Fail! Galat OTP ya session expire
            System.out.println("OTP Verification Failed!");
            
            // Wapas verify page par bhejo aur error message dikhao
            response.sendRedirect("verify_otp.jsp?error=wrong_otp");
        }
    }
}