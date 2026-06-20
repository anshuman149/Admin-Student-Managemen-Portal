package login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // ZONE 1: Data Pakadna
        String id = request.getParameter("enrollID");
        String p = request.getParameter("pass");

        try {
            // ZONE 2: Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");
            String sql = "SELECT * FROM students WHERE enrollment_no=? AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ps.setString(2, p);

            ResultSet rs = ps.executeQuery();

            // ZONE 4: Faisla (If/Else)
            if (rs.next()) {
                
                String status = rs.getString("payment_status");
                
                // --- GATEKEEPER UPDATE ---
                // Agar status APPROVED hai, toh login hone do
                if ("APPROVED".equals(status)) {
                    
                    HttpSession session = request.getSession();
                    session.setAttribute("enrollID", rs.getString("enrollment_no"));
                    session.setAttribute("fullName", rs.getString("full_name"));
                    session.setAttribute("email", rs.getString("email"));
                    session.setAttribute("phone", rs.getString("phone_no"));
                    session.setAttribute("course", rs.getString("course"));
                    session.setAttribute("semester", rs.getString("semester"));
                    session.setAttribute("sCode", rs.getString("study_centre_code"));
                    session.setAttribute("sAddress", rs.getString("study_centre_address"));
                    session.setAttribute("pAddress", rs.getString("personal_address"));
                    
                    response.sendRedirect("dashboard.jsp");
                    
                } 
                // Agar Registration hi REJECT ho gaya hai
                else if ("REJECTED".equals(status)) {
                    response.sendRedirect("index.jsp?msg=Account_Rejected_Contact_Admin");
                }
                // Agar abhi tak PENDING hai
                else {
                    response.sendRedirect("index.jsp?msg=Account_Pending_Approval");
                }
                
            } else {
                // FAIL! Galat ID ya Password
                response.sendRedirect("index.jsp?error=Invalid_Credentials");
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}