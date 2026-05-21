<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<jsp:include page="header.jsp" />

<div class="main" style="display: flex; min-height: 100vh;">
    <jsp:include page="sidebar.jsp" />

    <div class="attendance-page-content">
        <h2 class="attendance-title">Academic Attendance</h2>

        <div class="attendance-wrapper">
            <table class="attn-table">
                <thead>
                    <tr>
                        <th>Code</th>
                        <th>Subject Name</th>
                        <th>Total</th>
                        <th>Attended</th>
                        <th>Percentage</th>
                    </tr>
                </thead>
                <tbody>
                <%
                    try {
                        String enrollID = (String) session.getAttribute("enrollID");
                        if(enrollID == null) { response.sendRedirect("index.jsp"); }

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/student_portal", "root", "123456");

                        // Sahi Query
                        String sql = "SELECT * FROM attendance WHERE enrollment_no = ?";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.setString(1, enrollID);
                        ResultSet rs = ps.executeQuery();

                        boolean found = false;
                        while(rs.next()) {
                            found = true;
                            int total = rs.getInt("total_classes");
                            int attended = rs.getInt("attended_classes");
                            double pct = (total > 0) ? ((double)attended/total)*100 : 0;
                            String barColor = (pct < 75) ? "low-attendance" : "";
                %>
                    <tr>
                        <td><%= rs.getString("subject_code") %></td>
                        <td><%= rs.getString("subject_name") %></td>
                        <td><%= total %></td>
                        <td><%= attended %></td>
                        <td>
                            <b style="color:<%= (pct<75)?"#d9534f":"#2e7d32" %>"><%= String.format("%.1f", pct) %>%</b>
                            <div class="progress-bg"><div class="progress-fill <%= barColor %>" style="width:<%= pct %>%"></div></div>
                        </td>
                    </tr>
                <% 
                        }
                        if(!found) {
                            out.println("<tr><td colspan='5' style='text-align:center;'>No records found. Admin will update soon.</td></tr>");
                        }
                        con.close();
                    } catch(Exception e) { e.printStackTrace(); }
                %>
                </tbody>
            </table>
        </div>
        
        <div class="importance-section">
            <h4 style="margin-bottom:10px;">💡 Pro Tip:</h4>
            <p>Maintain above 75% attendance to avoid issues in Admit Card generation for TEE.</p>
        </div>
    </div>
</div>