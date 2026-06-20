<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>


<%-- Ye 3 lines browser ko force karengi fresh data laane ke liye --%>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Payment History | Student Portal</title>
    <link rel="stylesheet" href="style.css"> 
    <link rel="stylesheet" href="profile-style.css"> 
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="main">
        <jsp:include page="sidebar.jsp" />

        <div class="attendance-page-content">
            
            <h2 class="attendance-title">Payment History</h2>

            <div class="attendance-wrapper">
                <table class="attn-table">
                    <thead>
                        <tr>
                            <th>Transaction ID / UTR</th>
                            <th>Fee Type</th>
                            <th>Amount (₹)</th>
                            <th>Date</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%

                            String enrollmentNo = (String) session.getAttribute("enrollID");
                            
                            if (enrollmentNo == null) {
                                response.sendRedirect("index.jsp");
                                return;
                            }

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                            
                                Connection conn = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");
                                String query = "SELECT * FROM payments WHERE enrollment_no = ? ORDER BY payment_date DESC";
                                PreparedStatement ps = conn.prepareStatement(query);
                                ps.setString(1, enrollmentNo);
                                ResultSet rs = ps.executeQuery();

                                boolean hasHistory = false;
                                while(rs.next()) {
                                    hasHistory = true;
                                    String status = rs.getString("status");
                                    
                                  
                                    String statusColor = "#f39c12"; // Default: Orange (Pending)

                                    if(status.equalsIgnoreCase("Success")) {
                                        statusColor = "#27ae60"; // Green
                                    } 
                                    else if(status.equalsIgnoreCase("Failed") || status.equalsIgnoreCase("Rejected")) {
                                        statusColor = "#e74c3c"; // Red (Failed aur Rejected dono ke liye)
                                    }
                        %>
                        <tr>
                            <td style="font-family: monospace; font-size: 14px;"><%= rs.getString("transaction_id") %></td>
                            <td><%= rs.getString("fee_type") %></td>
                            <td style="font-weight: bold;">₹<%= rs.getDouble("amount") %></td>
                            <td><%= rs.getDate("payment_date") %></td>
                            <td>
                                <span style="background: <%= statusColor %>15; color: <%= statusColor %>; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: bold; border: 1px solid <%= statusColor %>;">
                                    <%= status.toUpperCase() %>
                                </span>
                            </td>
                        </tr>
                        <%
                                }
                                if(!hasHistory) {
                                    out.println("<tr><td colspan='5' style='text-align:center; padding: 20px;'>No payment record has been found.</td></tr>");
                                }
                                conn.close();
                            } catch (Exception e) {
                                out.println("Error: " + e.getMessage());
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="importance-section" style="background-color: #e8f4fd; border-left: 5px solid #2196f3;">
                <p><strong>Zaroori Suchna:</strong> Agar aapne payment kar di hai aur yahan 24 ghante baad bhi 'Pending' dikha raha hai, toh kripya accounts office mein apni receipt ke saath sampark karein.</p>
            </div>
            
        </div>
    </div>

</body>
</html>