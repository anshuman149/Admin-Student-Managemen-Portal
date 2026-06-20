package com.Resetpasword;



import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/ResetPasswordServlet")
public class ResetPasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String newPass = request.getParameter("newPassword");
        String confirmPass = request.getParameter("confirmPassword");
        
        HttpSession session = request.getSession();
        String enrollment_no = (String) session.getAttribute("resetEnrollment");

        if (newPass != null && newPass.equals(confirmPass)) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");

                // Password update karne ki query
                String sql = "UPDATE students SET password = ? WHERE enrollment_no = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1, newPass);
                ps.setString(2, enrollment_no);

                int rows = ps.executeUpdate();
                if (rows > 0) {
                    // Password update ho gaya, session clear karo aur login pe bhejo
                    session.invalidate();
                    response.sendRedirect("index.jsp?msg=password_updated");
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            response.sendRedirect("new_password.jsp?error=mismatch");
        }
    }
}