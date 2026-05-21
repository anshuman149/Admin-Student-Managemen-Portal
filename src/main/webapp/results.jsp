<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Academic Results | Student Portal</title>
    <link rel="stylesheet" href="style.css">
    <link rel="stylesheet" href="profile-style.css">
    <style>
        .result-card { background: white; border-radius: 10px; padding: 20px; margin-bottom: 30px; box-shadow: 0 4px 10px rgba(0,0,0,0.05); border-top: 4px solid #3498db; }
        .sem-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; border-bottom: 1px solid #eee; padding-bottom: 10px; }
        .grade-badge { padding: 4px 12px; border-radius: 4px; font-weight: bold; font-size: 14px; }
        .grade-A { background: #e8f5e9; color: #2e7d32; }
        .grade-B { background: #fff3e0; color: #ef6c00; }
        .grade-F { background: #ffebee; color: #c62828; }
        .total-row { background: #f8f9fa; font-weight: bold; }
    </style>
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="main">
        <jsp:include page="sidebar.jsp" />

        <div class="attendance-page-content">
            <h2 class="attendance-title">My Academic Results</h2>

            <%
                String enrollID = (String) session.getAttribute("enrollID");
                if (enrollID == null) { response.sendRedirect("index.jsp"); return; }

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_portal", "root", "123456");

                    // Query jo Grades aur Subjects ko join karke data layegi
                    String sql = "SELECT g.*, s.subject_name, s.subject_code " +
                                 "FROM grades g " +
                                 "JOIN subjects s ON g.subject_id = s.subject_id " +
                                 "WHERE g.enrollment_no = ? " +
                                 "ORDER BY g.semester DESC, s.subject_code ASC";
                    
                    PreparedStatement ps = con.prepareStatement(sql);
                    ps.setString(1, enrollID);
                    ResultSet rs = ps.executeQuery();

                    int currentSem = -1;
                    boolean hasData = false;

                    while(rs.next()) {
                        hasData = true;
                        int sem = rs.getInt("semester");

                        // Agar semester badalta hai toh nayi table shuru karo
                        if(sem != currentSem) {
                            if(currentSem != -1) { out.println("</tbody></table></div>"); }
                            currentSem = sem;
            %>
                <div class="result-card">
                    <div class="sem-header">
                        <h3>Semester <%= currentSem %></h3>
                        <span style="color: #666; font-size: 14px;">Course: <%= session.getAttribute("course") %></span>
                    </div>
                    <table class="attn-table">
                        <thead>
                            <tr>
                                <th>Code</th>
                                <th>Subject Name</th>
                                <th>Marks</th>
                                <th>Grade</th>
                            </tr>
                        </thead>
                        <tbody>
            <% 
                        } 
            %>
                            <tr>
                                <td style="font-family: monospace;"><%= rs.getString("subject_code") %></td>
                                <td><%= rs.getString("subject_name") %></td>
                                <td><%= rs.getInt("marks_obtained") %> / 100</td>
                                <td>
                                    <% String g = rs.getString("grade"); %>
                                    <span class="grade-badge grade-<%= g.substring(0,1) %>"><%= g %></span>
                                </td>
                            </tr>
            <%
                    }
                    if(hasData) {
                        out.println("</tbody></table></div>");
                    } else {
                        out.println("<div class='result-card'><p style='text-align:center;'>NO RESULT IS UPDATE PLEASE CHECK LATER.</p></div>");
                    }
                    con.close();
                } catch(Exception e) {
                    out.println("Error: " + e.getMessage());
                }
            %>
            
            <div class="importance-section">
                <p><strong>Note:</strong> Yeh marks internal aur external dono ka total hain. Final degree ke liye IGNOU ki official marksheet hi valid hogi.</p>
            </div>
        </div>
    </div>
</body>
</html>