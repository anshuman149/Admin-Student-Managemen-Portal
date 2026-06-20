<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Academic Marks | Student Portal</title>
    <link rel="stylesheet" href="style.css"> 
    <link rel="stylesheet" href="profile-style.css"> 
</head>
<body>

    <jsp:include page="header.jsp" />

    <div class="main">
        <jsp:include page="sidebar.jsp" />

        <div class="attendance-page-content">
            
            <h2 class="attendance-title">Academic Performance</h2>

            <div class="attendance-wrapper">
                <table class="attn-table">
                    <thead>
                        <tr>
                            <th>Subject Code</th>
                            <th>Subject Name</th>
                            <th>Internal</th>
                            <th>External</th>
                            <th>Total Marks</th>
                            <th>Grade</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            // FIX: LoginServlet mein tune "enrollID" use kiya hai, toh yahan bhi wahi aayega
                            String enrollmentNo = (String) session.getAttribute("enrollID");
                            
                            if (enrollmentNo == null) {
                                response.sendRedirect("index.jsp");
                                return;
                            }

                            try {
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                // FIX: Tera password '123456' hai servlet ke hisaab se
                                 Connection conn = DriverManager.getConnection("jdbc:mysql://mysql-359b7680-anshusaxena149-a289.l.aivencloud.com:10169/defaultdb?sslMode=REQUIRED", "avnadmin", "AVNS_jwoNr6orQRJ8JWL9863");

                                String query = "SELECT * FROM marks WHERE enrollment_no = ?";
                                PreparedStatement ps = conn.prepareStatement(query);
                                ps.setString(1, enrollmentNo);
                                ResultSet rs = ps.executeQuery();

                                // Flag check karne ke liye ki data mila ya nahi
                                boolean hasData = false;
                                while(rs.next()) {
                                    hasData = true;
                                    int total = rs.getInt("total_marks");
                                    // Agar marks 40 se kam hain toh red highlight
                                    String gradeClass = (total < 40) ? "low-attendance" : ""; 
                        %>
                        <tr>
                            <td><%= rs.getString("subject_code") %></td>
                            <td><%= rs.getString("subject_name") %></td>
                            <td><%= rs.getInt("internal_marks") %></td>
                            <td><%= rs.getInt("external_marks") %></td>
                            <td style="font-weight: bold; color: #2e7d32;"><%= total %></td>
                            <td>
                                <span class="status-tag <%= gradeClass %>">
                                    <%= rs.getString("grade") %>
                                </span>
                            </td>
                        </tr>
                        <%
                                }
                                if(!hasData) {
                                    out.println("<tr><td colspan='6' style='text-align:center;'>No marks found for this Enrollment ID.</td></tr>");
                                }
                                conn.close();
                            } catch (Exception e) {
                                out.println("Error: " + e.getMessage());
                                e.printStackTrace();
                            }
                        %>
                    </tbody>
                </table>
            </div>

            <div class="importance-section">
                <p><strong>Note:</strong> In case of any discrepancy in the marks, please contact the examination department or your subject coordinator within 7 working days.</p>
            </div>
            
        </div>
    </div>

</body>
</html>