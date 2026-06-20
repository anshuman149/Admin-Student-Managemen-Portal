package com.teacherportal;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TeacherLoginServlet")
public class TeacherLoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");

        // Yahan aapka username aur password match kiya ja raha hai
        if ("anshuman".equals(user) && "Anshu@1122".equals(pass)) {
            
            // Login successful hone par Session create kar rahe hain
            HttpSession session = request.getSession();
            session.setAttribute("teacher_logged_in", true);
            
            // DHYAAN DEIN: "confirm_payment.jsp" ki jagah apne actual payment page ya servlet ka naam likhein
            response.sendRedirect("admin.jsp"); 
            
        } else {
            // Password galat hone par wapas login page par bhej dega error ke sath
            response.sendRedirect("teacher_login.jsp?error=1");
        }
    }
}