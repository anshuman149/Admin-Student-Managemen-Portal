<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); 
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | Approvals</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 20px; }
        .admin-container { max-width: 1200px; margin: auto; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #4CAF50; color: white; }
        .btn-approve { background-color: #28a745; color: white; padding: 8px 12px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 13px; }
        .btn-deny { background-color: #dc3545; color: white; padding: 8px 12px; text-decoration: none; border-radius: 4px; font-weight: bold; font-size: 13px; margin-left: 5px; }
        .utr-text { font-family: monospace; color: #0056b3; font-weight: bold; background: #eef; padding: 3px 6px; }
        .fee-tag { background: #5bc0de; color: white; padding: 2px 8px; border-radius: 10px; font-size: 12px; }
        .back{background:#5bc0de; color: white;}
    </style>
</head>
<body>

<div class="admin-container">
    <h2 style="text-align: center;">👨‍💻 Admin Panel: Payment Verification</h2>
    
    <table>
        <tr>
            <th>Enrollment</th>
            <th>Name</th>
            <th>Fee Type</th> <th>Amount</th>
            <th>UTR Number</th>
            <th>Action</th>
        </tr>
        
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");
             // Purani: WHERE s.payment_status = 'PENDING'
             // Nayi Query:
             String query = "SELECT s.enrollment_no, s.full_name, p.amount, p.transaction_id, p.fee_type, p.status " +
                            "FROM students s " +
                            "JOIN payments p ON s.enrollment_no = p.enrollment_no " +
                            "WHERE p.status = 'PENDING'";
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery(query);
                
                while(rs.next()) {
                    String enroll = rs.getString("enrollment_no");
                    String utr = rs.getString("transaction_id");
        %>
                <tr>
                    <td><%= enroll %></td>
                    <td><%= rs.getString("full_name") %></td>
                    <td><span class="fee-tag"><%= rs.getString("fee_type") %></span></td>
                    <td style="font-weight: bold;">₹<%= rs.getString("amount") %></td>
                    <td><span class="utr-text"><%= utr %></span></td>
                    <td>
                        <a href="ApprovePaymentServlet?enroll=<%= enroll %>&utr=<%= utr %>" class="btn-approve">Approve</a>
                        <a href="DenyPaymentServlet?enroll=<%= enroll %>&utr=<%= utr %>" class="btn-deny">Deny</a>
                    </td>
                </tr>
        <%
                }
                con.close();
            } catch(Exception e) { out.print(e.getMessage()); }
        %>
    </table>
</div>
<div>
<button class="Back" onclick="location.href='index.jsp'">BACK TO Login Page</button>
</div>
</body>
</html>