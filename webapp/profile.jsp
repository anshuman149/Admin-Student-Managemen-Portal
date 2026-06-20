<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/profile-style.css">

<style>
.profile-card-container {
    display: flex;
    background: #fff;
    max-width: 950px;
    margin: 20px auto;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    overflow: hidden;
    border-top: 5px solid #4CAF50;
}
.profile-left {
    flex: 1;
    background: #fcfcfc;
    padding: 40px 20px;
    text-align: center;
    border-right: 1px solid #eee;
    display: flex;
    flex-direction: column;
    align-items: center;
}
.profile-img {
    width: 150px;
    height: 150px;
    border-radius: 50%;
    border: 3px solid #4CAF50;
    padding: 5px;
    object-fit: cover;
    margin-bottom: 15px;
}
.enroll-box {
    font-weight: bold;
    color: #333;
    font-size: 14px;
    margin-top: 10px;
    background: #e8f5e9;
    padding: 5px 15px;
    border-radius: 20px;
}
.status-tag { color: #666; font-size: 13px; margin-top: 8px; }
.profile-right { flex: 2; padding: 30px 40px; }
.profile-data-table { width: 100%; border-collapse: collapse; }
.profile-data-table tr { border-bottom: 1px solid #f1f1f1; }
.data-label { font-weight: 700; color: #555; padding: 15px 0; width: 40%; font-size: 15px; }
.data-value { color: #222; padding: 15px 0; width: 60%; font-size: 15px; }
.address-text { line-height: 1.5; color: #444; }
</style>

<div class="main">
    <jsp:include page="sidebar.jsp"/>

    <div class="content">
        <h2 style="color:#333; margin-left: 20px; margin-top: 20px;">Student Personal Details</h2>
        
        <div class="profile-card-container">
            <div class="profile-left">
                <img src="images/Profile.jpg" class="profile-img" alt="Student">
                <div class="enroll-box">
                    COURSE: <%= session.getAttribute("course") %>
                </div>
                <p class="status-tag">SEM: <%= session.getAttribute("semester") %></p>
            </div>

            <div class="profile-right">
                <table class="profile-data-table">
                    <tr>
                        <td class="data-label">Full Name:</td>
                        <td class="data-value"><%= session.getAttribute("fullName") %></td>
                    </tr>
                    <tr>
                        <td class="data-label">Email Address:</td>
                        <td class="data-value" style="text-transform: none;"><%= session.getAttribute("email") %></td>
                    </tr>
                    <tr>
                        <td class="data-label">Phone Number:</td>
                        <td class="data-value"><%= session.getAttribute("phone") %></td>
                    </tr>
                    <tr>
                        <td class="data-label">Personal Address:</td>
                        <td class="data-value address-text"><%= session.getAttribute("pAddress") %></td>
                    </tr>
                    <tr>
                        <td class="data-label">Study Centre Code:</td>
                        <td class="data-value" style="color: #d32f2f;">
                            <%= (session.getAttribute("sCode") == null) ? "PENDING" : session.getAttribute("sCode") %>
                        </td>
                    </tr>
                    <tr>
                        <td class="data-label">Centre Location:</td>
                        <td class="data-value address-text">
                            <%= (session.getAttribute("sAddress") == null) ? "NOT ALLOTTED" : session.getAttribute("sAddress") %>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>