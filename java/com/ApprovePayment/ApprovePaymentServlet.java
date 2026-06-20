package com.ApprovePayment;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ApprovePaymentServlet")
public class ApprovePaymentServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String enrollID = request.getParameter("enroll").trim();
    	String utrID = request.getParameter("utr").trim();

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");
            // STEP 1: Sirf us Specific Transaction (UTR) ko SUCCESS karo
            String sql = "UPDATE payments SET status = 'SUCCESS' WHERE enrollment_no = ? AND transaction_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, enrollID);
            ps.setString(2, utrID);
            ps.executeUpdate();

            // STEP 2: Optional - Agar tu chahta hai ki student login tabhi kar paye jab uska 
            // pehla payment approve ho, toh students table ko bhi update kar sakte ho.
            String sql2 = "UPDATE students SET payment_status = 'APPROVED' WHERE enrollment_no = ?";
            PreparedStatement ps2 = con.prepareStatement(sql2);
            ps2.setString(1, enrollID);
            ps2.executeUpdate();

            con.close();
            response.sendRedirect("admin.jsp?msg=Specific_Payment_Approved");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("admin.jsp?msg=Error_While_Approving");
        }
    }
}