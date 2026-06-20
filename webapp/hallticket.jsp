<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Hall Ticket | Student Portal</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .admit-card-box {
            background: white;
            border: 2px solid #333;
            padding: 30px;
            max-width: 800px;
            margin: 20px auto;
            position: relative;
        }
        .admit-header { text-align: center; border-bottom: 2px solid #333; padding-bottom: 10px; margin-bottom: 20px; }
        .student-info { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .info-item { font-size: 16px; margin-bottom: 5px; }
        .exam-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
        .exam-table th, .exam-table td { border: 1px solid #333; padding: 10px; text-align: left; }
        .print-btn { background: #444; color: white; padding: 10px 20px; border: none; cursor: pointer; float: right; }
        @media print { .sidebar, .header, .print-btn { display: none; } .admit-card-box { border: none; } }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="main">
        <jsp:include page="sidebar.jsp" />
        <div class="content-area" style="width: 100%;">
            
            <button class="print-btn" onclick="window.print()">Print Admit Card</button>
            
            <div class="admit-card-box">
                <div class="admit-header">
                    <h2>UNIVERSITY EXAMINATION HALL TICKET</h2>
                    <p>Term End Examination (TEE) - June 2026</p>
                </div>

                <div class="student-info">
                    <div>
                        <div class="info-item"><strong>Enrollment No:</strong> <%= session.getAttribute("enrollID") %></div>
                        <div class="info-item"><strong>Name:</strong> <%= session.getAttribute("fullName") %></div>
                        <div class="info-item"><strong>Course:</strong> <%= session.getAttribute("course") %></div>
                    </div>
                    <div style="text-align: right;">
                        <div class="info-item"><strong>Semester:</strong> <%= session.getAttribute("semester") %></div>
                        <div class="info-item"><strong>Exam Center:</strong> Delhi (West-07)</div>
                    </div>
                </div>

                <table class="exam-table">
                    <thead>
                        <tr>
                            <th>Subject Code</th>
                            <th>Subject Name</th>
                            <th>Date</th>
                            <th>Session</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                String userCourse = (String) session.getAttribute("course");
                                String userSem = (String) session.getAttribute("semester");
                                
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                Connection con = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");
                                String sql = "SELECT * FROM hall_tickets WHERE course_name = ? AND semester = ?";
                                PreparedStatement ps = con.prepareStatement(sql);
                                ps.setString(1, userCourse);
                                ps.setString(2, userSem);
                                ResultSet rs = ps.executeQuery();
                                
                                boolean found = false;
                                while(rs.next()) {
                                    found = true;
                        %>
                            <tr>
                                <td><%= rs.getString("subject_code") %></td>
                                <td><%= rs.getString("subject_name") %></td>
                                <td><%= rs.getDate("exam_date") %></td>
                                <td><%= rs.getString("exam_time") %></td>
                            </tr>
                        <% 
                                }
                                if(!found) {
                                    out.println("<tr><td colspan='4' style='text-align:center;'>Abhi tak hall ticket generate nahi hui hai.</td></tr>");
                                }
                                con.close();
                            } catch(Exception e) { out.println(e.getMessage()); }
                        %>
                    </tbody>
                </table>

                <div style="margin-top: 40px; font-size: 12px; color: #555;">
                    <p>* Kripya exam center par apna original ID card saath le kar aayein.</p>
                    <p>* Examination hall mein mobile phone allowed nahi hai.</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>