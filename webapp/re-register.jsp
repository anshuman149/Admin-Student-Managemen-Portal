<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Re-Registration | Student Portal</title>
    <link rel="stylesheet" href="style.css">
    <style>
        .re-reg-card { background: white; max-width: 600px; margin: 30px auto; padding: 30px; border-radius: 12px; box-shadow: 0 5px 20px rgba(0,0,0,0.1); }
        .fee-form-group { margin-bottom: 20px; text-align: left; }
        .fee-form-group label { font-weight: bold; display: block; margin-bottom: 8px; color: #333; }
        .fee-form-group select, .fee-form-group input { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; font-size: 16px; }
        .pay-now-btn { background: #4CAF50; color: white; width: 100%; padding: 15px; border: none; border-radius: 6px; font-size: 18px; cursor: pointer; font-weight: bold; }
        .info-note { background: #e3f2fd; padding: 10px; border-radius: 5px; color: #0d47a1; font-size: 14px; margin-bottom: 20px; }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    <div class="main">
        <jsp:include page="sidebar.jsp" />
        
        <div class="content-area" style="width: 100%; padding-top: 20px;">
            <div class="re-reg-card">
                <h2 style="margin-bottom: 10px; color: #2e7d32;">Semester Re-Registration</h2>
                
                <%
                  
                    String semObj = (String) session.getAttribute("semester");
                    int currentSem = (semObj != null) ? Integer.parseInt(semObj) : 1;//this taje sem 1 as default
                %>
                
                <div class="info-note">
                    <strong>Current Status:</strong> Semester <%= currentSem %> 
                </div>

                <form action="payment.jsp" method="get">
                    <div class="fee-form-group">
                        <label>Select Semester for Re-registration:</label>
                        <select name="targetSemester" required>
                            <% 
                               for(int i=1; i<=8; i++) { 
                                   String selected = (i == currentSem + 1) ? "selected" : "";
                            %>
                                <option value="<%= i %>" <%= selected %>>Semester <%= i %></option>
                            <% } %>
                        </select>
                    </div>

                    <div class="fee-form-group">
                        <label>Fee Type:</label>
                        <input type="text" name="feeType" value="Semester Tuition Fee" readonly>
                    </div>

                    <div class="fee-form-group">
                        <label>Enter Amount (₹):</label>
                        <input type="number" name="amt" placeholder="Enter amount (e.g. 7500)" required>
                    </div>

                    <button type="submit" class="pay-now-btn">Proceed to QR Payment</button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>