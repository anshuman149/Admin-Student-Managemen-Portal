package com.confirmpayment;

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

@WebServlet("/ConfirmPaymentServlet")
public class ConfirmPaymentServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // ZONE 1: Data Pakadna (payment.jsp se)
        String enrollID = request.getParameter("enrollmentNo");
        String amount = request.getParameter("amount");
        String txnID = request.getParameter("txnID");

        // SMART LOGIC: Agar purana student hai (Re-registration)
        // toh wo direct payment form par aayega aur enrollmentNo null ho sakta hai.
        // Uss case mein hum Session se ID nikal lenge.
        if (enrollID == null || enrollID.trim().isEmpty() || enrollID.equals("null")) {
            HttpSession session = request.getSession();
            enrollID = (String) session.getAttribute("enrollID");
        }

        try {
            // ZONE 2: Database Connection
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");

            // ZONE 3: Sirf Payments Table mein Entry
            // (Student table ka kaam RegisterServlet ne pehle hi kar diya hai)
            String sql = "INSERT INTO payments (enrollment_no, fee_type, amount, payment_date, transaction_id, status) VALUES (?, 'Online Fee', ?, CURDATE(), ?, 'Pending')";
            PreparedStatement ps = con.prepareStatement(sql);
            
            ps.setString(1, enrollID);
            ps.setString(2, amount);
            ps.setString(3, txnID);

            // ZONE 4: Execute aur Redirect
            int result = ps.executeUpdate();
            
            if(result > 0) {
                // Payment success ho gayi! Student ko khushi-khushi index par bhej do
                response.sendRedirect("index.jsp?msg=Payment_Submitted_Wait_for_Approval");
            } else {
                response.sendRedirect("payment.jsp?error=Payment_Failed_Try_Again");
            }
            
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("payment.jsp?error=Database_Error");
        }
    }
}