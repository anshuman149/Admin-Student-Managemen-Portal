<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div class="main">
    <jsp:include page="sidebar.jsp" />
    <div class="content">
        <h2 style="color:#333;">My Certificates</h2>
        
        <div class="certificate-container" style="text-align: center; padding: 50px; background: white; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1); border-top: 5px solid #f39c12;">
            <img src="images/lock-icon.png" style="width: 100px; opacity: 0.5;" alt="Locked">
            <h3 style="color: #7f8c8d; margin-top: 20px;">No Certificates Generated Yet</h3>
            <p style="color: #95a5a6; font-size: 16px;">
                Your Degree/Diploma certificate will be automatically generated <br>
                <strong>after the successful completion of the full course (6 Semesters).</strong>
            </p>
            <div style="margin-top: 30px; padding: 10px; background: #fff3cd; color: #856404; display: inline-block; border-radius: 5px;">
                Current Status: <strong>In Progress</strong>
            </div>
        </div>
        
        <div class="news-section" style="margin-top: 30px; background: #fff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
            <h3 style="color: #2c3e50; border-bottom: 2px solid #3498db; display: inline-block;">📢 Latest News & Updates</h3>
            <ul style="list-style: none; padding: 0; margin-top: 15px;">
                <li style="padding: 10px 0; border-bottom: 1px solid #eee;">
                    <span style="color: #e74c3c; font-weight: bold;">[NEW]</span> June 2026 Term End Exam Hall Tickets are now available.
                </li>
                <li style="padding: 10px 0; border-bottom: 1px solid #eee;">
                    <span style="color: #3498db; font-weight: bold;">[UPDATE]</span> Last date for Re-Registration for July session extended to 30th April.
                </li>
                <li style="padding: 10px 0;">
                    <span style="color: #27ae60; font-weight: bold;">[INFO]</span> Practical Exam schedule for BCA/MCA Semester 4 will be out soon.
                </li>
            </ul>
        </div>
    </div>
</div>
</body>
</html>